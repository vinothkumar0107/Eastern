import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:eastern_trust/data/model/transfer/history/transfer_history_response_model.dart';

import '../auth/registration_response_model.dart';

class WithdrawHistoryResponseModel {
  WithdrawHistoryResponseModel({
    String? remark,
    String? status,
    Message? message,
    MainData? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
  }

  WithdrawHistoryResponseModel.fromJson(dynamic json) {
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
    Withdrawals? withdrawals,}){
    _withdrawals = withdrawals;
  }

  MainData.fromJson(dynamic json) {
    _withdrawals = json['withdrawals'] != null ? Withdrawals.fromJson(json['withdrawals']) : null;
    _path = json['path'];
  }
  Withdrawals? _withdrawals;
  String? _path;

  String? get path => _path;
  Withdrawals? get withdrawals => _withdrawals;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_withdrawals != null) {
      map['withdrawals'] = _withdrawals?.toJson();
    }
    return map;
  }

}

class Withdrawals {
  Withdrawals({
    List<WithdrawListModel>? data,
    dynamic nextPageUrl,
    String? path
  }){
    _data = data;
    _nextPageUrl = nextPageUrl;
    _path = path;
  }

  Withdrawals.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      try{
        json['data'].forEach((v) {
          _data?.add(WithdrawListModel.fromJson(v));
        });
      }catch(e){
        if (kDebugMode) {
          print(e.toString());
        }
      }

    }
    _nextPageUrl = json['next_page_url'];
    _path = json['path'];
  }
  List<WithdrawListModel>? _data;
  dynamic _nextPageUrl;
  String? _path;


  List<WithdrawListModel>? get data => _data;
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


class WithdrawListModel {
  WithdrawListModel({
    int? id,
    String? methodId,
    String? userId,
    String? amount,
    String? currency,
    String? rate,
    String? charge,
    String? trx,
    String? finalAmount,
    String? afterCharge,
    String? status,
    dynamic adminFeedback,
    String? createdAt,
    String? updatedAt,
    Method? method,}){
    _id = id;
    _amount = amount;
    _currency = currency;
    _rate = rate;
    _charge = charge;
    _trx = trx;
    _finalAmount = finalAmount;
    _afterCharge = afterCharge;
    _adminFeedback = adminFeedback;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _method = method;
  }

  WithdrawListModel.fromJson(dynamic json) {
    _id = json['id'];
    _amount = json['amount'].toString();
    _currency = json['currency'].toString();
    _rate = json['rate'].toString();
    _charge = json['charge'].toString();
    _trx = json['trx'].toString();
    _finalAmount = json['final_amount'].toString();
    _afterCharge = json['after_charge'].toString();
    if (json['withdraw_information'] != null) {
      _details = [];
      try{
        if(json['withdraw_information'] is List<dynamic>){
          json['withdraw_information'].forEach((v) {

            _details?.add(Details.fromJson(v));
          });
        } else{
          var map=Map.from(json['withdraw_information']).map((key, value) => MapEntry(key, value));
          List<Details>?list=map.entries.map((e) =>
              Details(
                  name: e.value['name'],
                  type: e.value['type'],
                  value: e.value['value']
              )).toList();
          if(list.isNotEmpty){
            list.removeWhere((element) => element.toString().isEmpty);
            _details?.addAll(list);
          }
          _details;
        }
        _details?.removeWhere((element) => element.value==null || element.name==null);
      }catch(e){
        if(kDebugMode){
          print(e.toString());
        }
      }

    }
    _status = json['status'].toString();
    _adminFeedback = json['admin_feedback'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _method = json['method'] != null ? Method.fromJson(json['method']) : null;
  }
  int? _id;
  int? _methodId;
  int? _userId;
  String? _amount;
  String? _currency;
  String? _rate;
  String? _charge;
  String? _trx;
  String? _finalAmount;
  String? _afterCharge;
  List<Details>? _details;
  String? _status;
  dynamic _adminFeedback;
  String? _createdAt;
  String? _updatedAt;
  Method? _method;

  int? get id => _id;
  int? get methodId => _methodId;
  int? get userId => _userId;
  String? get amount => _amount;
  String? get currency => _currency;
  String? get rate => _rate;
  String? get charge => _charge;
  String? get trx => _trx;
  String? get finalAmount => _finalAmount;
  String? get afterCharge => _afterCharge;
  String? get status => _status;
  List<Details>? get details => _details;
  dynamic get adminFeedback => _adminFeedback;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Method? get method => _method;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['method_id'] = _methodId;
    map['user_id'] = _userId;
    map['amount'] = _amount;
    map['currency'] = _currency;
    map['rate'] = _rate;
    map['charge'] = _charge;
    map['trx'] = _trx;
    map['final_amount'] = _finalAmount;
    map['after_charge'] = _afterCharge;
    map['status'] = _status;
    map['admin_feedback'] = _adminFeedback;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_method != null) {
      map['method'] = _method?.toJson();
    }
    return map;
  }

}

class Method {
  Method({
    int? id,
    String? name,
    String? minLimit,
    String? maxLimit,
    String? fixedCharge,
    String? rate,
    String? percentCharge,
    String? currency,
    String? description,
    String? status,
    String? createdAt,
    String? updatedAt,}){
    _id = id;
    _name = name;
    _minLimit = minLimit;
    _maxLimit = maxLimit;
    _fixedCharge = fixedCharge;
    _rate = rate;
    _percentCharge = percentCharge;
    _currency = currency;
    _description = description;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Method.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'].toString();
    _minLimit = json['min_limit'].toString();
    _maxLimit = json['max_limit'].toString();
    _fixedCharge = json['fixed_charge'].toString();
    _rate = json['rate'].toString();
    _percentCharge = json['percent_charge'].toString();
    _currency = json['currency'].toString();
    _description = json['description'].toString();
    _status = json['status'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _name;
  String? _minLimit;
  String? _maxLimit;
  String? _fixedCharge;
  String? _rate;
  String? _percentCharge;
  String? _currency;
  String? _description;
  String? _status;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get name => _name;
  String? get minLimit => _minLimit;
  String? get maxLimit => _maxLimit;
  String? get fixedCharge => _fixedCharge;
  String? get rate => _rate;
  String? get percentCharge => _percentCharge;
  String? get currency => _currency;
  String? get description => _description;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['min_limit'] = _minLimit;
    map['max_limit'] = _maxLimit;
    map['fixed_charge'] = _fixedCharge;
    map['rate'] = _rate;
    map['percent_charge'] = _percentCharge;
    map['currency'] = _currency;
    map['description'] = _description;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}