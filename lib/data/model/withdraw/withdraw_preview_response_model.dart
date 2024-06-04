import 'dart:io';
import 'package:flutter/foundation.dart';

import '../auth/registration_response_model.dart';

class WithdrawConfirmResponseModel {
  WithdrawConfirmResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      Data? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  WithdrawConfirmResponseModel.fromJson(dynamic json) {
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
      Withdraw? withdraw, 
      Form? form,}){
    _withdraw = withdraw;
    _form = form;
}

  Data.fromJson(dynamic json) {
    _withdraw = json['withdraw'] != null ? Withdraw.fromJson(json['withdraw']) : null;
    _form = json['form'] != null ? Form.fromJson(json['form']) : null;
  }
  Withdraw? _withdraw;
  Form? _form;

  Withdraw? get withdraw => _withdraw;
  Form? get form => _form;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_withdraw != null) {
      map['withdraw'] = _withdraw?.toJson();
    }
    if (_form != null) {
      map['form'] = _form?.toJson();
    }
    return map;
  }

}

class Form {
  Form({
      int? id, 
      String? act, 
      FormData? formData, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _act = act;
    _formData = formData;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Form.fromJson(dynamic json) {
    _id = json['id'];
    _act = json['act'];
    _formData = json['form_data'] != null ? FormData.fromJson(json['form_data']) : null;
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _act;
  FormData? _formData;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get act => _act;
  FormData? get formData => _formData;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['act'] = _act;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

class FormData {
  FormData({List<FormModel>? list}) {
    _list = list;
  }

  List<FormModel>? _list=[];

  List<FormModel>? get list => _list;

  FormData.fromJson(dynamic json) {

    print(json.toString());

    try{
      _list = [];
      if(json is List<dynamic>){
        for (var e in json) {
          _list?.add(FormModel(
              e.value['name'],
              e.value['label'],
              e.value['is_required'],
              e.value['extensions'],
              (e.value['options'] as List).map((e) => e as String).toList(),
              e.value['type'],
              ''
          ));
        }
        _list;
      } else{
        var map = Map.from(json).map((k, v) => MapEntry<String, dynamic>(k, v));
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
      }
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

class Withdraw {
  Withdraw({
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
      dynamic withdrawInformation, 
      String? status, 
      dynamic adminFeedback, 
      String? branchId, 
      String? branchStaffId, 
      String? createdAt, 
      String? updatedAt, 
      Method? method, 
      User? user,}){
    _id = id;
    _methodId = methodId;
    _userId = userId;
    _amount = amount;
    _currency = currency;
    _rate = rate;
    _charge = charge;
    _trx = trx;
    _finalAmount = finalAmount;
    _afterCharge = afterCharge;
    _withdrawInformation = withdrawInformation;
    _status = status;
    _adminFeedback = adminFeedback;
    _branchId = branchId;
    _branchStaffId = branchStaffId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _method = method;
    _user = user;
}

  Withdraw.fromJson(dynamic json) {
    _id = json['id'];
    _methodId = json['method_id'].toString();
    _userId = json['user_id'].toString();
    _amount = json['amount']!=null?json['amount'].toString():'';
    _currency = json['currency']!=null?json['currency'].toString():'';
    _rate = json['rate']!=null?json['rate'].toString():'';
    _charge = json['charge']!=null?json['charge'].toString():'';
    _trx = json['trx']!=null?json['trx'].toString():'';
    _finalAmount = json['final_amount']!=null?json['final_amount'].toString():'';
    _afterCharge = json['after_charge']!=null?json['after_charge'].toString():'';
    _withdrawInformation = json['withdraw_information'].toString();
    _status = json['status'].toString();
    _adminFeedback = json['admin_feedback'].toString();
    _branchId = json['branch_id'].toString();
    _branchStaffId = json['branch_staff_id'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _method = json['method'] != null ? Method.fromJson(json['method']) : null;
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  int? _id;
  String? _methodId;
  String? _userId;
  String? _amount;
  String? _currency;
  String? _rate;
  String? _charge;
  String? _trx;
  String? _finalAmount;
  String? _afterCharge;
  dynamic _withdrawInformation;
  String? _status;
  dynamic _adminFeedback;
  String? _branchId;
  String? _branchStaffId;
  String? _createdAt;
  String? _updatedAt;
  Method? _method;
  User? _user;

  int? get id => _id;
  String? get methodId => _methodId;
  String? get userId => _userId;
  String? get amount => _amount;
  String? get currency => _currency;
  String? get rate => _rate;
  String? get charge => _charge;
  String? get trx => _trx;
  String? get finalAmount => _finalAmount;
  String? get afterCharge => _afterCharge;
  dynamic get withdrawInformation => _withdrawInformation;
  String? get status => _status;
  dynamic get adminFeedback => _adminFeedback;
  String? get branchId => _branchId;
  String? get branchStaffId => _branchStaffId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Method? get method => _method;
  User? get user => _user;

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
    map['withdraw_information'] = _withdrawInformation;
    map['status'] = _status;
    map['admin_feedback'] = _adminFeedback;
    map['branch_id'] = _branchId;
    map['branch_staff_id'] = _branchStaffId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_method != null) {
      map['method'] = _method?.toJson();
    }
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }

}

class User {
  User({
    int? id,
    String? firstname,
    String? lastname,
    String? username,
    String? email,
    String? countryCode,
    String? mobile,
    String? balance,
    String? image,
    Address? address,
    String? status,
    String? kv,
    String? ev,
    String? sv,
    String? profileComplete,
    String? verCodeSendAt,
    String? ts,
    String? tv,
    String? tsc,
    String? sessionData,
    String? banReason,
    String? createdAt,
    String? updatedAt,}){
    _id = id;
    _firstname = firstname;
    _lastname = lastname;
    _username = username;
    _email = email;
    _countryCode = countryCode;
    _mobile = mobile;
    _refBy = refBy;
    _balance = balance;
    _image = image;
    _address = address;
    _status = status;
    _kv = kv;
    _ev = ev;
    _sv = sv;
    _profileComplete = profileComplete;
    _verCodeSendAt = verCodeSendAt;
    _ts = ts;
    _tv = tv;
    _tsc = tsc;
    _sessionData = sessionData;
    _banReason = banReason;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  User.fromJson(dynamic json) {
    _id = json['id'];
    _firstname = json['firstname'];
    _lastname = json['lastname'];
    _username = json['username'];
    _email = json['email'];
    _countryCode = json['country_code'].toString();
    _mobile = json['mobile'].toString();
    _refBy = json['ref_by'].toString();
    _balance = json['balance'].toString();
    _image = json['image'];
    _address = json['address'] != null ? Address.fromJson(json['address']) : null;
    _status = json['status'].toString();
    _kv = json['kv'].toString();
    _ev = json['ev'].toString();
    _sv = json['sv'].toString();
    _profileComplete = json['profile_complete'].toString();
    _verCodeSendAt = json['ver_code_send_at'].toString();
    _ts = json['ts'].toString();
    _tv = json['tv'].toString();
    _tsc = json['tsc'].toString();
    _sessionData = json['session_data'].toString();
    _banReason = json['ban_reason'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _firstname;
  String? _lastname;
  String? _username;
  String? _email;
  String? _countryCode;
  String? _mobile;
  String? _refBy;
  String? _balance;
  String? _image;
  Address? _address;
  String? _status;
  String? _kv;
  String? _ev;
  String? _sv;
  String? _profileComplete;
  String? _verCodeSendAt;
  String? _ts;
  String? _tv;
  String? _tsc;
  String? _sessionData;
  String? _banReason;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get firstname => _firstname;
  String? get lastname => _lastname;
  String? get username => _username;
  String? get email => _email;
  String? get countryCode => _countryCode;
  String? get mobile => _mobile;
  String? get refBy => _refBy;
  String? get balance => _balance;
  String? get image => _image;
  Address? get address => _address;
  String? get status => _status;
  String? get kv => _kv;
  String? get ev => _ev;
  String? get sv => _sv;
  String? get profileComplete => _profileComplete;
  String? get verCodeSendAt => _verCodeSendAt;
  String? get ts => _ts;
  String? get tv => _tv;
  String? get tsc => _tsc;
  String? get sessionData => _sessionData;
  String? get banReason => _banReason;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['firstname'] = _firstname;
    map['lastname'] = _lastname;
    map['username'] = _username;
    map['email'] = _email;
    map['country_code'] = _countryCode;
    map['mobile'] = _mobile;
    map['ref_by'] = _refBy;
    map['balance'] = _balance;
    map['image'] = _image;
    if (_address != null) {
      map['address'] = _address?.toJson();
    }
    map['status'] = _status;
    map['kv'] = _kv;
    map['ev'] = _ev;
    map['sv'] = _sv;
    map['profile_complete'] = _profileComplete;
    map['ver_code_send_at'] = _verCodeSendAt;
    map['ts'] = _ts;
    map['tv'] = _tv;
    map['tsc'] = _tsc;
    map['session_data'] = _sessionData;
    map['ban_reason'] = _banReason;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

class Address {
  Address({
    String? address,
    String? city,
    String? state,
    String? zip,
    String? country,}){
    _address = address;
    _city = city;
    _state = state;
    _zip = zip;
    _country = country;
  }

  Address.fromJson(dynamic json) {
    _address = json['address'];
    _city = json['city'];
    _state = json['state'].toString();
    _zip = json['zip'].toString();
    _country = json['country'];
  }
  String? _address;
  String? _city;
  String? _state;
  String? _zip;
  String? _country;

  String? get address => _address;
  String? get city => _city;
  String? get state => _state;
  String? get zip => _zip;
  String? get country => _country;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = _address;
    map['city'] = _city;
    map['state'] = _state;
    map['zip'] = _zip;
    map['country'] = _country;
    return map;
  }

}

class Method {
  Method({
      int? id, 
      String? formId, 
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
      String? updatedAt, 
      Form? form,}){
    _id = id;
    _formId = formId;
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
    _form = form;
}

  Method.fromJson(dynamic json) {
    _id = json['id'];
    _formId = json['form_id'].toString();
    _name = json['name']!=null?json['name'].toString():'';
    _minLimit = json['min_limit']!=null?json['max_limit'].toString():'';
    _maxLimit = json['max_limit']!=null?json['max_limit'].toString():'';
    _fixedCharge = json['fixed_charge']!=null?json['fixed_charge'].toString():'';
    _rate = json['rate']!=null?json['rate'].toString():'';
    _percentCharge = json['percent_charge']!=null?json['percent_charge'].toString():'';
    _currency = json['currency']!=null?json['currency'].toString():'';
    _description = json['description'].toString();
    _status = json['status']!=null?json['status'].toString():'';
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _form = json['form'] != null ? Form.fromJson(json['form']) : null;
  }
  int? _id;
  String? _formId;
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
  Form? _form;

  int? get id => _id;
  String? get formId => _formId;
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
  Form? get form => _form;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['form_id'] = _formId;
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
    if (_form != null) {
      map['form'] = _form?.toJson();
    }
    return map;
  }

}