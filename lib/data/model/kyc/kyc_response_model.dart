

import 'dart:io';

import 'package:flutter/foundation.dart';

import '../auth/registration_response_model.dart';

class KycResponseModel {
  KycResponseModel({
    String? remark,
    String? status,
    Message? message,
    Data? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
  }

  KycResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status']!=null? json['status'].toString():'';
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
    Form? form,}){
    _form = form;
  }

  Data.fromJson(dynamic json) {
    _form = json['form'] != null ? Form.fromJson(json['form']) : null;
  }
  Form? _form;

  Form? get form => _form;

}

class Form {
  Form({List<FormModel>?list}){
    _list=list;
  }

  List<FormModel>? _list=[];
  List<FormModel>? get list => _list;

  Form.fromJson(dynamic json) {
    var map=Map.from(json).map((key, value) => MapEntry(key, value));
    try{

      List<FormModel>?list=map.entries.map((e) =>
          FormModel(
              e.value['name'],
              e.value['label'],
              e.value['is_required'],
              e.value['extensions'],
              (e.value['options'] as List).map((e) => e as String).toList(),
              e.value['type'],
              ''
          ),).toList();

      if(list.isNotEmpty){
        list.removeWhere((element) => element.toString().isEmpty);
        _list?.addAll(list);
      }
      _list;

    }catch(e){
      if(kDebugMode){
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
  File? imageFile;
  List<String>?cbSelected;

  FormModel(this.name, this.label, this.isRequired, this.extensions, this.options, this.type,this.selectedValue,{this.cbSelected,this.imageFile});

}
