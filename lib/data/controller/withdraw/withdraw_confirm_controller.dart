import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/data/model/authorization/authorization_response_model.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/model/profile/profile_response_model.dart';
import 'package:eastern_trust/data/model/withdraw/withdraw_method_response_model.dart';
import 'package:eastern_trust/data/model/withdraw/withdraw_preview_response_model.dart';
import 'package:eastern_trust/data/repo/account/profile_repo.dart';
import 'package:eastern_trust/data/repo/withdraw/withdraw_repo.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';
import 'package:file_picker/file_picker.dart';

class WithdrawConfirmController extends GetxController {
  WithdrawRepo repo;
  ProfileRepo profileRepo;

  WithdrawConfirmController({required this.repo,required this.profileRepo});

  bool isLoading = true;
  List<FormModel> formList = [];
  String selectOne = MyStrings.selectOne;
  String trxId='';

  WithdrawMethodResponseModel model = WithdrawMethodResponseModel();
  
  void initData()async{
    await getWithdrawConfirmScreenData();
  }

  Future<void>getWithdrawConfirmScreenData()async{
    ResponseModel response = await repo.getWithdrawConfirmScreenData(trxId);
    if(response.statusCode==200){
      WithdrawConfirmResponseModel model = WithdrawConfirmResponseModel.fromJson(jsonDecode(response.responseJson));
      if(model.status?.toLowerCase()==MyStrings.success.toLowerCase()){
        loadData(model);
      } else{
        CustomSnackBar.error(errorList: model.message?.error??[MyStrings.withdrawConfirmScreenNotFound]);
      }
    } else {
      CustomSnackBar.error(errorList: [response.message]);
    }
  }


  loadData(WithdrawConfirmResponseModel model) async {
    setStatusTrue();
    trxId=model.data?.withdraw?.trx??'';
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

    AuthorizationResponseModel model = await repo.confirmWithdrawRequest(trxId,formList,twoFactorCode);
    if(model.status?.toLowerCase() == MyStrings.success.toLowerCase()){
      CustomSnackBar.success(successList:model.message?.success??[MyStrings.requestSuccess]);
      Get.close(1);
      Get.offAndToNamed(RouteHelper.withdrawScreen);
    }else{
      CustomSnackBar.error(errorList: model.message?.error??[MyStrings.requestFail]);
    }

    submitLoading=false;
    update();
  }

  List<String> hasError() {
    List<String> errorList = [];
    for (var element in formList) {
      if (element.isRequired == 'required') {
        if (element.type == 'checkbox') {
          if (element.cbSelected == null || element.cbSelected!.isEmpty) {
            errorList.add('${element.name} ${MyStrings.isRequired}');
          }
        }
       else if (element.selectedValue == '' || element.selectedValue == selectOne ) {
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

  bool isTFAEnable = false;
  Future<void>checkTwoFactorStatus()async{
    ProfileResponseModel model = await profileRepo.loadProfileInfo();
    if(model.status?.toLowerCase()==MyStrings.success.toLowerCase()){
      isTFAEnable = model.data?.user?.ts=='1'?true:false;
    }
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
