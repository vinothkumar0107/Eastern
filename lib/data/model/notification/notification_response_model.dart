
import '../auth/registration_response_model.dart';

class NotificationResponseModel {
  NotificationResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      MainData? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  NotificationResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status'];
    _message = json['message'] != null ? Message.fromJson(json['message']) : null;
    _data = json['data'] != null ? MainData.fromJson(json['data']) : null;
  }
  String? _remark;
  String? _status;
  Message? _message;
  MainData? _data;

  String? get remark => _remark;
  String? get status => _status;
  Message? get message => _message;
  MainData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remark'] = _remark;
    map['status'] = _status;
    if (_message != null) {
      map['message'] = _message?.toJson();
    }
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

class MainData {
  MainData({
      Notifications? notifications,}){
    _notifications = notifications;
}

  MainData.fromJson(dynamic json) {
    _notifications = json['notifications'] != null ? Notifications.fromJson(json['notifications']) : null;
  }
  Notifications? _notifications;

  Notifications? get notifications => _notifications;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_notifications != null) {
      map['notifications'] = _notifications?.toJson();
    }
    return map;
  }

}

class Notifications {
  Notifications({
      List<Data>? data,
      String? nextPageUrl}){
    _data = data;
    _nextPageUrl = nextPageUrl;
}

  Notifications.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _nextPageUrl = json['next_page_url'];
  }

  List<Data>? _data;
  String? _nextPageUrl;

  List<Data>? get data => _data;
  String? get nextPageUrl => _nextPageUrl;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['next_page_url'] = _nextPageUrl;
    return map;
  }

}


class Data {
  Data({
      int? id,
      String? title, 
      String? remark, 
      dynamic clickValue, 
      String? view,
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _title = title;
    _remark = remark;
    _clickValue = clickValue;
    _view = view;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title']!=null?json['title'].toString():'';
    _remark = json['remark']!=null?json['remark'].toString():'';
    _clickValue = json['click_value'].toString();
    _view = json['view'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  int? _userId;
  String? _title;
  String? _remark;
  dynamic _clickValue;
  String? _view;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  int? get userId => _userId;
  String? get title => _title;
  String? get remark => _remark;
  dynamic get clickValue => _clickValue;
  String? get view => _view;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['title'] = _title;
    map['remark'] = _remark;
    map['click_value'] = _clickValue;
    map['view'] = _view;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}
