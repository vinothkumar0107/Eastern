class CommonApiResponseModel {
  CommonApiResponseModel({
      String? remark, 
      String? status, 
      Message? message,}){
    _remark = remark;
    _status = status;
    _message = message;
}

  CommonApiResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status'];
    _message = json['message'] != null ? Message.fromJson(json['message']) : null;
  }
  String? _remark;
  String? _status;
  Message? _message;

  String? get remark => _remark;
  String? get status => _status;
  Message? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remark'] = _remark;
    map['status'] = _status;
    if (_message != null) {
      map['message'] = _message?.toJson();
    }
    return map;
  }

}

class Message {
  Message({
      List<String>? error, 
      List<String>? success,}){
    _error = error;
    _success = success;
}

  Message.fromJson(dynamic json) {
    _error = json['error'] != null ? json['error'].cast<String>() : [];
    _success = json['success'] != null ? json['success'].cast<String>() : [];
  }
  List<String>? _error;
  List<String>? _success;

  List<String>? get error => _error;
  List<String>? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['success'] = _success;
    return map;
  }

}