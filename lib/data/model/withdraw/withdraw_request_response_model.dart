import 'dart:io';
import 'package:flutter/foundation.dart';

import '../auth/registration_response_model.dart';

class WithdrawRequestResponseModel {
  WithdrawRequestResponseModel({
    String? remark,
    String? status,
    Message? message,
    Data? data,
  }) {
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
  }

  WithdrawRequestResponseModel.fromJson(dynamic json) {
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
    String? otpId}){
    _otpId = otpId;
  }

  Data.fromJson(dynamic json) {
    _otpId = json['otpId']!=null?json['otpId'].toString():'';
    _trxId = json['trx']!=null?json['trx'].toString():'';
  }

  String? _otpId;
  String? _trxId;
  String? get otpId => _otpId;
  String? get trxId => _trxId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['otpId'] = _otpId;
    return map;
  }

}

class Form {
  Form({List<FormModel>? list}) {
    _list = list;
  }

  List<FormModel>? _list=[];

  List<FormModel>? get list => _list;

  Form.fromJson(dynamic json) {
    var map = Map.from(json).map((k, v) => MapEntry<String, dynamic>(k, v));

    try{
      List<FormModel>? list = map.entries
          .map((e) => FormModel(
          e.value['name'],
          e.value['label'],
          e.value['is_required'],
          e.value['extensions'],
          (e.value['options'] as List).map((e) => e as String).toList(),
          e.value['type'],
        ''
      ),).toList();
      if (list.isNotEmpty) {
        list.removeWhere((element) => element.toString().isEmpty);
        _list?.addAll(list);
      }
      _list;
    }catch(e){
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

}


class FormModel {
  String? name;
  String? label;
  String? isRequired;
  String? extensions;
  List<String>? options;
  String? type;
  dynamic selectedValue;
  File? file;
  List<String>?cbSelected;

  FormModel(this.name, this.label, this.isRequired, this.extensions,
      this.options, this.type,this.selectedValue,{this.cbSelected,this.file});

}


class WithdrawData {
  WithdrawData({
    String? methodId,
    String? userId,
    String? amount,
    String? currency,
    String? rate,
    String? charge,
    String? finalAmount,
    String? afterCharge,
    String? trx,
    String? updatedAt,
    String? createdAt,
    int? id,
  }) {
    _methodId     = methodId;
    _userId       = userId;
    _amount       = amount;
    _currency     = currency;
    _rate         = rate;
    _charge       = charge;
    _finalAmount  = finalAmount;
    _afterCharge  = afterCharge;
    _trx          = trx;
    _updatedAt    = updatedAt;
    _createdAt    = createdAt;
    _id           = id;
  }

  WithdrawData.fromJson(dynamic json) {
    _methodId      = json['method_id'].toString();
    _userId        = json['user_id'].toString();
    _amount        = json['amount'] !=null? json['amount'].toString():'0';
    _currency      = json['currency'].toString();
    _rate          = json['rate']!=null?json['rate'].toString():'1';
    _charge        = json['charge'] !=null? json['charge'].toString():'0';
    _finalAmount   = json['final_amount']!=null?json['final_amount'].toString():'';
    _afterCharge   = json['after_charge'] !=null? json['after_charge'].toString():'';
    _trx           = json['trx'].toString();
    _updatedAt     = json['updated_at'];
    _createdAt     = json['created_at'];
    _id            = json['id'];
  }

  String? _methodId;
  String? _userId;
  String? _amount;
  String? _currency;
  String? _rate;
  String? _charge;
  String? _finalAmount;
  String? _afterCharge;
  String? _trx;
  String? _updatedAt;
  String? _createdAt;
  int? _id;

  String? get methodId => _methodId;
  String? get userId => _userId;
  String? get amount => _amount;
  String? get currency => _currency;
  String? get rate => _rate;
  String? get charge => _charge;
  String? get finalAmount => _finalAmount;
  String? get afterCharge => _afterCharge;
  String? get trx => _trx;
  String? get updatedAt => _updatedAt;
  String? get createdAt => _createdAt;
  int? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['method_id'] = _methodId;
    map['user_id'] = _userId;
    map['amount'] = _amount;
    map['currency'] = _currency;
    map['rate'] = _rate;
    map['charge'] = _charge;
    map['final_amount'] = _finalAmount;
    map['after_charge'] = _afterCharge;
    map['trx'] = _trx;
    map['updated_at'] = _updatedAt;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    return map;
  }
}

