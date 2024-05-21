import 'package:flutter/foundation.dart';
import 'package:eastern_trust/data/model/transfer/history/transfer_history_response_model.dart';

import '../auth/registration_response_model.dart';

class DepositHistoryResponseModel {
  DepositHistoryResponseModel({
    String? remark,
    String? status,
    Message? message,
    MainData? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
  }

  DepositHistoryResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status'];
    _message = json['message'] != null ? Message.fromJson(json['message']) : null;
    _data = json['data'] != null ?  MainData.fromJson(json['data']) : null;
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

class  MainData {
  MainData({
    Deposits? deposits,}){
    _deposits = deposits;
  }

  MainData.fromJson(dynamic json) {
    _deposits = json['deposits'] != null ? Deposits.fromJson(json['deposits']) : null;
  }
  Deposits? _deposits;

  Deposits? get deposits => _deposits;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_deposits != null) {
      map['deposits'] = _deposits?.toJson();
    }
    return map;
  }

}

class Deposits {
  Deposits({
    List<DepositHistoryListModel>? data,
    dynamic nextPageUrl,
    String? path,
  }){
    _data = data;
    _nextPageUrl = nextPageUrl;
    _path = path;
  }

  Deposits.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      try{
        json['data'].forEach((v) {
          _data?.add(DepositHistoryListModel.fromJson(v));
        });
      } catch(e){
       if(kDebugMode){
         print(e.toString());
       }
      }

    }
    _nextPageUrl = json['next_page_url'];
    _path = json['path'];
  }

  List<DepositHistoryListModel>? _data;
  dynamic _nextPageUrl;
  String? _path;

  List<DepositHistoryListModel>? get data => _data;
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


class DepositHistoryListModel {
  DepositHistoryListModel({
    int? id,
    String? userId,
    String? methodCode,
    String? amount,
    String? methodCurrency,
    String? charge,
    String? rate,
    String? finalAmo,
    dynamic detail,
    String? btcAmo,
    String? btcWallet,
    String? trx,
    String? status,
    String? fromApi,
    dynamic adminFeedback,
    String? createdAt,
    String? updatedAt,
    Gateway? gateway,}){
    _id = id;
    _userId = userId;
    _methodCode = methodCode;
    _amount = amount;
    _methodCurrency = methodCurrency;
    _charge = charge;
    _rate = rate;
    _finalAmo = finalAmo;
    _detail = detail;
    _btcAmo = btcAmo;
    _btcWallet = btcWallet;
    _trx = trx;
    _status = status;
    _fromApi = fromApi;
    _adminFeedback = adminFeedback;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _gateway = gateway;
  }

  DepositHistoryListModel.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'].toString();
    _methodCode = json['method_code'].toString();
    _amount = json['amount'].toString();
    _methodCurrency = json['method_currency'];
    _charge = json['charge'].toString();
    _rate = json['rate'].toString();
    _finalAmo = json['final_amo'].toString();
    if(json['detail']!=null){
      _detail = [];
      try{
        if(json['detail'] is List<dynamic>){
          json['detail'].forEach((v) {
            _detail?.add(Details.fromJson(v));
          });
        } else{
          var map=Map.from(json['detail']).map((key, value) => MapEntry(key, value));
          List<Details>?list=map.entries.map((e) =>
              Details(
                  name: e.value['name'],
                  type: e.value['type'],
                  value: e.value['value']
              )).toList();
          if(list.isNotEmpty){
            list.removeWhere((element) => element.toString().isEmpty);
            _detail?.addAll(list);
          }
          _detail;
        }
      }catch(e){
        if (kDebugMode) {
        print(e.toString());
      }}
    }
    _btcAmo = json['btc_amo'].toString();
    _btcWallet = json['btc_wallet'].toString();
    _trx = json['trx'].toString();
    _status = json['status'].toString();
    _fromApi = json['from_api'].toString();
    _adminFeedback = json['admin_feedback'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _gateway = json['gateway'] != null ? Gateway.fromJson(json['gateway']) : null;
  }

  int? _id;
  String? _userId;
  String? _methodCode;
  String? _amount;
  String? _methodCurrency;
  String? _charge;
  String? _rate;
  String? _finalAmo;
  List<dynamic>? _detail;
  String? _btcAmo;
  String? _btcWallet;
  String? _trx;
  String? _status;
  String? _fromApi;
  dynamic _adminFeedback;
  String? _createdAt;
  String? _updatedAt;
  Gateway? _gateway;

  int? get id => _id;
  String? get userId => _userId;
  String? get methodCode => _methodCode;
  String? get amount => _amount;
  String? get methodCurrency => _methodCurrency;
  String? get charge => _charge;
  String? get rate => _rate;
  String? get finalAmo => _finalAmo;
  List<dynamic>? get detail => _detail;
  String? get btcAmo => _btcAmo;
  String? get btcWallet => _btcWallet;
  String? get trx => _trx;
  String? get status => _status;
  String? get fromApi => _fromApi;
  dynamic get adminFeedback => _adminFeedback;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Gateway? get gateway => _gateway;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['method_code'] = _methodCode;
    map['amount'] = _amount;
    map['method_currency'] = _methodCurrency;
    map['charge'] = _charge;
    map['rate'] = _rate;
    map['final_amo'] = _finalAmo;
    map['btc_amo'] = _btcAmo;
    map['btc_wallet'] = _btcWallet;
    map['trx'] = _trx;
    map['status'] = _status;
    map['from_api'] = _fromApi;
    map['admin_feedback'] = _adminFeedback;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_gateway != null) {
      map['gateway'] = _gateway?.toJson();
    }
    return map;
  }

}

class Gateway {
  Gateway({
    int? id,
    String? formId,
    String? code,
    String? name,
    String? alias
  }){
    _id = id;
    _formId = formId;
    _code = code;
    _name = name;
    _alias = alias;
  }

  Gateway.fromJson(dynamic json) {
    _id = json['id'];
    _formId = json['form_id'].toString();
    _code = json['code'].toString();
    _name = json['name']!=null?json['name'].toString():'';
    _alias = json['alias'].toString();
  }
  int? _id;
  String? _formId;
  String? _code;
  String? _name;
  String? _alias;

  int? get id => _id;
  String? get formId => _formId;
  String? get code => _code;
  String? get name => _name;
  String? get alias => _alias;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['form_id'] = _formId;
    map['code'] = _code;
    map['name'] = _name;
    map['alias'] = _alias;
    return map;
  }

}