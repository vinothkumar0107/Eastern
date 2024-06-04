import '../auth/registration_response_model.dart';

class WithdrawMethodResponseModel {
  WithdrawMethodResponseModel({
    String? remark,
    String? status,
    Message? message,
    Data? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
  }

  WithdrawMethodResponseModel.fromJson(dynamic json) {
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
    List<WithdrawMethod>? withdrawMethod,}){
    _withdrawMethod = withdrawMethod;
  }

  Data.fromJson(dynamic json) {
    if (json['withdraw_method'] != null) {
      _withdrawMethod = [];
      json['withdraw_method'].forEach((v) {
        _withdrawMethod?.add(WithdrawMethod.fromJson(v));
      });
    }
  }
  List<WithdrawMethod>? _withdrawMethod;

  List<WithdrawMethod>? get withdrawMethod => _withdrawMethod;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_withdrawMethod != null) {
      map['withdraw_method'] = _withdrawMethod?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class WithdrawMethod {
  WithdrawMethod({
    int? id,
    String? name,
    String? image,
    String? minLimit,
    String? maxLimit,
    String? delay,
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
    _image = image;
    _minLimit = minLimit;
    _maxLimit = maxLimit;
    _delay = delay;
    _fixedCharge = fixedCharge;
    _rate = rate;
    _percentCharge = percentCharge;
    _currency = currency;
    _description = description;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  WithdrawMethod.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'].toString();
    _image = json['image'].toString();
    _minLimit = json['min_limit'].toString();
    _maxLimit = json['max_limit'].toString();
    _delay = json['delay'].toString();
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
  String? _formId;
  String? _name;
  String? _image;
  String? _minLimit;
  String? _maxLimit;
  String? _delay;
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
  String? get image => _image;
  String? get minLimit => _minLimit;
  String? get maxLimit => _maxLimit;
  String? get delay => _delay;
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
    map['form_id'] = _formId;
    map['name'] = _name;
    map['image'] = _image;
    map['min_limit'] = _minLimit;
    map['max_limit'] = _maxLimit;
    map['delay'] = _delay;
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