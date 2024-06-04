import '../../auth/registration_response_model.dart';
import '../../dynamic_form/form.dart';

class WireTransferResponseModel {
  WireTransferResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      Data? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  WireTransferResponseModel.fromJson(dynamic json) {
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
      Setting? setting, 
      Form? form,}){
    _setting = setting;
    _form = form;
}

  Data.fromJson(dynamic json) {
    _setting = json['setting'] != null ? Setting.fromJson(json['setting']) : null;
    _form = json['form'] != null ? Form.fromJson(json['form']) : null;
  }

  Setting? _setting;
  Form? _form;

  Setting? get setting => _setting;
  Form? get form => _form;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_setting != null) {
      map['setting'] = _setting?.toJson();
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

class Setting {
  Setting({
      int? id, 
      String? minimumLimit, 
      String? maximumLimit, 
      String? dailyMaximumLimit, 
      String? monthlyMaximumLimit, 
      String? dailyTotalTransaction, 
      String? monthlyTotalTransaction, 
      String? fixedCharge, 
      String? percentCharge, 
      String? instruction, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _minimumLimit = minimumLimit;
    _maximumLimit = maximumLimit;
    _dailyMaximumLimit = dailyMaximumLimit;
    _monthlyMaximumLimit = monthlyMaximumLimit;
    _dailyTotalTransaction = dailyTotalTransaction;
    _monthlyTotalTransaction = monthlyTotalTransaction;
    _fixedCharge = fixedCharge;
    _percentCharge = percentCharge;
    _instruction = instruction;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Setting.fromJson(dynamic json) {
    _id = json['id'];
    _minimumLimit = json['minimum_limit']!=null?json['minimum_limit'].toString():'';
    _maximumLimit = json['maximum_limit']!=null?json['maximum_limit'].toString():'';
    _dailyMaximumLimit = json['daily_maximum_limit']!=null?json['daily_maximum_limit'].toString():'';
    _monthlyMaximumLimit = json['monthly_maximum_limit']!=null?json['monthly_maximum_limit'].toString():'';
    _dailyTotalTransaction = json['daily_total_transaction'].toString();
    _monthlyTotalTransaction = json['monthly_total_transaction'].toString();
    _fixedCharge = json['fixed_charge']!=null?json['fixed_charge'].toString():'';
    _percentCharge = json['percent_charge']!=null?json['percent_charge'].toString():'';
    _instruction = json['instruction'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _minimumLimit;
  String? _maximumLimit;
  String? _dailyMaximumLimit;
  String? _monthlyMaximumLimit;
  String? _dailyTotalTransaction;
  String? _monthlyTotalTransaction;
  String? _fixedCharge;
  String? _percentCharge;
  String? _instruction;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get minimumLimit => _minimumLimit;
  String? get maximumLimit => _maximumLimit;
  String? get dailyMaximumLimit => _dailyMaximumLimit;
  String? get monthlyMaximumLimit => _monthlyMaximumLimit;
  String? get dailyTotalTransaction => _dailyTotalTransaction;
  String? get monthlyTotalTransaction => _monthlyTotalTransaction;
  String? get fixedCharge => _fixedCharge;
  String? get percentCharge => _percentCharge;
  String? get instruction => _instruction;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['minimum_limit'] = _minimumLimit;
    map['maximum_limit'] = _maximumLimit;
    map['daily_maximum_limit'] = _dailyMaximumLimit;
    map['monthly_maximum_limit'] = _monthlyMaximumLimit;
    map['daily_total_transaction'] = _dailyTotalTransaction;
    map['monthly_total_transaction'] = _monthlyTotalTransaction;
    map['fixed_charge'] = _fixedCharge;
    map['percent_charge'] = _percentCharge;
    map['instruction'] = _instruction;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}