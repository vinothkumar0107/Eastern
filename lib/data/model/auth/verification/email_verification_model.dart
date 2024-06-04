
import '../registration_response_model.dart';

class EmailVerificationModel {
  EmailVerificationModel({
      required int code,
      required String status,
      required String redirectUrl,
      Message? message,
      Data? data}){
    
    _status = status;
    _message = message;
    _redirectUrl=redirectUrl;
    _data=data;
}

  EmailVerificationModel.fromJson(dynamic json) {
    _code = json['code']??0;
    _redirectUrl = json['redirect_url'] ?? '';
    _status = json['status']??'-';
    _message = json['message'] != null ? Message.fromJson(json['message']) : null;
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

 late int _code;
 late String _status;
 late String _redirectUrl;

  Message? _message;
  Data? _data;

  int get code => _code;
  String get status => _status;
  String get redirectUrl => _redirectUrl;
  Message? get message => _message;
  Data? get data => _data;


  void setCode(int code){
    _code=code;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    
    map['status'] = _status;
    if (_message != null) {
      map['message'] = _message!.toJson();
    }
    if (_redirectUrl.isNotEmpty) {
      map['redirect_url'] = _redirectUrl;
    }
    return map;
  }

}

class Data{
  String? email;
  String? token;

  Data({this.email,this.token});
  Data.fromJson(dynamic json){
    if(json['email']!=null){
    email=json['email'].toString();
    }else{
      email=null;
    }
    if(json['code']!=null){
      token=json['code'].toString();
    }else{
      token=null;
    }
  }

}


