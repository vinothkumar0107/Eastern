import '../auth/registration_response_model.dart';

class AuthorizationResponseModel {
  AuthorizationResponseModel({
      String? remark, 
      String? status, 
      Message? message,
      Data? data}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  AuthorizationResponseModel.fromJson(dynamic json) {
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
