import '../auth/registration_response_model.dart';

class DpsInstallmentLogResponseModel {
  DpsInstallmentLogResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      MainData? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  DpsInstallmentLogResponseModel.fromJson(dynamic json) {
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
      Installments? installments, 
      Dps? dps, 
      String? depositAmount,
      String? profitAmount,}){
    _installments = installments;
    _dps = dps;
    _depositAmount = depositAmount;
    _profitAmount = profitAmount;
}

  MainData.fromJson(dynamic json) {
    _installments = json['installments'] != null ? Installments.fromJson(json['installments']) : null;
    _dps = json['dps'] != null ? Dps.fromJson(json['dps']) : null;
    _depositAmount = json['depositAmount']!=null?json['depositAmount'].toString():'0';
    _profitAmount = json['profitAmount']!=null?json['profitAmount'].toString():'0';
  }
  Installments? _installments;
  Dps? _dps;
  String? _depositAmount;
  String? _profitAmount;

  Installments? get installments => _installments;
  Dps? get dps => _dps;
  String? get depositAmount => _depositAmount;
  String? get profitAmount => _profitAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_installments != null) {
      map['installments'] = _installments?.toJson();
    }
    if (_dps != null) {
      map['dps'] = _dps?.toJson();
    }
    map['depositAmount'] = _depositAmount;
    map['profitAmount'] = _profitAmount;
    return map;
  }

}

class Dps {
  Dps({
      int? id, 
      String? dpsNumber, 
      String? userId, 
      String? planId, 
      String? perInstallment, 
      String? interestRate, 
      String? installmentInterval, 
      String? delayValue, 
      String? chargePerInstallment, 
      String? delayCharge, 
      String? givenInstallment, 
      String? totalInstallment, 
      String? status, 
      dynamic withdrawnAt, 
      dynamic dueNotificationSent, 
      String? createdAt, 
      String? updatedAt, 
      Plan? plan,}){
    _id = id;
    _dpsNumber = dpsNumber;
    _userId = userId;
    _planId = planId;
    _perInstallment = perInstallment;
    _interestRate = interestRate;
    _installmentInterval = installmentInterval;
    _delayValue = delayValue;
    _chargePerInstallment = chargePerInstallment;
    _delayCharge = delayCharge;
    _givenInstallment = givenInstallment;
    _totalInstallment = totalInstallment;
    _status = status;
    _withdrawnAt = withdrawnAt;
    _dueNotificationSent = dueNotificationSent;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _plan = plan;
}

  Dps.fromJson(dynamic json) {
    _id = json['id'];
    _dpsNumber = json['dps_number'];
    _userId = json['user_id'];
    _planId = json['plan_id'];
    _perInstallment = json['per_installment'];
    _interestRate = json['interest_rate'];
    _installmentInterval = json['installment_interval'];
    _delayValue = json['delay_value'];
    _chargePerInstallment = json['charge_per_installment'];
    _delayCharge = json['delay_charge'];
    _givenInstallment = json['given_installment'];
    _totalInstallment = json['total_installment'];
    _status = json['status'];
    _withdrawnAt = json['withdrawn_at'];
    _dueNotificationSent = json['due_notification_sent'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _plan = json['plan'] != null ? Plan.fromJson(json['plan']) : null;
  }
  int? _id;
  String? _dpsNumber;
  String? _userId;
  String? _planId;
  String? _perInstallment;
  String? _interestRate;
  String? _installmentInterval;
  String? _delayValue;
  String? _chargePerInstallment;
  String? _delayCharge;
  String? _givenInstallment;
  String? _totalInstallment;
  String? _status;
  dynamic _withdrawnAt;
  dynamic _dueNotificationSent;
  String? _createdAt;
  String? _updatedAt;
  Plan? _plan;

  int? get id => _id;
  String? get dpsNumber => _dpsNumber;
  String? get userId => _userId;
  String? get planId => _planId;
  String? get perInstallment => _perInstallment;
  String? get interestRate => _interestRate;
  String? get installmentInterval => _installmentInterval;
  String? get delayValue => _delayValue;
  String? get chargePerInstallment => _chargePerInstallment;
  String? get delayCharge => _delayCharge;
  String? get givenInstallment => _givenInstallment;
  String? get totalInstallment => _totalInstallment;
  String? get status => _status;
  dynamic get withdrawnAt => _withdrawnAt;
  dynamic get dueNotificationSent => _dueNotificationSent;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Plan? get plan => _plan;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['dps_number'] = _dpsNumber;
    map['user_id'] = _userId;
    map['plan_id'] = _planId;
    map['per_installment'] = _perInstallment;
    map['interest_rate'] = _interestRate;
    map['installment_interval'] = _installmentInterval;
    map['delay_value'] = _delayValue;
    map['charge_per_installment'] = _chargePerInstallment;
    map['delay_charge'] = _delayCharge;
    map['given_installment'] = _givenInstallment;
    map['total_installment'] = _totalInstallment;
    map['status'] = _status;
    map['withdrawn_at'] = _withdrawnAt;
    map['due_notification_sent'] = _dueNotificationSent;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_plan != null) {
      map['plan'] = _plan?.toJson();
    }
    return map;
  }

}

class Plan {
  Plan({
      int? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  Plan.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name']!=null?json['name'].toString():'';
  }
  int? _id;
  String? _name;

  int? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}

class Installments {
  Installments({
      List<Data>? data,
      dynamic nextPageUrl}){
    _data = data;
    _nextPageUrl = nextPageUrl;
}

  Installments.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _nextPageUrl = json['next_page_url'];
  }

  List<Data>? _data;
  dynamic _nextPageUrl;

  List<Data>? get data => _data;
  dynamic get nextPageUrl => _nextPageUrl;

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
      String? installmentableType, 
      String? installmentableId, 
      String? delayCharge, 
      String? installmentDate, 
      String? givenAt,}){
    _id = id;
    _installmentableType = installmentableType;
    _installmentableId = installmentableId;
    _delayCharge = delayCharge;
    _installmentDate = installmentDate;
    _givenAt = givenAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _installmentableType = json['installmentable_type'].toString();
    _installmentableId = json['installmentable_id'].toString();
    _delayCharge = json['delay_charge']!=null?json['delay_charge'].toString():'';
    _installmentDate = json['installment_date'];
    _givenAt = json['given_at'];
  }
  int? _id;
  String? _installmentableType;
  String? _installmentableId;
  String? _delayCharge;
  String? _installmentDate;
  String? _givenAt;

  int? get id => _id;
  String? get installmentableType => _installmentableType;
  String? get installmentableId => _installmentableId;
  String? get delayCharge => _delayCharge;
  String? get installmentDate => _installmentDate;
  String? get givenAt => _givenAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['installmentable_type'] = _installmentableType;
    map['installmentable_id'] = _installmentableId;
    map['delay_charge'] = _delayCharge;
    map['installment_date'] = _installmentDate;
    map['given_at'] = _givenAt;
    return map;
  }

}

