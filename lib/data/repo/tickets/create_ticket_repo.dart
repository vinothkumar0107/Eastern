import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:eastern_trust/core/helper/shared_preference_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:eastern_trust/core/utils/method.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/url.dart';
import 'package:eastern_trust/data/model/auth/verification/email_verification_model.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';
import 'package:eastern_trust/data/controller/tickets/create_ticket_controller.dart';

import '../../../core/utils/my_images.dart';
import '../../../views/components/bottom_sheet/custom_bottom_notification.dart';

class CreateTicketRepo {
  ApiClient apiClient;
  CreateTicketRepo({required this.apiClient});

  String getPriorityStatusCode(String priority) {
    switch (priority) {
      case MyStrings.low:
        return "1";
      case MyStrings.medium:
        return "2";
      case MyStrings.high:
        return "3";
      default:
        return '';
    }
  }


  Future<SubmitTicketResponse> submitCreateTicket(CreateTicketData ticketData) async {
    try{
      apiClient.initToken();
      String url = '${UrlContainer.baseUrl}${UrlContainer.createTicketUrl}';
      var request=http.MultipartRequest('POST',Uri.parse(url));
      // List<String> filesData = [];
      Map<String,String>finalMap={
        'subject': ticketData.subjectStr,
        'message': ticketData.messageStr,
        'priority': getPriorityStatusCode(ticketData.priorityStr),
      };

      request.headers.addAll(<String,String>{'Authorization' : 'Bearer ${apiClient.token}'});
      if(ticketData.selectedFilesData != null){
        for (var file in ticketData.selectedFilesData!) {
          // request.files.add(await http.MultipartFile.fromPath(
          //   'attachments_${file.path.split('/').last}', // The name of the form field on your server
          //   file.path,
          // ));
          request.files.add( http.MultipartFile('attachments[]',
              file.readAsBytes().asStream(),
              file.lengthSync(),
              filename: file.path.split('/').last));
          // String base64File = base64Encode(await file.readAsBytes());
          // filesData.add(base64File);
        }
        // String jsonString = jsonEncode(filesData);
        // finalMap['attachments'] =  jsonString;
        // print('finalMap params ==> $finalMap');
      }
      request.fields.addAll(finalMap);
      http.StreamedResponse response = await request.send();
      String jsonResponse=await response.stream.bytesToString();

      CreateTicketModel model = CreateTicketModel.fromJson(jsonDecode(jsonResponse));

      if(model.status?.toLowerCase()==MyStrings.success.toLowerCase()){
        // CustomSnackBar.success(successList: model.message?.success??[MyStrings.success]);
        // return true;
        return SubmitTicketResponse(status: true, ticketModel: model);
      }else{
        CustomSnackBar.error(errorList: model.message?.error??[MyStrings.requestFail]);
        // return false;
        return SubmitTicketResponse(status: false, ticketModel: model);
      }
    }catch(e){
      // return false;
      return SubmitTicketResponse(status: false, ticketModel: null);
    }
  }

}


// Create Ticket Model

class CreateTicketModel {
  CreateTicketModel({
    String? remark,
    String? status,
    Message? message,
    Data? data}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
  }

  CreateTicketModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status'];
    _message = json['message'] != null ? Message.fromJson(json['message']) : null;
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  String? _remark;
  String? _status;
  Message? _message;
  Data? _data;

  String? get remark => _remark;
  String? get status => _status;
  Message? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remark'] = _remark;
    map['status'] = _status;
    if (_message != null) {
      map['message'] = _message?.toJson();
    }
    return map;
  }

}
class Message {
  Message({
    List<String>? success,
    List<String>? error,
  }){
    _success = success;
    _error=error;
  }

  Message.fromJson(dynamic json) {
    _success = json['success'] != null ?[json['success'].toString()]:null;
    _error = json['error'] != null ? [json['error'].toString()] :null;
  }
  List<String>? _success;
  List<String>? _error;

  List<String>? get success => _success;
  List<String>? get error => _error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['error'] = _error;
    return map;
  }

}
class Data {
  Data({
    String? trx,
    String? otpId,
    String? verificationId
  }){
    _trx = trx;
    _otpId = otpId;
    _verificationId = verificationId;
  }

  Data.fromJson(dynamic json) {
    _trx = json['trx'] != null ? json['trx'].toString() : '';
    _otpId = json['otpId'] != null ? json['otpId'].toString() : '';
    _verificationId = json['verificationId'] != null ? json['verificationId'].toString() : '';
  }

  String? _trx;
  String? _otpId;
  String? _verificationId;

  String? get trx => _trx;
  String? get otpId => _otpId;
  String? get verificationId => _verificationId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['trx'] = _trx;
    map['otpId'] = _otpId;
    map['verificationId'] = _verificationId;
    return map;
  }

}

class SubmitTicketResponse {
  final bool status;
  final CreateTicketModel? ticketModel;

  SubmitTicketResponse({
    required this.status,
    this.ticketModel,
  });
}