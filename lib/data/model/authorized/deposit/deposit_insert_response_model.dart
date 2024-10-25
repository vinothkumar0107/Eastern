
import 'dart:io';

import '../../auth/registration_response_model.dart';

class DepositInsertResponseModel {
  DepositInsertResponseModel({
    String? remark,
    String? status,
    Message? message,
    Data? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
  }

  DepositInsertResponseModel.fromJson(dynamic json) {
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
  Data({String? redirectUrl, Deposit? deposit,  FormData? formData, List<Field>? fields}){
    _redirectUrl = redirectUrl;
    _deposit = deposit;
    _formData = formData;
    _fields = fields;
  }

  Data.fromJson(dynamic json) {
    _redirectUrl = json['redirect_url']!=null?json['redirect_url'].toString():'';
    _deposit = json['deposit'] != null ? Deposit.fromJson(json['deposit']) : null;
    _formData = json['formData'] != null ? FormData.fromJson(json['formData']) : null;
    _fields = json['fields'] != null ? (json['fields'] as List).map((i) => Field.fromJson(i)).toList() : null;
  }
  String? _redirectUrl;
  Deposit? _deposit;
  FormData? _formData;
  List<Field>? _fields;

  String? get redirectUrl => _redirectUrl;
  Deposit? get deposit => _deposit;
  FormData? get formData => _formData;
  List<Field>? get fields => _fields;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['redirect_url'] = _redirectUrl;
    map['deposit'] = _deposit?.toJson();
    map['formData'] = _formData?.toJson();
    map['fields'] = _fields?.map((field) => field.toJson()).toList();
    return map;
  }

}

class Deposit {
  String? _userId;
  String? _methodCode;
  String? _methodCurrency;
  String? _finalAmount;

  String? get userId => _userId;
  String? get methodCode => _methodCode;
  String? get methodCurrency => _methodCurrency;
  String? get finalAmount => _finalAmount;

  Deposit.fromJson(dynamic json) {
    _userId = json['user_id']!=null?json['user_id'].toString():'';
    _methodCode = json['method_code']!=null?json['method_code'].toString():'';
    _methodCurrency = json['method_currency']!=null?json['method_currency'].toString():'';
    _finalAmount = json['final_amount']!=null?json['final_amount'].toString():'';
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['method_code'] = _methodCode;
    map['method_currency'] = _methodCurrency;
    map['final_amount'] = _finalAmount;
    return map;
  }
}

class FormData {
  int? id;
  int? userId;
  int? branchId;
  int? branchStaffId;
  int? methodCode;
  String? amount;
  String? methodCurrency;
  String? charge;
  String? rate;
  String? finalAmount;
  String? btcAmount;
  String? btcWallet;
  String? trx;
  int? paymentTry;
  int? status;
  int? fromApi;
  String? adminFeedback;
  String? createdAt;
  String? updatedAt;
  Gateway? gateway;

  FormData({
    this.id,
    this.userId,
    this.branchId,
    this.branchStaffId,
    this.methodCode,
    this.amount,
    this.methodCurrency,
    this.charge,
    this.rate,
    this.finalAmount,
    this.btcAmount,
    this.btcWallet,
    this.trx,
    this.paymentTry,
    this.status,
    this.fromApi,
    this.adminFeedback,
    this.createdAt,
    this.updatedAt,
    this.gateway,
  });

  factory FormData.fromJson(Map<String, dynamic> json) {
    return FormData(
      id: json['id'],
      userId: json['user_id'],
      branchId: json['branch_id'],
      branchStaffId: json['branch_staff_id'],
      methodCode: json['method_code'],
      amount: json['amount'],
      methodCurrency: json['method_currency'],
      charge: json['charge'],
      rate: json['rate'],
      finalAmount: json['final_amount'],
      btcAmount: json['btc_amount'],
      btcWallet: json['btc_wallet'],
      trx: json['trx'],
      paymentTry: json['payment_try'],
      status: json['status'],
      fromApi: json['from_api'],
      adminFeedback: json['admin_feedback'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      gateway: json['gateway'] != null ? Gateway.fromJson(json['gateway']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'branch_id': branchId,
      'branch_staff_id': branchStaffId,
      'method_code': methodCode,
      'amount': amount,
      'method_currency': methodCurrency,
      'charge': charge,
      'rate': rate,
      'final_amount': finalAmount,
      'btc_amount': btcAmount,
      'btc_wallet': btcWallet,
      'trx': trx,
      'payment_try': paymentTry,
      'status': status,
      'from_api': fromApi,
      'admin_feedback': adminFeedback,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'gateway': gateway?.toJson(),
    };
  }
}

class Gateway {
  int? id;
  int? formId;
  String? code;
  String? name;
  String? alias;
  int? status;
  String? description;

  Gateway({
    this.id,
    this.formId,
    this.code,
    this.name,
    this.alias,
    this.status,
    this.description,
  });

  factory Gateway.fromJson(Map<String, dynamic> json) {
    return Gateway(
      id: json['id'],
      formId: json['form_id'],
      code: json['code'],
      name: json['name'],
      alias: json['alias'],
      status: json['status'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'form_id': formId,
      'code': code,
      'name': name,
      'alias': alias,
      'status': status,
      'description': description,
    };
  }
}

class Field {
  String? name;
  String? label;
  String? isRequired;
  String? extensions;
  List<String>? options;
  String? type;
  List<String>?cbSelected;
  dynamic selectedValue;
  File? imageFile;

  Field({
    this.name,
    this.label,
    this.isRequired,
    this.extensions,
    this.options,
    this.type,
    this.cbSelected,
    this.selectedValue,
    this.imageFile
  });

  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
      name: json['name'],
      label: json['label'],
      isRequired: json['is_required'],
      extensions: json['extensions'],
      options: json['options'] != null ? List<String>.from(json['options']) : [],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'label': label,
      'is_required': isRequired,
      'extensions': extensions,
      'options': options,
      'type': type,
    };
  }
}
