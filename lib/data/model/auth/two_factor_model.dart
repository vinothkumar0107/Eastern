
import 'dart:convert';

import 'package:get/get.dart';

GoogleAuthenticatorModel responseFromJson(String str) => GoogleAuthenticatorModel.fromJson(json.decode(str));

// Function to convert a Response object to a JSON string
String responseToJson(GoogleAuthenticatorModel data) => json.encode(data.toJson());

class GoogleAuthenticatorModel {
  final String status;
  final String remark;
  final String message;
  final GoogleAuthenticatorData data;

  GoogleAuthenticatorModel({
    required this.status,
    required this.remark,
    required this.data,
    required this.message,
  });

  factory GoogleAuthenticatorModel.fromJson(Map<String, dynamic> json) {


    return GoogleAuthenticatorModel(
      status: json['status'] ?? "",
      remark: json['remark'] ?? "",
      message: json['message'] ?? "",
      data: json["data"] != null ? GoogleAuthenticatorData.fromJson(json["data"]) : GoogleAuthenticatorData(secret: '', qrCodeUrl: ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'remark': remark,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class GoogleAuthenticatorData {
  final String secret;
  final String qrCodeUrl;

  GoogleAuthenticatorData({
    required this.secret,
    required this.qrCodeUrl,
  });

  factory GoogleAuthenticatorData.fromJson(Map<String, dynamic> json) {


    return GoogleAuthenticatorData(
      secret: json['secret'],
      qrCodeUrl: json['qrCodeUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'secret': secret,
      'qrCodeUrl': qrCodeUrl,
    };
  }
}



EnableGoogleAuthenticatorModel responseFromJsonEnable(String str) => EnableGoogleAuthenticatorModel.fromJson(json.decode(str));


// Enable google authenticate model

class EnableGoogleAuthenticatorModel {
  final String status;
  final String remark;
  final String message;

  EnableGoogleAuthenticatorModel({
    required this.status,
    required this.remark,
    required this.message,
  });

  factory EnableGoogleAuthenticatorModel.fromJson(Map<String, dynamic> json) {


    return EnableGoogleAuthenticatorModel(
      status: json['status'] ?? "",
      remark: json['remark'] ?? "",
      message: json['message'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'remark': remark,
      'message': message,
    };
  }
}