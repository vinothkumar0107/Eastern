import '../auth/registration_response_model.dart';

class GeneralSettingsResponseModel {
  GeneralSettingsResponseModel({
    String? remark,
    String? status,
    Message? message,
    Data? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
  }

  GeneralSettingsResponseModel.fromJson(dynamic json) {
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
    GeneralSetting? generalSetting,}){
    _generalSetting = generalSetting;
  }

  Data.fromJson(dynamic json) {
    _generalSetting = json['general_setting'] != null ? GeneralSetting.fromJson(json['general_setting']) : null;
  }
  GeneralSetting? _generalSetting;

  GeneralSetting? get generalSetting => _generalSetting;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_generalSetting != null) {
      map['general_setting'] = _generalSetting?.toJson();
    }
    return map;
  }

}

class GeneralSetting {
  GeneralSetting({
    int? id,
    String? siteName,
    String? curText,
    String? curSym,
    String? emailFrom,
    String? emailTemplate,
    String? smsBody,
    String? smsFrom,
    String? baseColor,
    String? secondaryColor,
    String? kv,
    String? ev,
    String? en,
    String? sv,
    String? sn,
    String? pn,
    String? forceSsl,
    String? maintenanceMode,
    String? securePassword,
    String? agree,
    String? registration,
    String? activeTemplate,
    String? systemInfo,
    Modules? modules,
    String? accountNoLength,
    String? accountNoPrefix,
    String? otpTime,
    String? dailyTransferLimit,
    String? monthlyTransferLimit,
    String? minimumTransferLimit,
    String? fixedTransferCharge,
    String? percentTransferCharge,
    String? referralCommissionCount,
    String? lastDpsCron,
    String? lastFdrCron,
    String? lastLoanCron,
    dynamic createdAt,
    String? updatedAt,}){
    _id = id;
    _siteName = siteName;
    _curText = curText;
    _curSym = curSym;
    _emailFrom = emailFrom;
    _emailTemplate = emailTemplate;
    _smsBody = smsBody;
    _smsFrom = smsFrom;
    _baseColor = baseColor;
    _secondaryColor = secondaryColor;
    _kv = kv;
    _ev = ev;
    _en = en;
    _sv = sv;
    _sn = sn;
    _pn = pn;
    _forceSsl = forceSsl;
    _maintenanceMode = maintenanceMode;
    _securePassword = securePassword;
    _agree = agree;
    _registration = registration;
    _activeTemplate = activeTemplate;
    _systemInfo = systemInfo;
    _modules = modules;
    _accountNoLength = accountNoLength;
    _accountNoPrefix = accountNoPrefix;
    _otpTime = otpTime;
    _dailyTransferLimit = dailyTransferLimit;
    _monthlyTransferLimit = monthlyTransferLimit;
    _minimumTransferLimit = minimumTransferLimit;
    _fixedTransferCharge = fixedTransferCharge;
    _percentTransferCharge = percentTransferCharge;
    _referralCommissionCount = referralCommissionCount;
    _lastDpsCron = lastDpsCron;
    _lastFdrCron = lastFdrCron;
    _lastLoanCron = lastLoanCron;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  GeneralSetting.fromJson(dynamic json) {
    _id = json['id'];
    _siteName = json['site_name'].toString();
    _curText = json['cur_text'].toString();
    _curSym = json['cur_sym'].toString();
    _emailFrom = json['email_from'].toString();
    _baseColor = json['base_color'].toString();
    _secondaryColor = json['secondary_color'].toString();
    _kv = json['kv'].toString();
    _ev = json['ev'].toString();
    _en = json['en'].toString();
    _sv = json['sv'].toString();
    _sn = json['sn'].toString();
    _pn = json['pn'].toString();
    _forceSsl = json['force_ssl'].toString();
    _maintenanceMode = json['maintenance_mode'].toString();
    _securePassword = json['secure_password'].toString();
    _agree = json['agree'].toString();
    _registration = json['registration'].toString();
    _activeTemplate = json['active_template'].toString();
    _systemInfo = json['system_info'].toString();
    _modules = json['modules'] != null ? Modules.fromJson(json['modules']) : null;
    _accountNoLength = json['account_no_length'].toString();
    _accountNoPrefix = json['account_no_prefix'].toString();
    _otpTime = json['otp_time'].toString();
    _dailyTransferLimit = json['daily_transfer_limit'].toString();
    _monthlyTransferLimit = json['monthly_transfer_limit'].toString();
    _minimumTransferLimit = json['minimum_transfer_limit'].toString();
    _fixedTransferCharge = json['fixed_transfer_charge'].toString();
    _percentTransferCharge = json['percent_transfer_charge'].toString();
    _referralCommissionCount = json['referral_commission_count'].toString();
    _lastDpsCron = json['last_dps_cron'].toString();
    _lastFdrCron = json['last_fdr_cron'].toString();
    _lastLoanCron = json['last_loan_cron'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _siteName;
  String? _curText;
  String? _curSym;
  String? _emailFrom;
  String? _emailTemplate;
  String? _smsBody;
  String? _smsFrom;
  String? _baseColor;
  String? _secondaryColor;
  String? _kv;
  String? _ev;
  String? _en;
  String? _sv;
  String? _sn;
  String? _pn;
  String? _forceSsl;
  String? _maintenanceMode;
  String? _securePassword;
  String? _agree;
  String? _registration;
  String? _activeTemplate;
  String? _systemInfo;
  Modules? _modules;
  String? _accountNoLength;
  String? _accountNoPrefix;
  String? _otpTime;
  String? _dailyTransferLimit;
  String? _monthlyTransferLimit;
  String? _minimumTransferLimit;
  String? _fixedTransferCharge;
  String? _percentTransferCharge;
  String? _referralCommissionCount;
  String? _lastDpsCron;
  String? _lastFdrCron;
  String? _lastLoanCron;
  dynamic _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get siteName => _siteName;
  String? get curText => _curText;
  String? get curSym => _curSym;
  String? get emailFrom => _emailFrom;
  String? get emailTemplate => _emailTemplate;
  String? get smsBody => _smsBody;
  String? get smsFrom => _smsFrom;
  String? get baseColor => _baseColor;
  String? get secondaryColor => _secondaryColor;
  String? get kv => _kv;
  String? get ev => _ev;
  String? get en => _en;
  String? get sv => _sv;
  String? get sn => _sn;
  String? get pn => _pn;
  String? get forceSsl => _forceSsl;
  String? get maintenanceMode => _maintenanceMode;
  String? get securePassword => _securePassword;
  String? get agree => _agree;
  String? get registration => _registration;
  String? get activeTemplate => _activeTemplate;
  String? get systemInfo => _systemInfo;
  Modules? get modules => _modules;
  String? get accountNoLength => _accountNoLength;
  String? get accountNoPrefix => _accountNoPrefix;
  String? get otpTime => _otpTime;
  String? get dailyTransferLimit => _dailyTransferLimit;
  String? get monthlyTransferLimit => _monthlyTransferLimit;
  String? get minimumTransferLimit => _minimumTransferLimit;
  String? get fixedTransferCharge => _fixedTransferCharge;
  String? get percentTransferCharge => _percentTransferCharge;
  String? get referralCommissionCount => _referralCommissionCount;
  String? get lastDpsCron => _lastDpsCron;
  String? get lastFdrCron => _lastFdrCron;
  String? get lastLoanCron => _lastLoanCron;
  dynamic get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['site_name'] = _siteName;
    map['cur_text'] = _curText;
    map['cur_sym'] = _curSym;
    map['email_from'] = _emailFrom;
    map['email_template'] = _emailTemplate;
    map['sms_body'] = _smsBody;
    map['sms_from'] = _smsFrom;
    map['base_color'] = _baseColor;
    map['secondary_color'] = _secondaryColor;
    map['kv'] = _kv;
    map['ev'] = _ev;
    map['en'] = _en;
    map['sv'] = _sv;
    map['sn'] = _sn;
    map['pn'] = _pn;
    map['force_ssl'] = _forceSsl;
    map['maintenance_mode'] = _maintenanceMode;
    map['secure_password'] = _securePassword;
    map['agree'] = _agree;
    map['registration'] = _registration;
    map['active_template'] = _activeTemplate;
    map['system_info'] = _systemInfo;
    if (_modules != null) {
      map['modules'] = _modules?.toJson();
    }
    map['account_no_length'] = _accountNoLength;
    map['account_no_prefix'] = _accountNoPrefix;
    map['otp_time'] = _otpTime;
    map['daily_transfer_limit'] = _dailyTransferLimit;
    map['monthly_transfer_limit'] = _monthlyTransferLimit;
    map['minimum_transfer_limit'] = _minimumTransferLimit;
    map['fixed_transfer_charge'] = _fixedTransferCharge;
    map['percent_transfer_charge'] = _percentTransferCharge;
    map['referral_commission_count'] = _referralCommissionCount;
    map['last_dps_cron'] = _lastDpsCron;
    map['last_fdr_cron'] = _lastFdrCron;
    map['last_loan_cron'] = _lastLoanCron;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

class Modules {
  Modules({
    String? deposit,
    String? withdraw,
    String? dps,
    String? fdr,
    String? loan,
    String? ownBank,
    String? otherBank,
    String? otpEmail,
    String? otpSms,
    String? branchCreateUser,
    String? wireTransfer,
    String? referralSystem,
    String? airtime,
  }){
    _deposit = deposit;
    _withdraw = withdraw;
    _dps = dps;
    _fdr = fdr;
    _loan = loan;
    _ownBank = ownBank;
    _otherBank = otherBank;
    _otpEmail = otpEmail;
    _otpSms = otpSms;
    _branchCreateUser = branchCreateUser;
    _wireTransfer = wireTransfer;
    _referralSystem = referralSystem;
    _airtime = airtime;
  }

  Modules.fromJson(dynamic json) {
    _deposit = json['deposit'].toString();
    _withdraw = json['withdraw'].toString();
    _dps = json['dps'].toString();
    _fdr = json['fdr'].toString();
    _loan = json['loan'].toString();
    _ownBank = json['own_bank'].toString();
    _otherBank = json['other_bank'].toString();
    _otpEmail = json['otp_email'].toString();
    _otpSms = json['otp_sms'].toString();
    _branchCreateUser = json['branch_create_user'].toString();
    _wireTransfer = json['wire_transfer'].toString();
    _referralSystem = json['referral_system'].toString();
    _airtime = json['airtime'].toString();
  }
  String? _deposit;
  String? _withdraw;
  String? _dps;
  String? _fdr;
  String? _loan;
  String? _ownBank;
  String? _otherBank;
  String? _otpEmail;
  String? _otpSms;
  String? _branchCreateUser;
  String? _wireTransfer;
  String? _referralSystem;
  String? _airtime;

  String? get deposit => _deposit;
  String? get withdraw => _withdraw;
  String? get dps => _dps;
  String? get fdr => _fdr;
  String? get loan => _loan;
  String? get ownBank => _ownBank;
  String? get otherBank => _otherBank;
  String? get otpEmail => _otpEmail;
  String? get otpSms => _otpSms;
  String? get branchCreateUser => _branchCreateUser;
  String? get wireTransfer => _wireTransfer;
  String? get referralSystem => _referralSystem;
  String? get airtime => _airtime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['deposit'] = _deposit;
    map['withdraw'] = _withdraw;
    map['dps'] = _dps;
    map['airtime'] = _airtime;
    map['fdr'] = _fdr;
    map['loan'] = _loan;
    map['own_bank'] = _ownBank;
    map['other_bank'] = _otherBank;
    map['otp_email'] = _otpEmail;
    map['otp_sms'] = _otpSms;
    map['branch_create_user'] = _branchCreateUser;
    map['wire_transfer'] = _wireTransfer;
    map['referral_system'] = _referralSystem;
    return map;
  }

}








