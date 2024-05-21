

import 'dart:io';

import 'package:flutter/foundation.dart';

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

    if(json!=null){
      _list = [];
      try{
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
        } else{
          var map = Map.from(json).map((k, v) => MapEntry<String, dynamic>(k, v));
          List<FormModel>? list = map.entries
              .map((e){
            return FormModel(
                e.value['name'],
                e.value['label'],
                e.value['is_required'],
                e.value['extensions'],
                (e.value['options'] as List).map((e) => e as String).toList(),
                e.value['type'],
                ''
            );
          },).toList();
          if (list.isNotEmpty) {
            list.removeWhere((element) => element.toString().isEmpty);
            _list?.addAll(list);
          }
          _list;
        }
      }catch(e){
        if (kDebugMode) {
          print(e.toString());
        }}
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