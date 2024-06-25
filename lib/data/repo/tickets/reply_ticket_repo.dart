import 'package:eastern_trust/core/utils/method.dart';
import 'package:eastern_trust/core/utils/url.dart';
import 'package:eastern_trust/data/controller/tickets/reply_ticket_controller.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:eastern_trust/data/repo/tickets/ticket_list_repo.dart';
import 'package:http/http.dart' as http;
import '../../../core/utils/my_strings.dart';
import '../../../views/components/snackbar/show_custom_snackbar.dart';
import 'create_ticket_repo.dart';

class ReplyTicketRepo {

  ApiClient apiClient;
  ReplyTicketRepo({required this.apiClient});

  Future<ResponseModel> getViewTicket({String ticketId = ""}) async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.viewTicketUrl}/$ticketId";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<bool> submitReply(ReplyData ticketData) async {
    try{
      apiClient.initToken();
      String url = '${UrlContainer.baseUrl}${UrlContainer.replyTicketUrl}/${ticketData.ticketId}';
      var request=http.MultipartRequest('POST',Uri.parse(url));
      // List<String> filesData = [];
      Map<String,String>finalMap={
        'message': ticketData.messageStr,
      };

      request.headers.addAll(<String,String>{'Authorization' : 'Bearer ${apiClient.token}'});
      if(ticketData.selectedFilesData != null){
        for (var file in ticketData.selectedFilesData!) {
          request.files.add( http.MultipartFile('attachments[]',
              file.readAsBytes().asStream(),
              file.lengthSync(),
              filename: file.path.split('/').last));

        }
      }
      request.fields.addAll(finalMap);
      http.StreamedResponse response = await request.send();
      String jsonResponse=await response.stream.bytesToString();

      CreateTicketModel model = CreateTicketModel.fromJson(jsonDecode(jsonResponse));

      if(model.status?.toLowerCase()==MyStrings.success.toLowerCase()){
        CustomSnackBar.success(successList: model.message?.success??[MyStrings.success]);
        return true;
      }else{
        CustomSnackBar.error(errorList: model.message?.error??[MyStrings.requestFail]);
        return false;
      }
    }catch(e){
      return false;
    }
  }

  Future<ResponseModel> closeTicket({String ticketId = ""}) async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.closeTicketUrl}/$ticketId";
    ResponseModel responseModel = await apiClient.request(url, Method.postMethod, null, passHeader: true);
    return responseModel;
  }

}



// Reply Ticket  Model

// Function to convert a JSON string to a Response object
ViewReplyTicketModel responseFromReplyTicket(String str) => ViewReplyTicketModel.fromJson(json.decode(str));
// Function to convert a Response object to a JSON string
String responseToJson(ViewReplyTicketModel data) => json.encode(data.toJson());

class ViewReplyTicketModel {
  String status;
  String remark;
  ReplyTicketData data;

  ViewReplyTicketModel({
    required this.status,
    required this.remark,
    required this.data,
  });

  factory ViewReplyTicketModel.fromJson(Map<String, dynamic> json) {
    return ViewReplyTicketModel(
      status: json['status'] ?? '',
      remark: json['remark'] ?? '',
      data: ReplyTicketData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'remark': remark,
      'data': data.toJson(),
    };
  }

  // Helper methods to check if fields have values
}
class SuccessMessage {
  List<String> success;

  SuccessMessage({required this.success});

  factory SuccessMessage.fromJson(Map<String, dynamic> json) => SuccessMessage(
    success: List<String>.from(json["success"]?.map((x) => x) ?? []),
  );

  Map<String, dynamic> toJson() => {
    "success": List<dynamic>.from(success.map((x) => x)),
  };
  // Helper method to check if success has values
  bool hasSuccess() => success.isNotEmpty;
}
class ReplyTicketData {
  Ticket? myTicket;
  List<MessageReply>? messages;

  ReplyTicketData({
     this.myTicket,
     this.messages,
  });

  factory ReplyTicketData.fromJson(Map<String, dynamic> json) {
    return ReplyTicketData(
      myTicket: Ticket.fromJson(json['myTicket'] ?? {}),
      messages: (json['messages'] as List?)
          ?.map((i) => MessageReply.fromJson(i))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'myTicket': myTicket?.toJson(),
      'messages': messages?.map((i) => i.toJson()).toList(),
    };
  }
}
class MessageReply {
  int id;
  int supportTicketId;
  int adminId;
  String message;
  DateTime createdAt;
  DateTime updatedAt;
  Ticket ticket;
  Ticket admin; // Since admin is null, you can use dynamic or define an Admin model if needed.
  List<Attachment> attachments;

  MessageReply({
    required this.id,
    required this.supportTicketId,
    required this.adminId,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
    required this.ticket,
    required this.admin,
    required this.attachments,
  });

  factory MessageReply.fromJson(Map<String, dynamic> json) {
    return MessageReply(
      id: json['id'] ?? 0,
      supportTicketId: json['support_ticket_id'] ?? 0,
      adminId: json['admin_id'] ?? 0,
      message: json['message'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      ticket: Ticket.fromJson(json['ticket'] ?? {}),
      admin: Ticket.fromJson(json['admin'] ?? {}),
      attachments: (json['attachments'] as List?)
          ?.map((i) => Attachment.fromJson(i))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'support_ticket_id': supportTicketId,
      'admin_id': adminId,
      'message': message,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'ticket': ticket.toJson(),
      'admin': admin.toJson(),
      'attachments': attachments.map((i) => i.toJson()).toList(),
    };
  }
}
class Attachment {
  int id;
  int supportMessageId;
  String attachment;
  DateTime createdAt;
  DateTime updatedAt;

  Attachment({
    required this.id,
    required this.supportMessageId,
    required this.attachment,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      id: json['id'] ?? 0,
      supportMessageId: json['support_message_id'] ?? 0,
      attachment: json['attachment'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'support_message_id': supportMessageId,
      'attachment': attachment,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}


// Close Ticket Model

// Function to convert a JSON string to a Response object
CloseTicketModel responseFromJsonCloseTicket(String str) => CloseTicketModel.fromJson(json.decode(str));
// Function to convert a Response object to a JSON string
String responseToJsonCloseTicket(CloseTicketModel data) => json.encode(data.toJson());

class CloseTicketModel {
  final String status;
  final CloseMessage message;
  final String remark;

  CloseTicketModel({
    required this.status,
    required this.message,
    required this.remark,
  });

  factory CloseTicketModel.fromJson(Map<String, dynamic> json) {
    return CloseTicketModel(
      status: json['status'],
      message: CloseMessage.fromJson(json['message']),
      remark: json['remark'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message.toJson(),
      'remark': remark,
    };
  }
}
class CloseMessage {
  final List<List<String>> success;

  CloseMessage({
    required this.success,
  });

  factory CloseMessage.fromJson(Map<String, dynamic> json) {
    var successList = json['success'] as List;
    List<List<String>> success = successList.map((i) => List<String>.from(i)).toList();

    return CloseMessage(
      success: success,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
    };
  }
}
