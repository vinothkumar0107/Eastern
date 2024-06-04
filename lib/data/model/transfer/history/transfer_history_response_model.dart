import 'package:flutter/foundation.dart';
import '../../auth/registration_response_model.dart';

class TransferHistoryResponseModel {
  TransferHistoryResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      MainData? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  TransferHistoryResponseModel.fromJson(dynamic json) {
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
      Transfers? transfers,}){
    _transfers = transfers;
}

  MainData.fromJson(dynamic json) {
    _transfers = json['transfers'] != null ? Transfers.fromJson(json['transfers']) : null;
  }
  Transfers? _transfers;

  Transfers? get transfers => _transfers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_transfers != null) {
      map['transfers'] = _transfers?.toJson();
    }
    return map;
  }

}

class Transfers {
  Transfers({
      List<Data>? data,
      String? nextPageUrl, 
      String? path}){
    _data = data;
    _nextPageUrl = nextPageUrl;
    _path = path;
}

  Transfers.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _nextPageUrl = json['next_page_url'];
  }

  List<Data>? _data;
  String? _nextPageUrl;
  String? _path;


  List<Data>? get data => _data;
  String? get nextPageUrl => _nextPageUrl;
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
      String? beneficiaryId, 
      String? trx, 
      String? amount, 
      String? charge, 
      dynamic rejectReason, 
      dynamic wireTransferData, 
      String? status, 
      String? createdAt, 
      String? updatedAt, 
      Beneficiary? beneficiary,}){
    _id = id;
    _userId = userId;
    _beneficiaryId = beneficiaryId;
    _trx = trx;
    _amount = amount;
    _charge = charge;
    _rejectReason = rejectReason;
    _wireTransferData = wireTransferData;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _beneficiary = beneficiary;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _trx = json['trx']!=null?json['trx'].toString():'';
    _amount = json['amount']!=null?json['amount'].toString():'';
    _charge = json['charge']!=null?json['charge'].toString():'';
    _rejectReason = json['reject_reason']!=null?json['reject_reason'].toString():'';
    if(json['wire_transfer_data']!=null){
      _wireTransferData = [];
      try{
        if(json['wire_transfer_data'] is List<dynamic>){
          json['wire_transfer_data'].forEach((v) {
            _wireTransferData?.add(Details.fromJson(v));
          });
        } else{
          var map=Map.from(json['wire_transfer_data']).map((key, value) => MapEntry(key, value));
          List<Details>?list=map.entries.map((e) =>
              Details(
                  name: e.key??'',
                  type: e.value['type'],
                  value: e.value['value'].toString()
              )).toList();
          if(list.isNotEmpty){
            list.removeWhere((element) => element.toString().isEmpty);
            wireTransferData?.addAll(list);
          }
         _wireTransferData;
        }
      }catch(e){
        if (kDebugMode) {
        print(e.toString());
      }}
    }
    _status = json['status'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _beneficiary = json['beneficiary'] != null ? Beneficiary.fromJson(json['beneficiary']) : null;
  }
  int? _id;
  String? _userId;
  String? _beneficiaryId;
  String? _trx;
  String? _amount;
  String? _charge;
  dynamic _rejectReason;
  List<Details>? _wireTransferData;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  Beneficiary? _beneficiary;

  int? get id => _id;
  String? get userId => _userId;
  String? get beneficiaryId => _beneficiaryId;
  String? get trx => _trx;
  String? get amount => _amount;
  String? get charge => _charge;
  dynamic get rejectReason => _rejectReason;
  List<Details>? get wireTransferData => _wireTransferData;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Beneficiary? get beneficiary => _beneficiary;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['beneficiary_id'] = _beneficiaryId;
    map['trx'] = _trx;
    map['amount'] = _amount;
    map['charge'] = _charge;
    map['reject_reason'] = _rejectReason;
    map['wire_transfer_data'] = _wireTransferData;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_beneficiary != null) {
      map['beneficiary'] = _beneficiary?.toJson();
    }
    return map;
  }

}

class Beneficiary {
  Beneficiary({
      int? id, 
      String? userId, 
      String? beneficiaryType, 
      String? beneficiaryId, 
      String? accountNumber, 
      String? accountName, 
      String? shortName, 
      List<Details>? details, 
      String? createdAt, 
      String? updatedAt, 
      BeneficiaryOf? beneficiaryOf,}){
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
    _beneficiaryOf = beneficiaryOf;
}

  Beneficiary.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'].toString();
    _beneficiaryType = json['beneficiary_type'].toString();
    _beneficiaryId = json['beneficiary_id'].toString();
    _accountNumber = json['account_number']!=null?json['account_number'].toString():'';
    _accountName = json['account_name']!=null?json['account_name'].toString():'';
    _shortName = json['short_name']!=null?json['short_name'].toString():'';
    if (json['details'] != null) {
      _details = [];
      try{
        print('test : ${json['details']}');
        if(json['details'] is List<dynamic>){
          json['details'].forEach((v) {
            details?.add(Details.fromJson(v));
          });
        } else{
          var map=Map.from(json['details']).map((key, value) => MapEntry(key, value));
          List<Details>?list=map.entries.map((e) =>
              Details(
                  name: e.key??'',
                  type: e.value['type'],
                  value: e.value['value']??''
              )).toList();
          if(list.isNotEmpty){
            list.removeWhere((element) => element.value.toString().isEmpty);
            _details?.addAll(list);
          }
          _details;
        }
      }catch(e){
        if(kDebugMode){
          print(e.toString());
        }
      }
    }
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _beneficiaryOf = json['beneficiary_of'] != null ? BeneficiaryOf.fromJson(json['beneficiary_of']) : null;
  }
  int? _id;
  String? _userId;
  String? _beneficiaryType;
  String? _beneficiaryId;
  String? _accountNumber;
  String? _accountName;
  String? _shortName;
  List<Details>? _details;
  String? _createdAt;
  String? _updatedAt;
  BeneficiaryOf? _beneficiaryOf;

  int? get id => _id;
  String? get userId => _userId;
  String? get beneficiaryType => _beneficiaryType;
  String? get beneficiaryId => _beneficiaryId;
  String? get accountNumber => _accountNumber;
  String? get accountName => _accountName;
  String? get shortName => _shortName;
  List<Details>? get details => _details;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  BeneficiaryOf? get beneficiaryOf => _beneficiaryOf;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['beneficiary_type'] = _beneficiaryType;
    map['beneficiary_id'] = _beneficiaryId;
    map['account_number'] = _accountNumber;
    map['account_name'] = _accountName;
    map['short_name'] = _shortName;
    if (_details != null) {
      map['details'] = _details?.map((v) => v.toJson()).toList();
    }
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_beneficiaryOf != null) {
      map['beneficiary_of'] = _beneficiaryOf?.toJson();
    }
    return map;
  }

}

class BeneficiaryOf {
  BeneficiaryOf({
      int? id, 
      String? name, 
      String? minimumLimit, 
      String? maximumLimit, 
      String? dailyMaximumLimit, 
      String? monthlyMaximumLimit, 
      String? dailyTotalTransaction, 
      String? monthlyTotalTransaction, 
      String? fixedCharge, 
      String? percentCharge, 
      String? processingTime, 
      String? instruction, 
      String? status, 
      String? formId, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _minimumLimit = minimumLimit;
    _maximumLimit = maximumLimit;
    _dailyMaximumLimit = dailyMaximumLimit;
    _monthlyMaximumLimit = monthlyMaximumLimit;
    _dailyTotalTransaction = dailyTotalTransaction;
    _monthlyTotalTransaction = monthlyTotalTransaction;
    _fixedCharge = fixedCharge;
    _percentCharge = percentCharge;
    _processingTime = processingTime;
    _instruction = instruction;
    _status = status;
    _formId = formId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  BeneficiaryOf.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _minimumLimit = json['minimum_limit']!=null?json['minimum_limit'].toString():'';
    _maximumLimit = json['maximum_limit']!=null?json['maximum_limit'].toString():'';
    _dailyMaximumLimit = json['daily_maximum_limit']!=null?json['daily_maximum_limit'].toString():'';
    _monthlyMaximumLimit = json['monthly_maximum_limit']!=null?json['monthly_maximum_limit'].toString():'';
    _dailyTotalTransaction = json['daily_total_transaction'].toString();
    _monthlyTotalTransaction = json['monthly_total_transaction'].toString();
    _fixedCharge = json['fixed_charge']!=null?json['fixed_charge'].toString():'';
    _percentCharge = json['percent_charge']!=null?json['percent_charge'].toString():'';
    _processingTime = json['processing_time'].toString();
    _instruction = json['instruction'].toString();
    _status = json['status'].toString();
    _formId = json['form_id'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _name;
  String? _minimumLimit;
  String? _maximumLimit;
  String? _dailyMaximumLimit;
  String? _monthlyMaximumLimit;
  String? _dailyTotalTransaction;
  String? _monthlyTotalTransaction;
  String? _fixedCharge;
  String? _percentCharge;
  String? _processingTime;
  String? _instruction;
  String? _status;
  String? _formId;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get name => _name;
  String? get minimumLimit => _minimumLimit;
  String? get maximumLimit => _maximumLimit;
  String? get dailyMaximumLimit => _dailyMaximumLimit;
  String? get monthlyMaximumLimit => _monthlyMaximumLimit;
  String? get dailyTotalTransaction => _dailyTotalTransaction;
  String? get monthlyTotalTransaction => _monthlyTotalTransaction;
  String? get fixedCharge => _fixedCharge;
  String? get percentCharge => _percentCharge;
  String? get processingTime => _processingTime;
  String? get instruction => _instruction;
  String? get status => _status;
  String? get formId => _formId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['minimum_limit'] = _minimumLimit;
    map['maximum_limit'] = _maximumLimit;
    map['daily_maximum_limit'] = _dailyMaximumLimit;
    map['monthly_maximum_limit'] = _monthlyMaximumLimit;
    map['daily_total_transaction'] = _dailyTotalTransaction;
    map['monthly_total_transaction'] = _monthlyTotalTransaction;
    map['fixed_charge'] = _fixedCharge;
    map['percent_charge'] = _percentCharge;
    map['processing_time'] = _processingTime;
    map['instruction'] = _instruction;
    map['status'] = _status;
    map['form_id'] = _formId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

class Details {
  Details({
      String? name, 
      String? type, 
      String? value,}){
    _name = name;
    _type = type;
    _value = value;
}

  Details.fromJson(dynamic json) {
    _name = json['name']??'';
    _type = json['type']??'';
    _value = json['value']!=null?json['value'].toString():'';
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
