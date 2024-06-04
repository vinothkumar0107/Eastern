import '../auth/registration_response_model.dart';

class ProfileResponseModel {
  ProfileResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      Data? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  ProfileResponseModel.fromJson(dynamic json) {
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
      User? user,}){
    _user = user;
}

  Data.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  User? _user;

  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }

}

class User {
  User({
    int? id,
    String? accountNumber,
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
    String? interestWallet,
    String? depositWallet,
    dynamic kycData,
    String? kv,
    String? ev,
    String? sv,
    int? regStep,
    String? verCode,
    String? verCodeSendAt,
    String? ts,
    String? tv,
    dynamic tsc,
    dynamic banReason,
    String? createdAt,
    String? updatedAt,}){
    _id = id;
    _accountNumber = accountNumber;
    _firstname = firstname;
    _lastname = lastname;
    _username = username;
    _email = email;
    _countryCode = countryCode;
    _mobile = mobile;
    _balance = balance;
    _image = image;
    _address = address;
    _status = status;
    _interestWallet = interestWallet;
    _depositWallet = depositWallet;
    _kycData = kycData;
    _tv = tv;
    _tv = ts;
    _banReason = banReason;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  User.fromJson(dynamic json) {
    _id = json['id'];
    _accountNumber = json['account_number'].toString();
    _firstname = json['firstname']??'';
    _lastname = json['lastname']??'';
    _username = json['username']??'';
    _email = json['email']??'';
    _countryCode = json['country_code'].toString();
    _mobile = json['mobile'].toString();
    _balance = json['balance']!=null?json['balance'].toString():'0';
    _image = json['image'];
    _address = json['address'] != null ? Address.fromJson(json['address']) : null;
    _status = json['status']!=null?json['status'].toString():'';
    _depositWallet = json['deposit_wallet']!=null?json['deposit_wallet'].toString():"0";
    _interestWallet = json['interest_wallet']!=null?json['interest_wallet'].toString():'0';
    _kycData = json['kyc_data'];
    _tv = json['tv'].toString();
    _ts = json['ts'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _accountNumber;
  String? _firstname;
  String? _lastname;
  String? _username;
  String? _email;
  String? _countryCode;
  String? _mobile;
  String? _balance;
  String? _image;
  Address? _address;
  String? _status;
  String? _depositWallet;
  String?  _interestWallet;
  dynamic _kycData;
  String?  _tv;
  String?  _ts;
  String? _verCode;
  String? _verCodeSendAt;
  dynamic _banReason;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get accountNumber => _accountNumber;
  String? get firstname => _firstname;
  String? get lastname => _lastname;
  String? get username => _username;
  String? get email => _email;
  String? get countryCode => _countryCode;
  String? get mobile => _mobile;
  String? get balance => _balance;
  String? get image => _image;
  Address? get address => _address;
  String? get status => _status;
  String? get depositWallet => _depositWallet;
  String? get interestWallet => _interestWallet;
  dynamic get kycData => _kycData;
  String?  get tv => _tv;
  String?  get ts => _ts;
  String? get verCode => _verCode;
  String? get verCodeSendAt => _verCodeSendAt;
  dynamic get banReason => _banReason;
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
    map['balance'] = _balance;
    map['image'] = _image;
    if (_address != null) {
      map['address'] = _address?.toJson();
    }
    map['status'] = _status;
    map['kyc_data'] = _kycData;

    map['ban_reason'] = _banReason;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

class Address {
  Address({
    String? country,
    String? address,
    String? state,
    String? zip,
    String? city,}){
    _country = country;
    _address = address;
    _state = state;
    _zip = zip;
    _city = city;
  }

  Address.fromJson(dynamic json) {
    _country  =   json['country'];
    _address  =   json['address'];
    _state    =   json['state'] !=null ? json['state'].toString():'';
    _zip      =   json['zip'] !=null? json['zip'].toString() : '';
    _city     =   json['city'] !=null ? json['city'].toString():'';
  }
  String? _country;
  String? _address;
  String? _state;
  String? _zip;
  String? _city;

  String? get country => _country;
  String? get address => _address;
  String? get state => _state;
  String? get zip => _zip;
  String? get city => _city;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['country'] = _country;
    map['address'] = _address;
    map['state'] = _state;
    map['zip'] = _zip;
    map['city'] = _city;
    return map;
  }

}
