import '../auth/registration_response_model.dart';

class TransactionResponseModel {
  TransactionResponseModel({
      String? remark, 
      String? status, 
      Message? message,
      Data? data}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  TransactionResponseModel.fromJson(dynamic json) {
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
      Transactions? transactions, 
      List<Remarks>? remarks,}){
    _transactions = transactions;
    _remarks = remarks;
}

  Data.fromJson(dynamic json) {
    _transactions = json['transactions'] != null ? Transactions.fromJson(json['transactions']) : null;
    if (json['remarks'] != null) {
      _remarks = [];
      json['remarks'].forEach((v) {
        _remarks?.add(Remarks.fromJson(v));
      });
    }
  }
  Transactions? _transactions;
  List<Remarks>? _remarks;

  Transactions? get transactions => _transactions;
  List<Remarks>? get remarks => _remarks;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_remarks != null) {
      map['remarks'] = _remarks?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Remarks {
  Remarks({
      String? remark,}){
    _remark = remark;
}

  Remarks.fromJson(dynamic json) {
    _remark = json['remark'];
  }
  String? _remark;

  String? get remark => _remark;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remark'] = _remark;
    return map;
  }

}

class Transactions {
  Transactions({
      List<TransactionData>? data,
      dynamic nextPageUrl,
      String? path
   }){
    _data = data;
    _nextPageUrl = nextPageUrl;
    _path = path;

}

  Transactions.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(TransactionData.fromJson(v));
      });
    }
    _nextPageUrl = json['next_page_url'];
    _path = json['path'];
  }

  List<TransactionData>? _data;
  dynamic _nextPageUrl;
  String? _path;

  List<TransactionData>? get data => _data;
  dynamic get nextPageUrl => _nextPageUrl;
  String? get path => _path;
}


class TransactionData {
  TransactionData({
      int? id, 
      String? userId,
      String? amount, 
      String? charge, 
      String? currency, 
      String? postBalance, 
      String? trxType, 
      String? trx, 
      String? details, 
      String? remark, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _userId = userId;
    _amount = amount;
    _charge = charge;
    _currency = currency;
    _postBalance = postBalance;
    _trxType = trxType;
    _trx = trx;
    _details = details;
    _remark = remark;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  TransactionData.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'].toString();
    _amount = json['amount']!=null?json['amount'].toString():'0';
    _charge = json['charge']!=null?json['charge'].toString():'0';
    _currency = json['currency'];
    _postBalance = json['post_balance']!=null?json['post_balance'].toString():'0';
    _trxType = json['trx_type']!=null?json['trx_type'].toString():'0';
    _trx = json['trx']??'';
    _details = json['details'];
    _remark = json['remark']??'';
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _userId;
  String? _amount;
  String? _charge;
  String? _currency;
  String? _postBalance;
  String? _trxType;
  String? _trx;
  String? _details;
  String? _remark;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get userId => _userId;
  String? get amount => _amount;
  String? get charge => _charge;
  String? get currency => _currency;
  String? get postBalance => _postBalance;
  String? get trxType => _trxType;
  String? get trx => _trx;
  String? get details => _details;
  String? get remark => _remark;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['amount'] = _amount;
    map['charge'] = _charge;
    map['currency'] = _currency;
    map['post_balance'] = _postBalance;
    map['trx_type'] = _trxType;
    map['trx'] = _trx;
    map['details'] = _details;
    map['remark'] = _remark;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}