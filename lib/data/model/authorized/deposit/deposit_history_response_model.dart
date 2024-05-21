

import 'package:flutter/foundation.dart';
import '../../auth/registration_response_model.dart';

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
      String? nextPageUrl, 
      String? path}){
    _data = data;
    _nextPageUrl = nextPageUrl;
    _path = path;
}

  Deposits.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(DepositHistoryListModel.fromJson(v));
      });
    }
    _nextPageUrl = json['next_page_url'];
    _path = json['path'];
  }
  List<DepositHistoryListModel>? _data;
  String? _nextPageUrl;
  String? _path;

  List<DepositHistoryListModel>? get data => _data;
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
    _methodCurrency = json['method_currency']!=null?json['method_currency'].toString():'';
    _charge = json['charge'].toString();
    _rate = json['rate'].toString();
    _finalAmo = json['final_amo'].toString();
    _detail = json['detail'].toString();
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
  dynamic _detail;
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
  dynamic get detail => _detail;
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
      String? alias, 
      String? image, 
      String? status,
      String? gatewayParameters, 
      List<String>? supportedCurrencies,
      String? crypto,
      dynamic extra, 
      String? description, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _formId = formId;
    _code = code;
    _name = name;
    _alias = alias;
    _image = image;
    _status = status;
    _gatewayParameters = gatewayParameters;
    _supportedCurrencies = supportedCurrencies;
    _crypto = crypto;
    _extra = extra;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Gateway.fromJson(dynamic json) {
    _id = json['id'];
    _formId = json['form_id'].toString();
    _code = json['code']!=null?json['code'].toString():'';
    _name = json['name']!=null?json['name'].toString():'';
    _alias = json['alias']!=null?json['image'].toString():'';
    _image = json['image']!=null?json['image'].toString():'';
    _status = json['status'].toString();
    _gatewayParameters = json['gateway_parameters'];
    if (json['supported_currencies'] != null) {
      _supportedCurrencies = [];
      try{
        json['supported_currencies'].forEach((v) {
          _supportedCurrencies?.add(v);
        });
      }catch(e){
       if(kDebugMode){
         print(e.toString());
       }
      }

    }
    _crypto = json['crypto'].toString();
    _extra = json['extra'].toString();
    _description = json['description'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _formId;
  String? _code;
  String? _name;
  String? _alias;
  String? _image;
  String? _status;
  String? _gatewayParameters;
  List<dynamic>? _supportedCurrencies;
  String? _crypto;
  dynamic _extra;
  String? _description;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get formId => _formId;
  String? get code => _code;
  String? get name => _name;
  String? get alias => _alias;
  String? get image => _image;
  String? get status => _status;
  String? get gatewayParameters => _gatewayParameters;
  List<dynamic>? get supportedCurrencies => _supportedCurrencies;
  String? get crypto => _crypto;
  dynamic get extra => _extra;
  String? get description => _description;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['form_id'] = _formId;
    map['code'] = _code;
    map['name'] = _name;
    map['alias'] = _alias;
    map['image'] = _image;
    map['status'] = _status;
    map['gateway_parameters'] = _gatewayParameters;
    if (_supportedCurrencies != null) {
      map['supported_currencies'] = _supportedCurrencies?.map((v) => v.toJson()).toList();
    }
    map['crypto'] = _crypto;
    map['extra'] = _extra;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

class Detail {
  Detail({
      String? name, 
      String? type, 
      String? value,}){
    _name = name;
    _type = type;
    _value = value;
}

  Detail.fromJson(dynamic json) {
    _name = json['name']??'';
    _type = json['type']??'';
    _value = json['value'] ?? '';
  }
  String? _name;
  String? _type;
  dynamic _value;

  String? get name => _name;
  String? get type => _type;
  dynamic get value => _value;


}
