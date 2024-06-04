import '../auth/registration_response_model.dart';

class DashboardResponseModel {
  DashboardResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      Data? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  DashboardResponseModel.fromJson(dynamic json) {
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
      User? user, 
      DashboardData? dashboardData, 
      LatestCredits? latestCredits, 
      LatestDebits? latestDebits,}){
    _user = user;
    _dashboardData = dashboardData;
    _latestCredits = latestCredits;
    _latestDebits = latestDebits;
}

  Data.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _dashboardData = json['dashboard_data'] != null ? DashboardData.fromJson(json['dashboard_data']) : null;
    _latestCredits = json['latest_credits'] != null ? LatestCredits.fromJson(json['latest_credits']) : null;
    _latestDebits = json['latest_debits'] != null ? LatestDebits.fromJson(json['latest_debits']) : null;
  }

  User? _user;
  DashboardData? _dashboardData;
  LatestCredits? _latestCredits;
  LatestDebits? _latestDebits;

  User? get user => _user;
  DashboardData? get dashboardData => _dashboardData;
  LatestCredits? get latestCredits => _latestCredits;
  LatestDebits? get latestDebits => _latestDebits;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    if (_dashboardData != null) {
      map['dashboard_data'] = _dashboardData?.toJson();
    }
    if (_latestCredits != null) {
      map['latest_credits'] = _latestCredits?.toJson();
    }
    if (_latestDebits != null) {
      map['latest_debits'] = _latestDebits?.toJson();
    }
    return map;
  }

}

class LatestDebits {
  LatestDebits({
      List<LatestDebitsData>? data,
      dynamic nextPageUrl, 
      String? path
      }){
    _data = data;
    _nextPageUrl = nextPageUrl;
    _path = path;
}

  LatestDebits.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(LatestDebitsData.fromJson(v));
      });
    }
    _nextPageUrl = json['next_page_url'];
    _path = json['path'];
  }

  List<LatestDebitsData>? _data;
  dynamic _nextPageUrl;
  String? _path;


  List<LatestDebitsData>? get data => _data;
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

class LatestDebitsData {
  LatestDebitsData({
      int? id, 
      String? userId, 
      String? branchId, 
      String? branchStaffId, 
      String? amount, 
      String? charge, 
      String? postBalance, 
      String? trxType, 
      String? trx, 
      String? details, 
      String? remark, 
      String? createdAt, 
      String? updatedAt}){
    _id = id;
    _userId = userId;
    _branchId = branchId;
    _branchStaffId = branchStaffId;
    _amount = amount;
    _charge = charge;
    _postBalance = postBalance;
    _trxType = trxType;
    _trx = trx;
    _details = details;
    _remark = remark;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  LatestDebitsData.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'].toString();
    _branchId = json['branch_id'].toString();
    _branchStaffId = json['branch_staff_id'].toString();
    _amount = json['amount'].toString();
    _charge = json['charge'].toString();
    _postBalance = json['post_balance'].toString();
    _trxType = json['trx_type'].toString();
    _trx = json['trx'].toString();
    _details = json['details']!=null?json['details'].toString():'';
    _remark = json['remark'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _userId;
  String? _branchId;
  String? _branchStaffId;
  String? _amount;
  String? _charge;
  String? _postBalance;
  String? _trxType;
  String? _trx;
  String? _details;
  String? _remark;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get userId => _userId;
  String? get branchId => _branchId;
  String? get branchStaffId => _branchStaffId;
  String? get amount => _amount;
  String? get charge => _charge;
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
    map['branch_id'] = _branchId;
    map['branch_staff_id'] = _branchStaffId;
    map['amount'] = _amount;
    map['charge'] = _charge;
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

class LatestCredits {
  LatestCredits({
      List<LatestCreditsData>? data,
      dynamic nextPageUrl, 
      String? path
     }){
    _data = data;
    _nextPageUrl = nextPageUrl;
    _path = path;
}

  LatestCredits.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(LatestCreditsData.fromJson(v));
      });
    }
    _nextPageUrl = json['next_page_url'];
    _path = json['path'];
  }

  List<LatestCreditsData>? _data;
  dynamic _nextPageUrl;
  String? _path;


  List<LatestCreditsData>? get data => _data;
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


class LatestCreditsData {
  LatestCreditsData({
      int? id, 
      String? userId, 
      String? branchId, 
      String? branchStaffId, 
      String? amount, 
      String? charge, 
      String? postBalance, 
      String? trxType, 
      String? trx, 
      String? details, 
      String? remark, 
      String? createdAt, 
      String? updatedAt}){
    _id = id;
    _userId = userId;
    _branchId = branchId;
    _branchStaffId = branchStaffId;
    _amount = amount;
    _charge = charge;
    _postBalance = postBalance;
    _trxType = trxType;
    _trx = trx;
    _details = details;
    _remark = remark;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  LatestCreditsData.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'].toString();
    _branchId = json['branch_id'].toString();
    _branchStaffId = json['branch_staff_id'].toString();
    _amount = json['amount']!=null?json['amount'].toString():'00';
    _charge = json['charge']!=null?json['charge'].toString():'0';
    _postBalance = json['post_balance']!=null?json['post_balance'].toString():'00';
    _trxType = json['trx_type'].toString();
    _trx = json['trx'].toString();
    _details = json['details'].toString();
    _remark = json['remark'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _userId;
  String? _branchId;
  String? _branchStaffId;
  String? _amount;
  String? _charge;
  String? _postBalance;
  String? _trxType;
  String? _trx;
  String? _details;
  String? _remark;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get userId => _userId;
  String? get branchId => _branchId;
  String? get branchStaffId => _branchStaffId;
  String? get amount => _amount;
  String? get charge => _charge;
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
    map['branch_id'] = _branchId;
    map['branch_staff_id'] = _branchStaffId;
    map['amount'] = _amount;
    map['charge'] = _charge;
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

class DashboardData {
  DashboardData({
      String? totalDeposit, 
      String? totalFdr,
      String? totalWithdraw, 
      String? totalLoan,
      String? totalDps,
      String? totalTrx,}){
    _totalDeposit = totalDeposit;
    _totalFdr = totalFdr;
    _totalWithdraw = totalWithdraw;
    _totalLoan = totalLoan;
    _totalDps = totalDps;
    _totalTrx = totalTrx;
}

  DashboardData.fromJson(dynamic json) {
    _totalDeposit = json['total_deposit'].toString();
    _totalFdr = json['total_fdr'].toString();
    _totalWithdraw = json['total_withdraw'].toString();
    _totalLoan = json['total_loan'].toString();
    _totalDps = json['total_dps'].toString();
    _totalTrx = json['total_trx'].toString();
  }

  String? _totalDeposit;
  String? _totalFdr;
  String? _totalWithdraw;
  String? _totalLoan;
  String? _totalDps;
  String? _totalTrx;

  String? get totalDeposit => _totalDeposit;
  String? get totalFdr => _totalFdr;
  String? get totalWithdraw => _totalWithdraw;
  String? get totalLoan => _totalLoan;
  String? get totalDps => _totalDps;
  String? get totalTrx => _totalTrx;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_deposit'] = _totalDeposit;
    map['total_fdr'] = _totalFdr;
    map['total_withdraw'] = _totalWithdraw;
    map['total_loan'] = _totalLoan;
    map['total_dps'] = _totalDps;
    map['total_trx'] = _totalTrx;
    return map;
  }

}

class User {
  User({
    int? id,
    String? branchId,
    String? branchStaffId,
    String? accountNumber,
    String? firstname,
    String? lastname,
    String? username,
    String? email,
    String? countryCode,
    String? mobile,
    String? refBy,
    String? referralCommissionCount,
    String? balance,
    String? image,
    Address? address,
    String? status,
    String? ev,
    String? sv,
    String? verCodeSendAt,
    String? ts,
    String? tv,
    dynamic tsc,
    String? kv,
    dynamic kycData,
    String? profileComplete,
    dynamic banReason,
    String? createdAt,
    String? updatedAt,}){

    _id = id;
    _branchId = branchId;
    _branchStaffId = branchStaffId;
    _accountNumber = accountNumber;
    _firstname = firstname;
    _lastname = lastname;
    _username = username;
    _email = email;
    _countryCode = countryCode;
    _mobile = mobile;
    _refBy = refBy;
    _referralCommissionCount = referralCommissionCount;
    _balance = balance;
    _image = image;
    _address = address;
    _status = status;
    _ev = ev;
    _sv = sv;
    _verCodeSendAt = verCodeSendAt;
    _ts = ts;
    _tv = tv;
    _tsc = tsc;
    _kv = kv;
    _kycData = kycData;
    _profileComplete = profileComplete;
    _banReason = banReason;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  User.fromJson(dynamic json) {
    _id = json['id'];
    _branchId = json['branch_id'].toString();
    _branchStaffId = json['branch_staff_id'].toString();
    _accountNumber = json['account_number'].toString();
    _firstname = json['firstname'];
    _lastname = json['lastname'];
    _username = json['username'];
    _email = json['email'];
    _countryCode = json['country_code'].toString();
    _mobile = json['mobile'].toString();
    _refBy = json['ref_by'].toString();
    _referralCommissionCount = json['referral_commission_count'].toString();
    _balance = json['balance'].toString();
    _image = json['image'];
    _address = json['address'] != null ? Address.fromJson(json['address']) : null;
    _status = json['status'].toString();
    _ev = json['ev'].toString();
    _sv = json['sv'].toString();
    _verCodeSendAt = json['ver_code_send_at'].toString();
    _ts = json['ts'].toString();
    _tv = json['tv'].toString();
    _tsc = json['tsc'].toString();
    _kv = json['kv'].toString();
    _profileComplete = json['profile_complete'].toString();
    _banReason = json['ban_reason'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  int? _id;
  String? _branchId;
  String? _branchStaffId;
  String? _accountNumber;
  String? _firstname;
  String? _lastname;
  String? _username;
  String? _email;
  String? _countryCode;
  String? _mobile;
  String? _refBy;
  String? _referralCommissionCount;
  String? _balance;
  String? _image;
  Address? _address;
  String? _status;
  String? _ev;
  String? _sv;
  String? _verCodeSendAt;
  String? _ts;
  String? _tv;
  dynamic _tsc;
  String? _kv;
  dynamic _kycData;
  String? _profileComplete;
  dynamic _banReason;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get branchId => _branchId;
  String? get branchStaffId => _branchStaffId;
  String? get accountNumber => _accountNumber;
  String? get firstname => _firstname;
  String? get lastname => _lastname;
  String? get username => _username;
  String? get email => _email;
  String? get countryCode => _countryCode;
  String? get mobile => _mobile;
  String? get refBy => _refBy;
  String? get referralCommissionCount => _referralCommissionCount;
  String? get balance => _balance;
  String? get image => _image;
  Address? get address => _address;
  String? get status => _status;
  String? get ev => _ev;
  String? get sv => _sv;
  String? get verCodeSendAt => _verCodeSendAt;
  String? get ts => _ts;
  String? get tv => _tv;
  dynamic get tsc => _tsc;
  String? get kv => _kv;
  dynamic get kycData => _kycData;
  String? get profileComplete => _profileComplete;
  dynamic get banReason => _banReason;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['branch_id'] = _branchId;
    map['branch_staff_id'] = _branchStaffId;
    map['account_number'] = _accountNumber;
    map['firstname'] = _firstname;
    map['lastname'] = _lastname;
    map['username'] = _username;
    map['email'] = _email;
    map['country_code'] = _countryCode;
    map['mobile'] = _mobile;
    map['ref_by'] = _refBy;
    map['referral_commission_count'] = _referralCommissionCount;
    map['balance'] = _balance;
    map['image'] = _image;
    if (_address != null) {
      map['address'] = _address?.toJson();
    }
    map['status'] = _status;
    map['ev'] = _ev;
    map['sv'] = _sv;
    map['ver_code_send_at'] = _verCodeSendAt;
    map['ts'] = _ts;
    map['tv'] = _tv;
    map['tsc'] = _tsc;
    map['kv'] = _kv;
    map['kyc_data'] = _kycData;
    map['profile_complete'] = _profileComplete;
    map['ban_reason'] = _banReason;
    map['created_a.toString()t'] = _createdAt;
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
    _country = json['country'].toString();
    _address = json['address'].toString();
    _state = json['state'].toString();
    _zip = json['zip'].toString();
    _city = json['city'].toString();
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