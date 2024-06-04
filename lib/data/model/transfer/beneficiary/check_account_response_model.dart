import '../../auth/registration_response_model.dart';

class CheckAccountResponseModel {
  CheckAccountResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      Datum? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  CheckAccountResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status'];
    _message = json['message'] != null ? Message.fromJson(json['message']) : null;
    _data = json['data'] != null ? Datum.fromJson(json['data']) : null;
  }
  String? _remark;
  String? _status;
  Message? _message;
  Datum? _data;

  String? get remark => _remark;
  String? get status => _status;
  Message? get message => _message;
  Datum? get data => _data;

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

class Datum {
  Datum({
      User? user,}){
    _user = user;
}

  Datum.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  User? _user;

  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }

}

class User {
  User({
      String? accountNumber, 
      String? accountName,}){
    _accountNumber = accountNumber;
    _accountName = accountName;
}

  User.fromJson(dynamic json) {
    _accountNumber = json['account_number']!=null?json['account_number'].toString():'';
    _accountName = json['account_name']!=null?json['account_name'].toString():'';
  }
  String? _accountNumber;
  String? _accountName;

  String? get accountNumber => _accountNumber;
  String? get accountName => _accountName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['account_number'] = _accountNumber;
    map['account_name'] = _accountName;
    return map;
  }

}
