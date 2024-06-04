import '../auth/registration_response_model.dart';

class DpsListResponseModel {
  DpsListResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      MainData? data}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  DpsListResponseModel.fromJson(dynamic json) {
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
      AllDps? allDps,}){
    _allDps = allDps;
}

  MainData.fromJson(dynamic json) {
    _allDps = json['all_dps'] != null ? AllDps.fromJson(json['all_dps']) : null;
  }

  AllDps? _allDps;
  AllDps? get allDps => _allDps;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_allDps != null) {
      map['all_dps'] = _allDps?.toJson();
    }
    return map;
  }

}

class AllDps {
  AllDps({
      List<Data>? data,
      dynamic nextPageUrl, 
      String? path}){
    _data = data;
    _nextPageUrl = nextPageUrl;
    _path = path;
}

  AllDps.fromJson(dynamic json) {
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
  String? _path;

  List<Data>? get data => _data;
  dynamic get nextPageUrl => _nextPageUrl;
  String? get path => _path;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['next_page_url'] = _nextPageUrl;
    map['path'] = _path;
    return map;
  }

}


class Data {
  Data({
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
      String? dueInstallmentsCount, 
      NextInstallment? nextInstallment, 
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
    _dueInstallmentsCount = dueInstallmentsCount;
    _nextInstallment = nextInstallment;
    _plan = plan;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _dpsNumber = json['dps_number'].toString();
    _userId = json['user_id'].toString();
    _planId = json['plan_id'].toString();
    _perInstallment = json['per_installment'].toString();
    _interestRate = json['interest_rate'].toString();
    _installmentInterval = json['installment_interval'].toString();
    _delayValue = json['delay_value'].toString();
    _chargePerInstallment = json['charge_per_installment'].toString();
    _delayCharge = json['delay_charge'].toString();
    _givenInstallment = json['given_installment'].toString();
    _totalInstallment = json['total_installment'].toString();
    _status = json['status'].toString();
    _withdrawnAt = json['withdrawn_at'].toString();
    _dueNotificationSent = json['due_notification_sent'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _dueInstallmentsCount = json['due_installments_count'].toString();
    _nextInstallment = json['next_installment'] != null ? NextInstallment.fromJson(json['next_installment']) : null;
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
  String? _dueInstallmentsCount;
  NextInstallment? _nextInstallment;
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
  String? get dueInstallmentsCount => _dueInstallmentsCount;
  NextInstallment? get nextInstallment => _nextInstallment;
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
    map['due_installments_count'] = _dueInstallmentsCount;
    if (_nextInstallment != null) {
      map['next_installment'] = _nextInstallment?.toJson();
    }
    if (_plan != null) {
      map['plan'] = _plan?.toJson();
    }
    return map;
  }

}

class Plan {
  Plan({
      int? id, 
      String? name, 
      String? perInstallment, 
      String? installmentInterval, 
      String? totalInstallment, 
      String? interestRate, 
      String? finalAmount, 
      String? delayValue, 
      String? fixedCharge, 
      String? percentCharge, 
      String? status, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _perInstallment = perInstallment;
    _installmentInterval = installmentInterval;
    _totalInstallment = totalInstallment;
    _interestRate = interestRate;
    _finalAmount = finalAmount;
    _delayValue = delayValue;
    _fixedCharge = fixedCharge;
    _percentCharge = percentCharge;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Plan.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _perInstallment = json['per_installment'].toString();
    _installmentInterval = json['installment_interval'].toString();
    _totalInstallment = json['total_installment'].toString();
    _interestRate = json['interest_rate'].toString();
    _finalAmount = json['final_amount'].toString();
    _delayValue = json['delay_value'].toString();
    _fixedCharge = json['fixed_charge'].toString();
    _percentCharge = json['percent_charge'].toString();
    _status = json['status'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _name;
  String? _perInstallment;
  String? _installmentInterval;
  String? _totalInstallment;
  String? _interestRate;
  String? _finalAmount;
  String? _delayValue;
  String? _fixedCharge;
  String? _percentCharge;
  String? _status;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get name => _name;
  String? get perInstallment => _perInstallment;
  String? get installmentInterval => _installmentInterval;
  String? get totalInstallment => _totalInstallment;
  String? get interestRate => _interestRate;
  String? get finalAmount => _finalAmount;
  String? get delayValue => _delayValue;
  String? get fixedCharge => _fixedCharge;
  String? get percentCharge => _percentCharge;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['per_installment'] = _perInstallment;
    map['installment_interval'] = _installmentInterval;
    map['total_installment'] = _totalInstallment;
    map['interest_rate'] = _interestRate;
    map['final_amount'] = _finalAmount;
    map['delay_value'] = _delayValue;
    map['fixed_charge'] = _fixedCharge;
    map['percent_charge'] = _percentCharge;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

class NextInstallment {
  NextInstallment({
      int? id, 
      String? installmentableType, 
      String? installmentableId, 
      String? delayCharge, 
      String? installmentDate, 
      dynamic givenAt}){
    _id = id;
    _installmentableType = installmentableType;
    _installmentableId = installmentableId;
    _delayCharge = delayCharge;
    _installmentDate = installmentDate;
    _givenAt = givenAt;
}

  NextInstallment.fromJson(dynamic json) {
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
  dynamic _givenAt;

  int? get id => _id;
  String? get installmentableType => _installmentableType;
  String? get installmentableId => _installmentableId;
  String? get delayCharge => _delayCharge;
  String? get installmentDate => _installmentDate;
  dynamic get givenAt => _givenAt;

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