import 'package:eastern_trust/core/utils/method.dart';
import 'package:eastern_trust/core/utils/url.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

class TicketListRepo {

  ApiClient apiClient;
  TicketListRepo({required this.apiClient});

  Future<ResponseModel> getTicketListData(int page, {String searchText = ""}) async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.getTicketListUrl}";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

}



// Ticket List Model

// Function to convert a JSON string to a Response object
TicketListModel responseFromJson(String str) => TicketListModel.fromJson(json.decode(str));

// Function to convert a Response object to a JSON string
String responseToJson(TicketListModel data) => json.encode(data.toJson());

class TicketListModel {
  String status;
  Message message;
  String remark;
  Data data;

  TicketListModel({
    required this.status,
    required this.message,
    required this.remark,
    required this.data,
  });

  factory TicketListModel.fromJson(Map<String, dynamic> json) => TicketListModel(
    status: json["status"] ?? "",
    message: json["message"] != null ? Message.fromJson(json["message"]) : Message(success: []),
    remark: json["remark"] ?? "",
    data: json["data"] != null ? Data.fromJson(json["data"]) : Data(ticketData: TicketData.empty()),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message.toJson(),
    "remark": remark,
    "data": data.toJson(),
  };

  // Helper methods to check if fields have values
  bool hasMessage() => message.success.isNotEmpty;
  bool hasData() => data.ticketData.data.isNotEmpty;
}
class Message {
  List<String> success;

  Message({required this.success});

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    success: List<String>.from(json["success"]?.map((x) => x) ?? []),
  );

  Map<String, dynamic> toJson() => {
    "success": List<dynamic>.from(success.map((x) => x)),
  };

  // Helper method to check if success has values
  bool hasSuccess() => success.isNotEmpty;
}
class Data {
  TicketData ticketData;

  Data({required this.ticketData});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    ticketData: json["ticket_data"] != null ? TicketData.fromJson(json["ticket_data"]) : TicketData.empty(),
  );

  Map<String, dynamic> toJson() => {
    "ticket_data": ticketData.toJson(),
  };

  // Helper method to check if ticketData has values
  bool hasTicketData() => ticketData.data.isNotEmpty;
}
class TicketData {
  int currentPage;
  List<Ticket> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  String nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  TicketData({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory TicketData.fromJson(Map<String, dynamic> json) => TicketData(
    currentPage: json["current_page"] ?? 0,
    data: List<Ticket>.from(json["data"]?.map((x) => Ticket.fromJson(x)) ?? []),
    firstPageUrl: json["first_page_url"] ?? "",
    from: json["from"] ?? 0,
    lastPage: json["last_page"] ?? 0,
    lastPageUrl: json["last_page_url"] ?? "",
    links: List<Link>.from(json["links"]?.map((x) => Link.fromJson(x)) ?? []),
    nextPageUrl: json["next_page_url"] ?? "",
    path: json["path"] ?? "",
    perPage: json["per_page"] ?? 0,
    prevPageUrl: json["prev_page_url"],
    to: json["to"] ?? 0,
    total: json["total"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };

  factory TicketData.empty() => TicketData(
    currentPage: 0,
    data: [],
    firstPageUrl: "",
    from: 0,
    lastPage: 0,
    lastPageUrl: "",
    links: [],
    nextPageUrl: "",
    path: "",
    perPage: 0,
    prevPageUrl: null,
    to: 0,
    total: 0,
  );
}
class Ticket {
  int id;
  int userId;
  String name;
  String email;
  String ticket;
  String subject;
  int status;
  int priority;
  String lastReply;
  DateTime createdAt;
  DateTime updatedAt;

  Ticket({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.ticket,
    required this.subject,
    required this.status,
    required this.priority,
    required this.lastReply,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
    id: json["id"] ?? 0,
    userId: json["user_id"] ?? 0,
    name: json["name"] ?? "",
    email: json["email"] ?? "",
    ticket: json["ticket"] ?? "",
    subject: json["subject"] ?? "",
    status: json["status"] ?? 0,
    priority: json["priority"] ?? 0,
    lastReply: json["last_reply"] ?? '${DateTime.now()}',
    createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : DateTime.now(),
    updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "email": email,
    "ticket": ticket,
    "subject": subject,
    "status": status,
    "priority": priority,
    "last_reply": lastReply,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
class Link {
  dynamic url;
  String label;
  bool active;

  Link({
    this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"] ?? "",
    active: json["active"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
