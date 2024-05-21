import '../auth/registration_response_model.dart';

class DpsPreviewResponseModel {
  DpsPreviewResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      Data? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  DpsPreviewResponseModel.fromJson(dynamic json) {
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
      String? verificationId,
      String? delayCharge,}){
    _plan = plan;
    _verificationId = verificationId;
    _delayCharge = delayCharge;
}

  Data.fromJson(dynamic json) {
    _plan = json['plan'] != null ? Plan.fromJson(json['plan']) : null;
    _verificationId = json['verificationId']!=null?json['verificationId'].toString():'';
    _delayCharge = json['delay_charge'] !=null? json['delay_charge'].toString():'';
  }
  Plan? _plan;
  String? _verificationId;
  String? _delayCharge;

  Plan? get plan => _plan;
  String? get verificationId => _verificationId;
  String? get delayCharge => _delayCharge;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_plan != null) {
      map['plan'] = _plan?.toJson();
    }
    map['verificationId'] = _verificationId;
    map['delay_charge'] = _delayCharge;
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
    _name = json['name'].toString();
    _perInstallment = json['per_installment']!=null?json['per_installment'].toString():'';
    _installmentInterval = json['installment_interval'] !=null?json['installment_interval'].toString():'';
    _totalInstallment = json['total_installment'] !=null?json['total_installment'].toString():'';
    _interestRate = json['interest_rate'] !=null?json['interest_rate'].toString():'';
    _finalAmount = json['final_amount'] !=null?json['final_amount'].toString():'';
    _delayValue = json['delay_value'] !=null?json['delay_value'].toString():'';
    _fixedCharge = json['fixed_charge'] !=null?json['fixed_charge'].toString():'';
    _percentCharge = json['percent_charge'] !=null?json['percent_charge'].toString():'';
    _status = json['status'] !=null?json['status'].toString():'';
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