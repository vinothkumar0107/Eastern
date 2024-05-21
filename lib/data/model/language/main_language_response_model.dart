

import '../auth/registration_response_model.dart';

class MainLanguageResponseModel {
  MainLanguageResponseModel({
      this.remark, 
      this.status, 
      this.message, 
      this.data,});

  MainLanguageResponseModel.fromJson(dynamic json) {
    remark = json['remark'];
    status = json['status'];
    message = json['message'] != null ? Message.fromJson(json['message']) : null;
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  String? remark;
  String? status;
  Message? message;
  Data? data;

}

class Data {
  Data({
    required this.languages,
    required this.file,});

  Data.fromJson(dynamic json) {
    print('error: ${json['language_data'].toString()}');
    if (json['languages'] != null) {
      languages = [];
      json['languages'].forEach((v) {
        languages?.add(Languages.fromJson(v));
      });
    }
    file = json['language_data'].toString();
  }
  List<Languages>? languages;
  String? file;


}

class Languages {
  Languages({
    required this.id,
    required this.name,
    required this.code,
    required this.icon,
    required this.textAlign,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,});

  Languages.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    icon = json['icon'];
    textAlign = json['text_align'].toString();
    isDefault = json['is_default'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  int? id;
  String? name;
  String? code;
  String? icon;
  String? textAlign;
  String? isDefault;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['code'] = code;
    map['icon'] = icon;
    map['text_align'] = textAlign;
    map['is_default'] = isDefault;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}