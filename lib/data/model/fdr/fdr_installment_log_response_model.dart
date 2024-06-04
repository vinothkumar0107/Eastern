
import '../auth/registration_response_model.dart';

class FdrInstallmentLogResponseModel {
  FdrInstallmentLogResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      MainData? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  FdrInstallmentLogResponseModel.fromJson(dynamic json) {
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
      Fdr? fdr, 
      String? interestRate,}){
    _installments = installments;
    _fdr = fdr;
    _interestRate = interestRate;
}

  MainData.fromJson(dynamic json) {
    _installments = json['installments'] != null ? Installments.fromJson(json['installments']) : null;
    _fdr = json['fdr'] != null ? Fdr.fromJson(json['fdr']) : null;
    _interestRate = json['interest_rate']!=null?json['interest_rate'].toString():'';
  }
  Installments? _installments;
  Fdr? _fdr;
  String? _interestRate;

  Installments? get installments => _installments;
  Fdr? get fdr => _fdr;
  String? get interestRate => _interestRate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_installments != null) {
      map['installments'] = _installments?.toJson();
    }
    if (_fdr != null) {
      map['fdr'] = _fdr?.toJson();
    }
    map['interest_rate'] = _interestRate;
    return map;
  }

}

class Fdr {
  Fdr({
      int? id, 
      String? fdrNumber, 
      String? userId, 
      String? planId, 
      String? amount, 
      String? perInstallment, 
      String? installmentInterval, 
      String? profit, 
      String? status, 
      String? nextInstallmentDate, 
      String? lockedDate, 
      dynamic closedAt, 
      String? createdAt, 
      String? updatedAt, 
      Plan? plan,}){
    _id = id;
    _fdrNumber = fdrNumber;
    _userId = userId;
    _planId = planId;
    _amount = amount;
    _perInstallment = perInstallment;
    _installmentInterval = installmentInterval;
    _profit = profit;
    _status = status;
    _nextInstallmentDate = nextInstallmentDate;
    _lockedDate = lockedDate;
    _closedAt = closedAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _plan = plan;
}

  Fdr.fromJson(dynamic json) {
    _id = json['id'];
    _fdrNumber = json['fdr_number'].toString();
    _userId = json['user_id'].toString();
    _planId = json['plan_id'].toString();
    _amount = json['amount']!=null? json['amount'].toString() : '0';
    _perInstallment = json['per_installment']!=null?json['per_installment'].toString():'';
    _installmentInterval = json['installment_interval']!=null?json['installment_interval'].toString():'';
    _profit = json['profit']!=null?json['profit'].toString():'0';
    _status = json['status'].toString();
    _nextInstallmentDate = json['next_installment_date'];
    _lockedDate = json['locked_date'];
    _closedAt = json['closed_at'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _plan = json['plan'] != null ? Plan.fromJson(json['plan']) : null;
  }
  int? _id;
  String? _fdrNumber;
  String? _userId;
  String? _planId;
  String? _amount;
  String? _perInstallment;
  String? _installmentInterval;
  String? _profit;
  String? _status;
  String? _nextInstallmentDate;
  String? _lockedDate;
  dynamic _closedAt;
  String? _createdAt;
  String? _updatedAt;
  Plan? _plan;

  int? get id => _id;
  String? get fdrNumber => _fdrNumber;
  String? get userId => _userId;
  String? get planId => _planId;
  String? get amount => _amount;
  String? get perInstallment => _perInstallment;
  String? get installmentInterval => _installmentInterval;
  String? get profit => _profit;
  String? get status => _status;
  String? get nextInstallmentDate => _nextInstallmentDate;
  String? get lockedDate => _lockedDate;
  dynamic get closedAt => _closedAt;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Plan? get plan => _plan;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['fdr_number'] = _fdrNumber;
    map['user_id'] = _userId;
    map['plan_id'] = _planId;
    map['amount'] = _amount;
    map['per_installment'] = _perInstallment;
    map['installment_interval'] = _installmentInterval;
    map['profit'] = _profit;
    map['status'] = _status;
    map['next_installment_date'] = _nextInstallmentDate;
    map['locked_date'] = _lockedDate;
    map['closed_at'] = _closedAt;
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
    _installmentDate = json['installment_date'].toString();
    _givenAt = json['given_at'].toString();
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