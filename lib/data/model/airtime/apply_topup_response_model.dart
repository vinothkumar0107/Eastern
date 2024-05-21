// To parse this JSON data, do
//
//     final operatorResponseModel = operatorResponseModelFromJson(jsonString);

import 'dart:convert';

ApplyTopUpResponseModel operatorResponseModelFromJson(String str) => ApplyTopUpResponseModel.fromJson(json.decode(str));


class ApplyTopUpResponseModel {
  String? remark;
  String? status;
  Message? message;

  ApplyTopUpResponseModel({
    this.remark,
    this.status,
    this.message,
  });

  factory ApplyTopUpResponseModel.fromJson(Map<String, dynamic> json) => ApplyTopUpResponseModel(
    remark: json["remark"],
    status: json["status"],
    message: json["message"] == null ? null : Message.fromJson(json["message"]),
  );
}

class Message {
  List<String>? success;
  List<String>? error;
  String? errorStr;

  Message({
    this.success,
    this.error,
    this.errorStr
  });

  factory Message.fromJson(Map<String, dynamic> json) {

    return Message(
        success: json["success"] == null ? [] : List<String>.from(json["success"]!.map((x) => x)),
        error: json["error"] == null ? [] : json["error"] is String ? [json["error"].toString()] : List<String>.from(json["error"]!.map((x) => x)),
        errorStr: json["error"]  != null ? json["error"].toString() : ""
    );
  }
}