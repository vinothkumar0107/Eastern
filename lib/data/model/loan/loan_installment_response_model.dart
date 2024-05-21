import 'package:flutter/foundation.dart';

import '../auth/registration_response_model.dart';

class LoanInstallmentResponseModel {
  LoanInstallmentResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      MainData? data}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  LoanInstallmentResponseModel.fromJson(dynamic json) {
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
      Loan? loan,}){
    _installments = installments;
    _loan = loan;
}

  MainData.fromJson(dynamic json) {
    _installments = json['installments'] != null ? Installments.fromJson(json['installments']) : null;
    _loan = json['loan'] != null ? Loan.fromJson(json['loan']) : null;
  }
  Installments? _installments;
  Loan? _loan;

  Installments? get installments => _installments;
  Loan? get loan => _loan;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_installments != null) {
      map['installments'] = _installments?.toJson();
    }
    if (_loan != null) {
      map['loan'] = _loan?.toJson();
    }
    return map;
  }

}

class Loan {
  Loan({
      int? id, 
      String? loanNumber, 
      String? userId, 
      String? planId, 
      String? amount, 
      String? perInstallment, 
      String? installmentInterval, 
      String? delayValue, 
      String? chargePerInstallment, 
      String? delayCharge, 
      String? givenInstallment, 
      String? totalInstallment, 
      List<ApplicationForm>? applicationForm, 
      dynamic adminFeedback, 
      String? status, 
      dynamic dueNotificationSent, 
      dynamic approvedAt, 
      String? createdAt, 
      String? updatedAt, 
      Plan? plan,}){
    _id = id;
    _loanNumber = loanNumber;
    _userId = userId;
    _planId = planId;
    _amount = amount;
    _perInstallment = perInstallment;
    _installmentInterval = installmentInterval;
    _delayValue = delayValue;
    _chargePerInstallment = chargePerInstallment;
    _delayCharge = delayCharge;
    _givenInstallment = givenInstallment;
    _totalInstallment = totalInstallment;
    _applicationForm = applicationForm;
    _adminFeedback = adminFeedback;
    _status = status;
    _dueNotificationSent = dueNotificationSent;
    _approvedAt = approvedAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _plan = plan;
}

  Loan.fromJson(dynamic json) {
    _id = json['id'];
    _loanNumber = json['loan_number'].toString();
    _userId = json['user_id'].toString();
    _planId = json['plan_id'].toString();
    _amount = json['amount']!=null?json['amount'].toString():'';
    _perInstallment = json['per_installment'].toString();
    _installmentInterval = json['installment_interval'].toString();
    _delayValue = json['delay_value'].toString();
    _chargePerInstallment = json['charge_per_installment'].toString();
    _delayCharge = json['delay_charge'].toString();
    _givenInstallment = json['given_installment'].toString();
    _totalInstallment = json['total_installment'].toString();
    if (json['application_form'] != null) {
      _applicationForm = [];
      try{
        if(json['application_form'] is List<dynamic>){
          json['application_form'].forEach((v) {
            _applicationForm?.add(ApplicationForm.fromJson(v));
          });
        } else{
          var map=Map.from(json['application_form']).map((key, value) => MapEntry(key, value));
          List<ApplicationForm>?list=map.entries.map((e) =>
              ApplicationForm(
                  name: e.key??'',
                  type: e.value['type'],
                  value: e.value['value']
              )).toList();
          if(list.isNotEmpty){
            list.removeWhere((element) => element.toString().isEmpty);
            _applicationForm?.addAll(list);
          }
          _applicationForm;
        }
      }catch(e){
        if (kDebugMode) {
          print(e.toString());
        }
      }

    }
    _adminFeedback = json['admin_feedback'].toString();
    _status = json['status'].toString();
    _dueNotificationSent = json['due_notification_sent'].toString();
    _approvedAt = json['approved_at'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _plan = json['plan'] != null ? Plan.fromJson(json['plan']) : null;
  }
  int? _id;
  String? _loanNumber;
  String? _userId;
  String? _planId;
  String? _amount;
  String? _perInstallment;
  String? _installmentInterval;
  String? _delayValue;
  String? _chargePerInstallment;
  String? _delayCharge;
  String? _givenInstallment;
  String? _totalInstallment;
  List<ApplicationForm>? _applicationForm;
  dynamic _adminFeedback;
  String? _status;
  dynamic _dueNotificationSent;
  dynamic _approvedAt;
  String? _createdAt;
  String? _updatedAt;
  Plan? _plan;

  int? get id => _id;
  String? get loanNumber => _loanNumber;
  String? get userId => _userId;
  String? get planId => _planId;
  String? get amount => _amount;
  String? get perInstallment => _perInstallment;
  String? get installmentInterval => _installmentInterval;
  String? get delayValue => _delayValue;
  String? get chargePerInstallment => _chargePerInstallment;
  String? get delayCharge => _delayCharge;
  String? get givenInstallment => _givenInstallment;
  String? get totalInstallment => _totalInstallment;
  List<ApplicationForm>? get applicationForm => _applicationForm;
  dynamic get adminFeedback => _adminFeedback;
  String? get status => _status;
  dynamic get dueNotificationSent => _dueNotificationSent;
  dynamic get approvedAt => _approvedAt;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Plan? get plan => _plan;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['loan_number'] = _loanNumber;
    map['user_id'] = _userId;
    map['plan_id'] = _planId;
    map['amount'] = _amount;
    map['per_installment'] = _perInstallment;
    map['installment_interval'] = _installmentInterval;
    map['delay_value'] = _delayValue;
    map['charge_per_installment'] = _chargePerInstallment;
    map['delay_charge'] = _delayCharge;
    map['given_installment'] = _givenInstallment;
    map['total_installment'] = _totalInstallment;
    if (_applicationForm != null) {
      map['application_form'] = _applicationForm?.map((v) => v.toJson()).toList();
    }
    map['admin_feedback'] = _adminFeedback;
    map['status'] = _status;
    map['due_notification_sent'] = _dueNotificationSent;
    map['approved_at'] = _approvedAt;
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
    _name = json['name'];
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

class ApplicationForm {
  ApplicationForm({
      String? name, 
      String? type, 
      String? value,}){
    _name = name;
    _type = type;
    _value = value;
}

  ApplicationForm.fromJson(dynamic json) {
    _name = json['name'];
    _type = json['type'];
    _value = json['value'];
  }
  String? _name;
  String? _type;
  String? _value;

  String? get name => _name;
  String? get type => _type;
  String? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['type'] = _type;
    map['value'] = _value;
    return map;
  }

}

class Installments {
  Installments({
      List<Data>? data,
      dynamic nextPageUrl, 
      String? path,
      String? total}){
    _data = data;
    _nextPageUrl = nextPageUrl;
    _path = path;
    _total = total;
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
  String? _path;
  String? _total;

  List<Data>? get data => _data;
  dynamic get nextPageUrl => _nextPageUrl;
  String? get path => _path;
  String? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['next_page_url'] = _nextPageUrl;
    map['path'] = _path;
    map['total'] = _total;
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
    _delayCharge = json['delay_charge'].toString();
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