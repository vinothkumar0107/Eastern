import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/data/model/authorization/authorization_response_model.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/repo/auth/two_factor_repo.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';

import '../../model/auth/two_factor_model.dart';
import '../../model/dashboard/dashboard_response_model.dart';
import '../../repo/home/home_repo.dart';

class TwoFactorController extends GetxController {
  GoogleAuthenticatorModel? authenticatorModel;
  TwoFactorRepo repo;
  HomeRepo homeRepo;
  TwoFactorController({required this.repo, this.authenticatorModel, required this.homeRepo});
  bool isProfileCompleteEnable = false;
  bool submitLoading=false;
  String currentText='';
  bool isLoading=true;
  String isTwoFactorEnabled="";
  TextEditingController authenticationCode = TextEditingController();
  EnableGoogleAuthenticatorModel? enableModel;



  verifyYourSms(String currentText) async {

    if (currentText.isEmpty) {
      CustomSnackBar.error(errorList: [MyStrings.otpFieldEmptyMsg]);
      return;
    }

    submitLoading = true;
    update();

    ResponseModel responseModel = await repo.verify(currentText);

    if (responseModel.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModel.responseJson));

      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {

        CustomSnackBar.success(successList:model.message?.success ?? [MyStrings.requestSuccess]);
        Get.offAndToNamed(isProfileCompleteEnable? RouteHelper.profileCompleteScreen : RouteHelper.homeScreen);

      } else {
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.requestFail]);
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }
    submitLoading = false;
    update();

  }

  Future<void> getTwoFactor() async{
    isLoading=true;
    ResponseModel? resModel = await homeRepo.getData();
    print("resModel =====> $resModel");
    if(resModel.statusCode == 200){
      print("statusCode =====> ${resModel.statusCode}");
      DashboardResponseModel dashModel = DashboardResponseModel.fromJson(jsonDecode(resModel.responseJson));
      if(dashModel.status.toString().toLowerCase() == 'success'){
        isTwoFactorEnabled = dashModel.data?.user?.ts.toString() ?? "0";
        print("isTwoFactorEnabled 1=====> $isTwoFactorEnabled");
      }
    }
    print("isTwoFactorEnabled 2=====> $isTwoFactorEnabled");
    if (isTwoFactorEnabled == "1"){
      isLoading = false;
      update();
      return;
    }
    print("isTwoFactorEnabled 3=====> $isTwoFactorEnabled");
    ResponseModel responseModel = await repo.getTwoFactorData();
    if(responseModel.statusCode == 200){
      GoogleAuthenticatorModel model = responseFromJson(responseModel.responseJson);
      if(model.status.toString().toLowerCase() == "success"){
        authenticatorModel = model;
      }
      else{
        CustomSnackBar.error(errorList: [model.message]);
      }
    }
    else{
      CustomSnackBar.error(errorList: [responseModel.message]);
    }
    isLoading = false;
    update();
  }

  Future<void> enableGoogleAuthenticate() async{
    dismissKeyboard();
    if (authenticationCode.text.isEmpty){
      CustomSnackBar.error(errorList: [MyStrings.codeIsRequired]);
      return;
    }

    final param = {
      'code': authenticationCode.text.toString(),
      'key' : "${authenticatorModel?.data.secret.toString()}"
    };
    submitLoading = true;
    update();
    ResponseModel responseModel = await repo.enableAuthenticate(param);
    print("empty check 1=======>");
    if(responseModel.statusCode == 200){
      EnableGoogleAuthenticatorModel model = responseFromJsonEnable(responseModel.responseJson);
      print("empty check 2=======>");
      if(model.status.toString().toLowerCase() == "success"){
        isTwoFactorEnabled = "1";
        enableModel = model;
        CustomSnackBar.success(successList: [model.message]);
      }
      else{
        CustomSnackBar.error(errorList: [model.message]);
      }
    }
    else{
      CustomSnackBar.error(errorList: [responseModel.message]);
    }
    submitLoading = false;
    authenticationCode.text = "";
    update();
  }

  Future<void> disableGoogleAuthenticate() async{
    dismissKeyboard();
    if (authenticationCode.text.isEmpty){
      CustomSnackBar.error(errorList: [MyStrings.codeIsRequired]);
      return;
    }
    final param = {
      'code': authenticationCode.text.toString(),
    };
    submitLoading = true;
    ResponseModel responseModel = await repo.disableAuthenticate(param);
    if(responseModel.statusCode == 200){
      EnableGoogleAuthenticatorModel model = responseFromJsonEnable(responseModel.responseJson);
      if(model.status.toString().toLowerCase() == "success"){
        isTwoFactorEnabled = "0";
        CustomSnackBar.success(successList: [model.message]);
        getTwoFactor();
      }
      else{
        CustomSnackBar.error(errorList: [model.message]);
      }
    }
    else{
      CustomSnackBar.error(errorList: [responseModel.message]);
    }
    submitLoading = false;
    authenticationCode.text = "";
    update();
  }

  void dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

}