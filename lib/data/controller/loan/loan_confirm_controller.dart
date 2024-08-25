import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/string_format_helper.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/data/model/authorization/authorization_response_model.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/model/loan/loan_preview_response_model.dart';
import 'package:eastern_trust/data/repo/loan/loan_repo.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';

import '../../model/dynamic_form/form.dart';

class LoanConfirmController extends GetxController {

  LoanRepo repo;
  LoanConfirmController({required this.repo});

  bool isLoading = true;
  List<FormModel> formList = [];
  String selectOne = MyStrings.selectOne;
  String otpId = '';

  String planId = '';
  String amount = '';

  String planName = '';
  String totalInstallment = '';
  String perInstallment = '';
  String youNeedToPay = '';
  String chargeText = '';
  String maximumAmount = '';
  String installmentInterval = '';
  String perInstallmentPercentage = '';

  String currencySymbol = '';
  loadData(LoanPreviewResponseModel model) async {
    currencySymbol = repo.apiClient.getCurrencyOrUsername(isSymbol: true);
    setStatusTrue();
    planId = model.data?.plan?.id.toString()??'';
    amount = Converter.formatNumber(model.data?.amount??'');
    maximumAmount = Converter.formatNumber(model.data?.plan?.maximumAmount??'');
    planName = model.data?.plan?.name??'';
    installmentInterval = model.data?.plan?.installmentInterval??'';
    totalInstallment = model.data?.plan?.totalInstallment??'';
    perInstallmentPercentage = model.data?.plan?.perInstallment??'';
    perInstallment = model.data?.plan?.perInstallment??'';
    perInstallment =(((double.tryParse(amount)??0)*(double.tryParse(perInstallment)??0))/100).toString();
    youNeedToPay = Converter.mul(totalInstallment, perInstallment);
    String delayCharge = model.data?.delayCharge.toString()??'';
    chargeText = '${MyStrings.ifAnInstallmentIsDelayedFor} ${model.data?.plan?.delayValue} ${MyStrings.orMoreDaysThen} $currencySymbol$delayCharge ${MyStrings.willBeAppliedForEachDay}'.tr;

    List<FormModel>? tList = model.data?.formData?.list;
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
    setStatusFalse();
  }

  clearData() {
    formList.clear();
  }

  String twoFactorCode = '';
  bool submitLoading=false;
  Future<void>submitConfirmWithdrawRequest() async {
    List<String> list = hasError();
    if (list.isNotEmpty) {
      CustomSnackBar.error(errorList: list);
      return;
    }

    submitLoading=true;
    update();

    ResponseModel response = await repo.confirmLoanRequest(planId,amount,formList,twoFactorCode);
    if(response.statusCode==200){
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(response.responseJson));
      if(model.status?.toLowerCase() == MyStrings.success.toLowerCase()){
        Get.offAndToNamed(RouteHelper.loanScreen,arguments: 'loan-list');
        CustomSnackBar.success(successList:model.message?.success??[MyStrings.requestSuccess]);
      }else{
        CustomSnackBar.error(errorList: model.message?.error??[MyStrings.requestFail]);
      }
    } else{
      CustomSnackBar.error(errorList: [response.message]);
    }

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

  setStatusTrue() {
    isLoading = true;
    update();
  }

  setStatusFalse() {
    isLoading = false;
    update();
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
}
