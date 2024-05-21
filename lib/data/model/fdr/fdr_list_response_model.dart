import '../auth/registration_response_model.dart';

class FdrListResponseModel {
  FdrListResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      Data? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  FdrListResponseModel.fromJson(dynamic json) {
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
      Fdr? fdr,}){
    _fdr = fdr;
}

  Data.fromJson(dynamic json) {
    _fdr = json['fdr'] != null ? Fdr.fromJson(json['fdr']) : null;
  }
  Fdr? _fdr;

  Fdr? get fdr => _fdr;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_fdr != null) {
      map['fdr'] = _fdr?.toJson();
    }
    return map;
  }

}

class Fdr {
  Fdr({
      List<FdrListData>? data,
      dynamic nextPageUrl, 
      String? path,
      String? total,}){
    _data = data;
    _nextPageUrl = nextPageUrl;
    _path = path;
    _total = total;
}

  Fdr.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(FdrListData.fromJson(v));
      });
    }
    _nextPageUrl = json['next_page_url'];
    _path = json['path'];
    _total = json['total'].toString();
  }

  List<FdrListData>? _data;
  dynamic _nextPageUrl;
  String? _path;
  String? _total;

  List<FdrListData>? get data => _data;
  dynamic get nextPageUrl => _nextPageUrl;
  String? get path => _path;

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


class FdrListData {
  FdrListData({
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

  FdrListData.fromJson(dynamic json) {
    _id = json['id'];
    _fdrNumber = json['fdr_number'].toString();
    _userId = json['user_id'].toString();
    _planId = json['plan_id'].toString();
    _amount = json['amount']!=null?json['amount'].toString():'';
    _perInstallment = json['per_installment']!=null?json['per_installment'].toString():'';
    _installmentInterval = json['installment_interval']!=null?json['installment_interval'].toString():'';
    _profit = json['profit']!=null? json['profit'].toString():'';
    _status = json['status'].toString();
    _nextInstallmentDate = json['next_installment_date'];
    _lockedDate = json['locked_date'];
    _closedAt = json['closed_at'];
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