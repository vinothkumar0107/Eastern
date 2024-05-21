import 'package:flutter/foundation.dart';
import 'package:eastern_trust/data/model/dynamic_form/form.dart';
import '../../auth/registration_response_model.dart';

class OtherBankBeneficiaryResponseModel {
  OtherBankBeneficiaryResponseModel({
      this.remark, 
      this.status, 
      this.message, 
      this.data,});

  OtherBankBeneficiaryResponseModel.fromJson(dynamic json) {
    remark = json['remark'];
    status = json['status'];
    message = json['message'] != null ? Message.fromJson(json['message']) : null;
    data = json['data'] != null ? MainData.fromJson(json['data']) : null;
  }

  String? remark;
  String? status;
  Message? message;
  MainData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remark'] = remark;
    map['status'] = status;
    if (message != null) {
      map['message'] = message?.toJson();
    }
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class MainData {
  MainData({
      this.beneficiaries, 
      this.banks,});

  MainData.fromJson(dynamic json) {
    beneficiaries = json['beneficiaries'] != null ? Beneficiaries.fromJson(json['beneficiaries']) : null;
    if (json['banks'] != null) {
      banks = [];
      json['banks'].forEach((v) {
        banks?.add(Banks.fromJson(v));
      });
    }
  }
  Beneficiaries? beneficiaries;
  List<Banks>? banks;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (beneficiaries != null) {
      map['beneficiaries'] = beneficiaries?.toJson();
    }
    if (banks != null) {
      map['banks'] = banks?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Banks {
  Banks({
      this.id, 
      this.name, 
      this.minimumLimit, 
      this.maximumLimit, 
      this.dailyMaximumLimit, 
      this.monthlyMaximumLimit, 
      this.dailyTotalTransaction, 
      this.monthlyTotalTransaction, 
      this.fixedCharge, 
      this.percentCharge, 
      this.processingTime, 
      this.instruction, 
      this.status, 
      this.formId, 
      this.createdAt, 
      this.updatedAt, 
      this.form,});

  Banks.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    minimumLimit = json['minimum_limit'] !=null? json['minimum_limit'].toString():'';
    maximumLimit = json['maximum_limit'] !=null? json['maximum_limit'].toString():'';
    dailyMaximumLimit = json['daily_maximum_limit'] !=null? json['daily_maximum_limit'].toString():'';
    monthlyMaximumLimit = json['monthly_maximum_limit'] !=null? json['monthly_maximum_limit'].toString():'';
    dailyTotalTransaction = json['daily_total_transaction'] !=null? json['daily_total_transaction'].toString():'';
    monthlyTotalTransaction = json['monthly_total_transaction'] !=null? json['monthly_total_transaction'].toString():'';
    fixedCharge = json['fixed_charge'] !=null? json['fixed_charge'].toString():'';
    percentCharge = json['percent_charge'] !=null? json['percent_charge'].toString():'';
    processingTime = json['processing_time'] !=null? json['processing_time'].toString():'';
    instruction = json['instruction'] !=null? json['instruction'].toString():'';
    status = json['status'] !=null? json['status'].toString():'';
    formId = json['form_id'] !=null? json['form_id'].toString():'';
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    form = json['form'] != null ? Form.fromJson(json['form']) : null;
  }

  int? id;
  String? name;
  String? minimumLimit;
  String? maximumLimit;
  String? dailyMaximumLimit;
  String? monthlyMaximumLimit;
  String? dailyTotalTransaction;
  String? monthlyTotalTransaction;
  String? fixedCharge;
  String? percentCharge;
  String? processingTime;
  String? instruction;
  String? status;
  String? formId;
  String? createdAt;
  String? updatedAt;
  Form? form;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['minimum_limit'] = minimumLimit;
    map['maximum_limit'] = maximumLimit;
    map['daily_maximum_limit'] = dailyMaximumLimit;
    map['monthly_maximum_limit'] = monthlyMaximumLimit;
    map['daily_total_transaction'] = dailyTotalTransaction;
    map['monthly_total_transaction'] = monthlyTotalTransaction;
    map['fixed_charge'] = fixedCharge;
    map['percent_charge'] = percentCharge;
    map['processing_time'] = processingTime;
    map['instruction'] = instruction;
    map['status'] = status;
    map['form_id'] = formId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (form != null) {
      map['form'] = form?.toJson();
    }
    return map;
  }

}


class Beneficiaries {
  Beneficiaries({
      this.data,
      this.nextPageUrl, 
      this.path,
      this.total});

  Beneficiaries.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      try{
        json['data'].forEach((v) {
          data?.add(Data.fromJson(v));
        });
      } catch(e){
        if (kDebugMode) {
          print(e.toString());
        }
      }

    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    total = json['total'].toString();
  }

  List<Data>? data;
  dynamic nextPageUrl;
  String? path;
  String? total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['next_page_url'] = nextPageUrl;
    map['path'] = path;
    map['total'] = total;
    return map;
  }

}


class Data {
  Data({
      this.id, 
      this.userId, 
      this.beneficiaryType, 
      this.beneficiaryId, 
      this.accountNumber, 
      this.accountName, 
      this.shortName, 
      this.details, 
      this.createdAt, 
      this.updatedAt, 
      this.beneficiaryOf,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'].toString();
    beneficiaryType = json['beneficiary_type'].toString();
    beneficiaryId = json['beneficiary_id'].toString();
    accountNumber = json['account_number'].toString();
    accountName = json['account_name'].toString();
    shortName = json['short_name']!=null?json['short_name'].toString():'';
    if (json['details'] != null) {
      details = [];
      try{
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
                  value: e.value['value']
              )).toList();
          if(list.isNotEmpty){
            list.removeWhere((element) => element.toString().isEmpty);
            details?.addAll(list);
          }
          details;
      }
      }catch(e){
        if(kDebugMode){
          print(e.toString());
        }
      }

    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    beneficiaryOf = json['beneficiary_of'] != null ? BeneficiaryOf.fromJson(json['beneficiary_of']) : null;

  }
  int? id;
  String? userId;
  String? beneficiaryType;
  String? beneficiaryId;
  String? accountNumber;
  String? accountName;
  String? shortName;
  List<Details>? details;
  String? createdAt;
  String? updatedAt;
  BeneficiaryOf? beneficiaryOf;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['beneficiary_type'] = beneficiaryType;
    map['beneficiary_id'] = beneficiaryId;
    map['account_number'] = accountNumber;
    map['account_name'] = accountName;
    map['short_name'] = shortName;
    if (details != null) {
      map['details'] = details?.map((v) => v.toJson()).toList();
    }
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (beneficiaryOf != null) {
      map['beneficiary_of'] = beneficiaryOf?.toJson();
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
    String? updatedAt,}) {
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
    _name = json['name'].toString();
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
    map['id'] = id;
    map['name'] = name;
    map['minimum_limit'] = minimumLimit;
    map['maximum_limit'] = maximumLimit;
    map['daily_maximum_limit'] = dailyMaximumLimit;
    map['monthly_maximum_limit'] = monthlyMaximumLimit;
    map['daily_total_transaction'] = dailyTotalTransaction;
    map['monthly_total_transaction'] = monthlyTotalTransaction;
    map['fixed_charge'] = fixedCharge;
    map['percent_charge'] = percentCharge;
    map['processing_time'] = processingTime;
    map['instruction'] = instruction;
    map['status'] = status;
    map['form_id'] = formId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
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
    _name = json['name'];
    _type = json['type'];
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