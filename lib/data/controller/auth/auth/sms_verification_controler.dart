import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/data/model/authorization/authorization_response_model.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/repo/auth/sms_email_verification_repo.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';

class SmsVerificationController extends GetxController {

  SmsEmailVerificationRepo repo;
  SmsVerificationController({required this.repo});

  bool hasError = false;
  bool isLoading = true;
  String currentText='';
  bool isProfileCompleteEnable=false;
  bool isTwoFactorEnable = false;


  Future<void> loadBefore() async {
    isLoading=true;
    update();
    await repo.sendAuthorizationRequest();
    isLoading=false;
    update();
    return;
  }


  bool submitLoading=false;
  verifyYourSms(String currentText) async {

    if (currentText.isEmpty) {
      CustomSnackBar.error(
          errorList: [MyStrings.otpFieldEmptyMsg.tr],);
      return;
    }

    submitLoading = true;
    update();

    ResponseModel responseModel =
    await repo.verify(currentText, isEmail: false, isTFA: false);

    if (responseModel.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(
          jsonDecode(responseModel.responseJson));

      if (model.status == MyStrings.success) {

        if(isTwoFactorEnable){
          Get.offAndToNamed(RouteHelper.twoFactorVerificationScreen,arguments:isProfileCompleteEnable );
        } else{
          Get.offAndToNamed(RouteHelper.homeScreen);
        }
        CustomSnackBar.success(successList:model.message?.success??['${MyStrings.sms.tr} ${MyStrings.verificationSuccess.tr}'] ,);
      } else {
        CustomSnackBar.error(errorList: model.message?.error??['${MyStrings.sms.tr} ${MyStrings.verificationFailed}']);
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }

    submitLoading = false;
    update();

  }

  bool resendLoading=false;
  Future<void> sendCodeAgain() async {
    resendLoading=true;
    update();
    await repo.resendVerifyCode(isEmail: false);
    resendLoading=false;
    update();
  }



}