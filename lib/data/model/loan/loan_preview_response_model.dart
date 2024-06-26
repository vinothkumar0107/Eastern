import 'dart:io';
import '../auth/registration_response_model.dart';
import '../dynamic_form/form.dart';

class LoanPreviewResponseModel {
  LoanPreviewResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      MainData? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  LoanPreviewResponseModel.fromJson(dynamic json) {
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
      Plan? plan, 
      String? amount,
      String? delayCharge,
      FormData? formData,}){
    _plan = plan;
    _amount = amount;
    _formData = formData;
    _delayCharge = delayCharge;
}

  MainData.fromJson(dynamic json) {
    _plan = json['plan'] != null ? Plan.fromJson(json['plan']) : null;
    _amount = json['amount'];
    _formData = json['form_data'] != null ? FormData.fromJson(json['form_data']['form_data']) : null;
    _delayCharge = json['delayCharge'] !=null? json['delayCharge'].toString():'';
  }
  Plan? _plan;
  String? _amount;
  FormData? _formData;
  String? _delayCharge;


  Plan? get plan => _plan;
  String? get amount => _amount;
  FormData? get formData => _formData;
  String? get delayCharge => _delayCharge;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_plan != null) {
      map['plan'] = _plan?.toJson();
    }
    map['amount'] = _amount;
    /*if (_formData != null) {
      map['form_data'] = _formData?.toJson();
    }*/
    return map;
  }

}





class Plan {
  Plan({
      int? id, 
      String? formId, 
      String? name, 
      String? minimumAmount, 
      String? maximumAmount, 
      String? perInstallment, 
      String? installmentInterval, 
      String? totalInstallment, 
      String? instruction, 
      String? delayValue, 
      String? fixedCharge, 
      String? percentCharge, 
      String? status, 
      String? createdAt, 
      String? updatedAt}){
    _id = id;
    _formId = formId;
    _name = name;
    _minimumAmount = minimumAmount;
    _maximumAmount = maximumAmount;
    _perInstallment = perInstallment;
    _installmentInterval = installmentInterval;
    _totalInstallment = totalInstallment;
    _instruction = instruction;
    _delayValue = delayValue;
    _fixedCharge = fixedCharge;
    _percentCharge = percentCharge;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Plan.fromJson(dynamic json) {
    _id = json['id'];
    _formId = json['form_id'].toString();
    _name = json['name'].toString();
    _minimumAmount = json['minimum_amount']!=null? json['minimum_amount'].toString():'0';
    _maximumAmount = json['maximum_amount']!=null? json['maximum_amount'].toString():'';
    _perInstallment = json['per_installment']!=null? json['per_installment'].toString():'';
    _installmentInterval = json['installment_interval']!=null? json['installment_interval'].toString():'';
    _totalInstallment = json['total_installment']!=null? json['total_installment'].toString():'';
    _instruction = json['instruction'].toString();
    _delayValue = json['delay_value']!=null? json['delay_value'].toString():'';
    _fixedCharge = json['fixed_charge']!=null? json['fixed_charge'].toString():'';
    _percentCharge = json['percent_charge']!=null? json['percent_charge'].toString():'';
    _status = json['status'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _formId;
  String? _name;
  String? _minimumAmount;
  String? _maximumAmount;
  String? _perInstallment;
  String? _installmentInterval;
  String? _totalInstallment;
  String? _instruction;
  String? _delayValue;
  String? _fixedCharge;
  String? _percentCharge;
  String? _status;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get formId => _formId;
  String? get name => _name;
  String? get minimumAmount => _minimumAmount;
  String? get maximumAmount => _maximumAmount;
  String? get perInstallment => _perInstallment;
  String? get installmentInterval => _installmentInterval;
  String? get totalInstallment => _totalInstallment;
  String? get instruction => _instruction;
  String? get delayValue => _delayValue;
  String? get fixedCharge => _fixedCharge;
  String? get percentCharge => _percentCharge;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['form_id'] = _formId;
    map['name'] = _name;
    map['minimum_amount'] = _minimumAmount;
    map['maximum_amount'] = _maximumAmount;
    map['per_installment'] = _perInstallment;
    map['installment_interval'] = _installmentInterval;
    map['total_installment'] = _totalInstallment;
    map['instruction'] = _instruction;
    map['delay_value'] = _delayValue;
    map['fixed_charge'] = _fixedCharge;
    map['percent_charge'] = _percentCharge;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

