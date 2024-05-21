
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/data/model/authorization/authorization_response_model.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/model/transfer/wire_transfer/wire_transfer_response_model.dart';
import 'package:eastern_trust/data/repo/transfer_repo/transfer_repo.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';
import '../../model/dynamic_form/form.dart';

class WireTransferController extends GetxController{

  TransferRepo repo;
  WireTransferController({required this.repo});

  bool isLoading = true;
  List<FormModel> formList = [];
  String selectOne = MyStrings.selectOne;
  String otpId = '';


  List<String>authorizationList = [];
  String? selectedAuthorizationMode = MyStrings.selectOne;

  String currency = "";
  String currencySymbol = "";
  Setting? setting = Setting();

  void changeAuthorizationMode(String? value){
    if(value!=null){
      selectedAuthorizationMode = value;
      update();
    }
  }


  initData()async {
    isLoading = true;
    update();
    currency = repo.apiClient.getCurrencyOrUsername();
    currencySymbol = repo.apiClient.getCurrencyOrUsername(isSymbol: true);
    authorizationList = repo.apiClient.getAuthorizationList();
    ResponseModel response = await repo.getWireTransferData();
    if (response.statusCode == 200) {
      WireTransferResponseModel model = WireTransferResponseModel.fromJson(jsonDecode(response.responseJson));
      if(model.status?.toLowerCase()==MyStrings.success.toLowerCase()) {
         await loadData(model);
      } else {
        CustomSnackBar.error(errorList: model.message?.error??[MyStrings.somethingWentWrong]);
      }
    } else {
      if(response.statusCode==503){
        changeNoInternetStatus(false);
      }
      CustomSnackBar.error(errorList: [response.message]);
    }

    isLoading = false;
    update();

  }

  loadData(WireTransferResponseModel model) async {
      setting = model.data?.setting;
      List<FormModel>? tList = model.data?.form?.formData?.list;
      if (tList != null && tList.isNotEmpty) {
        formList.clear();
        for (var element in tList) {
          if (element.type == 'select') {
            bool? isEmpty = element.options?.isEmpty;
            bool empty = isEmpty ?? true;
            if (element.options != null && empty != true) {
              element.options?.insert(0, selectOne);
              element.selectedValue = element.options?.first;
              formList.add(element);
            }
          } else {
            formList.add(element);
          }
        }
      }
    }

    TextEditingController amountController = TextEditingController();
    String twoFactorCode = '';
    bool submitLoading=false;

    Future<void>submitWireTransferRequest() async {

      String amount = amountController.text;
      if(amount.isEmpty){
        CustomSnackBar.error(errorList: [MyStrings.invalidAmount]);
        return ;
      }

      List<String> list = hasError();
      if (list.isNotEmpty) {
        CustomSnackBar.error(errorList: list);
        return;
      }

      submitLoading=true;
      update();

      ResponseModel response = await repo.submitWireTransferRequest(amount,selectedAuthorizationMode??'',formList,twoFactorCode);
      if(response.statusCode==200){
        AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(response.responseJson));
        if(model.status?.toLowerCase() == MyStrings.success.toLowerCase()){
          String otpId = model.data?.otpId??'';
          if(otpId.isEmpty){
            Get.offAndToNamed(RouteHelper.transferHistoryScreen);
            CustomSnackBar.success(successList:model.message?.success??[MyStrings.requestSuccess]);
          } else{
            Get.offAndToNamed(RouteHelper.otpScreen,arguments:[RouteHelper.transferHistoryScreen,otpId,selectedAuthorizationMode?.toLowerCase().toString()]);
          }
        }else{
          CustomSnackBar.error(errorList: model.message?.error??[MyStrings.requestFail]);
        }
      } else{
        CustomSnackBar.error(errorList: [response.message]);
      }

      amountController.text = '';
      submitLoading=false;
      update();
    }

    List<String> hasError() {
      List<String> errorList = [];
      for (var element in formList) {
        if (element.isRequired == 'required') {
          if (element.selectedValue == '' || element.selectedValue == selectOne ) {
            errorList.add('${element.name} ${MyStrings.isRequired}');
          }
        }
      }
      return errorList;
    }

    void changeSelectedValue(value, int index) {
      formList[index].selectedValue = value;
      update();
    }

    void changeSelectedRadioBtnValue(int listIndex, int selectedIndex) {
      formList[listIndex].selectedValue = formList[listIndex].options?[selectedIndex];
      update();
    }

    void changeSelectedCheckBoxValue(int listIndex, String value) {

      List<String>list=value.split('_');
      int index=int.parse(list[0]);
      bool status=list[1]=='true'?true:false;

      List<String>?selectedValue=formList[listIndex].cbSelected;

      if(selectedValue!=null){
        String? value=formList[listIndex].options?[index];
        if(status){
          if(!selectedValue.contains(value)){
            selectedValue.add(value!);
            formList[listIndex].cbSelected = selectedValue;
            update();
          }
        }else{
          if(selectedValue.contains(value)){
            selectedValue.removeWhere((element) => element==value);
            formList[listIndex].cbSelected=selectedValue;
            update();
          }
        }
      }else{
        selectedValue=[];
        String? value=formList[listIndex].options?[index];
        if(status){
          if(!selectedValue.contains(value)){
            selectedValue.add(value!);
            formList[listIndex].cbSelected=selectedValue;
            update();
          }
        }else{
          if(selectedValue.contains(value)){
            selectedValue.removeWhere((element) => element==value);
            formList[listIndex].cbSelected=selectedValue;
            update();
          }
        }
      }

    }

    void changeSelectedFile(File file, int index) {
      formList[index].file = file;
      update();
    }


    void pickFile(int index) async{

      FilePickerResult? result = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: FileType.custom,
          allowedExtensions: ['jpg', 'png', 'jpeg', 'pdf', 'doc', 'docx']);

      if (result == null) return;

      formList[index].file = File(result.files.single.path!);
      String fileName = result.files.single.name;
      formList[index].selectedValue = fileName;
      update();
      return;
    }

   bool noInternet = false;
   void changeNoInternetStatus(bool status) {
    noInternet = status;
    update();
    }
  }

