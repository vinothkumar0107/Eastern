import '../auth/registration_response_model.dart';

class DpsPlanResponseModel {
  DpsPlanResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      Data? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  DpsPlanResponseModel.fromJson(dynamic json) {
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


}

class Data {
  Data({
      DpsPlans? dpsPlans,}){
    _dpsPlans = dpsPlans;
}

  Data.fromJson(dynamic json) {
    _dpsPlans = json['dps_plans'] != null ? DpsPlans.fromJson(json['dps_plans']) : null;
  }
  DpsPlans? _dpsPlans;

  DpsPlans? get dpsPlans => _dpsPlans;


}

class DpsPlans {
  DpsPlans({
      List<DpsPlansData>? data,
      dynamic nextPageUrl
  }){
    _data = data;
    _nextPageUrl = nextPageUrl;
}

  DpsPlans.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(DpsPlansData.fromJson(v));
      });
    }
    _nextPageUrl = json['next_page_url'];
  }
  List<DpsPlansData>? _data;
  dynamic _nextPageUrl;

  List<DpsPlansData>? get data => _data;
  dynamic get nextPageUrl => _nextPageUrl;

}

class DpsPlansData {
  DpsPlansData({
      int? id, 
      String? name, 
      String? perInstallment, 
      String? installmentInterval, 
      String? totalInstallment, 
      String? interestRate, 
      String? finalAmount, 
      String? delayValue, 
      String? fixedCharge, 
      String? percentCharge, 
      String? status, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _perInstallment = perInstallment;
    _installmentInterval = installmentInterval;
    _totalInstallment = totalInstallment;
    _interestRate = interestRate;
    _finalAmount = finalAmount;
    _delayValue = delayValue;
    _fixedCharge = fixedCharge;
    _percentCharge = percentCharge;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  DpsPlansData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'].toString();
    _perInstallment = json['per_installment']!=null?json['per_installment'].toString():'';
    _installmentInterval = json['installment_interval']!=null?json['installment_interval'].toString():'';
    _totalInstallment = json['total_installment']!=null?json['total_installment'].toString():'';
    _interestRate = json['interest_rate']!=null?json['interest_rate'].toString():'';
    _finalAmount = json['final_amount']!=null?json['final_amount'].toString():'';
    _delayValue = json['delay_value']!=null?json['delay_value'].toString():'';
    _fixedCharge = json['fixed_charge']!=null?json['fixed_charge'].toString():'';
    _percentCharge = json['percent_charge']!=null?json['percent_charge'].toString():'';
    _status = json['status'].toString();
    _createdAt = json['created_at'].toString();
    _updatedAt = json['updated_at'].toString();
  }
  int? _id;
  String? _name;
  String? _perInstallment;
  String? _installmentInterval;
  String? _totalInstallment;
  String? _interestRate;
  String? _finalAmount;
  String? _delayValue;
  String? _fixedCharge;
  String? _percentCharge;
  String? _status;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get name => _name;
  String? get perInstallment => _perInstallment;
  String? get installmentInterval => _installmentInterval;
  String? get totalInstallment => _totalInstallment;
  String? get interestRate => _interestRate;
  String? get finalAmount => _finalAmount;
  String? get delayValue => _delayValue;
  String? get fixedCharge => _fixedCharge;
  String? get percentCharge => _percentCharge;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['per_installment'] = _perInstallment;
    map['installment_interval'] = _installmentInterval;
    map['total_installment'] = _totalInstallment;
    map['interest_rate'] = _interestRate;
    map['final_amount'] = _finalAmount;
    map['delay_value'] = _delayValue;
    map['fixed_charge'] = _fixedCharge;
    map['percent_charge'] = _percentCharge;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}