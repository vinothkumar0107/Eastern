import 'package:eastern_trust/data/model/general_setting/general_settings_response_model.dart';
import '../../auth/registration_response_model.dart';

class MyBankBeneficiaryResponseModel {
  MyBankBeneficiaryResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      MainData? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  MyBankBeneficiaryResponseModel.fromJson(dynamic json) {
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
    Beneficiaries? beneficiaries,
    String? transferCharge,
    GeneralSetting? general,}){
    _beneficiaries = beneficiaries;
    _transferCharge = transferCharge;
    _general = general;
}

  MainData.fromJson(dynamic json) {
    _beneficiaries = json['beneficiaries'] != null ? Beneficiaries.fromJson(json['beneficiaries']) : null;
    _transferCharge = json['transfer_charge']!=null?json['transfer_charge'].toString():'';
    _general = json['general'] != null ? GeneralSetting.fromJson(json['general']) : null;
  }

  Beneficiaries? _beneficiaries;
  String? _transferCharge;
  GeneralSetting? _general;

  Beneficiaries? get beneficiaries => _beneficiaries;
  String? get transferCharge => _transferCharge;
  GeneralSetting? get general => _general;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_beneficiaries != null) {
      map['beneficiaries'] = _beneficiaries?.toJson();
    }
    map['transfer_charge'] = _transferCharge;
    if (_general != null) {
      map['general'] = _general?.toJson();
    }
    return map;
  }

}

class Beneficiaries {
  Beneficiaries({
      List<Data>? data,
      dynamic nextPageUrl, 
      String? path}){
    _data = data;
    _nextPageUrl = nextPageUrl;
    _path = path;
}

  Beneficiaries.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _nextPageUrl = json['next_page_url'];
    _path = json['path'];
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
      String? userId, 
      String? beneficiaryType, 
      String? beneficiaryId, 
      String? accountNumber, 
      String? accountName, 
      String? shortName, 
      dynamic details, 
      String? createdAt, 
      String? updatedAt}){
    _id = id;
    _userId = userId;
    _beneficiaryType = beneficiaryType;
    _beneficiaryId = beneficiaryId;
    _accountNumber = accountNumber;
    _accountName = accountName;
    _shortName = shortName;
    _details = details;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'].toString();
    _beneficiaryType = json['beneficiary_type'].toString();
    _beneficiaryId = json['beneficiary_id'].toString();
    _accountNumber = json['account_number']!=null?json['account_number'].toString():'';
    _accountName = json['account_name']!=null?json['account_name'].toString():'';
    _shortName = json['short_name']!=null?json['short_name'].toString():'';
    _details = json['details']!=null?json['details'].toString():'';
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  int? _id;
  String? _userId;
  String? _beneficiaryType;
  String? _beneficiaryId;
  String? _accountNumber;
  String? _accountName;
  String? _shortName;
  dynamic _details;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get userId => _userId;
  String? get beneficiaryType => _beneficiaryType;
  String? get beneficiaryId => _beneficiaryId;
  String? get accountNumber => _accountNumber;
  String? get accountName => _accountName;
  String? get shortName => _shortName;
  dynamic get details => _details;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['beneficiary_type'] = _beneficiaryType;
    map['beneficiary_id'] = _beneficiaryId;
    map['account_number'] = _accountNumber;
    map['account_name'] = _accountName;
    map['short_name'] = _shortName;
    map['details'] = _details;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}