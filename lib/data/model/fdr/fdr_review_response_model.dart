import '../auth/registration_response_model.dart';

class FdrPreviewResponseModel {
  FdrPreviewResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      Data? data}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  FdrPreviewResponseModel.fromJson(dynamic json) {
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
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      Plan? plan, 
      String? amount, 
      String? verificationId,
      String? withdrawAvailable,}){
    _plan = plan;
    _amount = amount;
    _verificationId = verificationId;
    _withdrawAvailable = withdrawAvailable;
}

  Data.fromJson(dynamic json) {
    _plan = json['plan'] != null ? Plan.fromJson(json['plan']) : null;
    _amount = json['amount'].toString();
    _otpId = json['otpId'] != null ? json['otpId'].toString() : '';
    _verificationId = json['verificationId'].toString();
    _withdrawAvailable = json['withdrawAvailable'].toString();
  }

  String? _otpId;
  Plan? _plan;
  String? _amount;
  String? _verificationId;
  String? _withdrawAvailable;

  Plan? get plan => _plan;
  String? get amount => _amount;
  String? get otpId => _otpId;
  String? get verificationId => _verificationId;
  String? get withdrawAvailable => _withdrawAvailable;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_plan != null) {
      map['plan'] = _plan?.toJson();
    }
    map['amount'] = _amount;
    map['otpId'] = _otpId;
    map['verificationId'] = _verificationId;
    return map;
  }

}

class Plan {
  Plan({
      int? id, 
      String? name, 
      String? minimumAmount, 
      String? maximumAmount, 
      String? installmentInterval, 
      String? interestRate, 
      String? lockedDays, 
      String? status, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _minimumAmount = minimumAmount;
    _maximumAmount = maximumAmount;
    _installmentInterval = installmentInterval;
    _interestRate = interestRate;
    _lockedDays = lockedDays;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Plan.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'].toString();
    _minimumAmount = json['minimum_amount']!=null? json['minimum_amount'].toString():'0';
    _maximumAmount = json['maximum_amount']!=null? json['maximum_amount'].toString():'';
    _installmentInterval = json['installment_interval']!=null? json['installment_interval'].toString():'';
    _interestRate = json['interest_rate']!=null? json['interest_rate'].toString():'';
    _lockedDays = json['locked_days'].toString();
    _status = json['status'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _name;
  String? _minimumAmount;
  String? _maximumAmount;
  String? _installmentInterval;
  String? _interestRate;
  String? _lockedDays;
  String? _status;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get name => _name;
  String? get minimumAmount => _minimumAmount;
  String? get maximumAmount => _maximumAmount;
  String? get installmentInterval => _installmentInterval;
  String? get interestRate => _interestRate;
  String? get lockedDays => _lockedDays;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['minimum_amount'] = _minimumAmount;
    map['maximum_amount'] = _maximumAmount;
    map['installment_interval'] = _installmentInterval;
    map['interest_rate'] = _interestRate;
    map['locked_days'] = _lockedDays;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}