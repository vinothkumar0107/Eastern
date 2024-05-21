import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/data/model/authorization/authorization_response_model.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/repo/auth/sms_email_verification_repo.dart';
import 'package:eastern_trust/data/repo/otp/otp_repo.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';

class OtpController extends GetxController {


  OtpRepo repo;
  OtpController({required this.repo}){
    time = repo.apiClient.getOtpTimerTime();
  }


  String currentText = "";
  bool needSmsVerification = false;
  bool isProfileCompleteEnable = false;
  String otpId = '';
  String otpType = '';
  String nextPageUrl = '';


  bool needTwoFactor = false;
  bool submitLoading = false;
  bool isLoading = false;
  bool resendLoading = false;

  bool isOtpExpired = false;
  int time = 300;
  void makeOtpExpired(bool status){
    isOtpExpired = status;
    if(status==false){
      time = repo.apiClient.getOtpTimerTime();
    } else{
      time = 0;
    }
    update();
  }



  Future<void> submitOtp(String code) async {

    if (code.isEmpty) {
      CustomSnackBar.error(errorList: [MyStrings.otpFieldEmptyMsg],);
      return;
    }

    submitLoading=true;
    update();

    ResponseModel responseModel = await repo.submitOtp(code,otpId);

    if (responseModel.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModel.responseJson));

      if (model.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
        String trx = model.data?.trx??'';
         if(nextPageUrl.isEmpty){
           Get.back(result: '');
         } else {
           if(nextPageUrl==RouteHelper.withdrawConfirmScreenScreen){
             Get.offAndToNamed(nextPageUrl,arguments:trx);
           } else{
             Get.offAndToNamed(nextPageUrl,arguments:otpId);
           }
         }
      } else {
         CustomSnackBar.error(errorList: model.message?.error??[(MyStrings.requestFail)] ,);
        }
    }
    else {
        CustomSnackBar.error(errorList: [responseModel.message] ,);
    }

    submitLoading=false;
    update();

  }



  Future<void> sendCodeAgain() async {
    resendLoading = true;
    update();
    ResponseModel response = await repo.resendOtp(otpId);
    if(response.statusCode==200){
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(response.responseJson));
      if(model.status?.toLowerCase()==MyStrings.success.toLowerCase()){
        CustomSnackBar.success(successList: model.message?.success??[MyStrings.requestSuccess]);
        makeOtpExpired(false);
      } else{
        CustomSnackBar.error(errorList: model.message?.error??[MyStrings.requestFail]);
      }
    } else {
      CustomSnackBar.error(errorList: [response.message]);
    }
    resendLoading = false;
    update();
  }

  void initData(String otpType, String otpId,String nextPageUrl) {
    this.otpType = otpType;
    this.otpId = otpId;
    this.nextPageUrl = nextPageUrl;
    update();
  }




}
