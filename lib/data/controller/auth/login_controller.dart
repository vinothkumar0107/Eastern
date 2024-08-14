import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/shared_preference_helper.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/data/model/auth/login_response_model.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/repo/auth/login_repo.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';

class LoginController extends GetxController{


  LoginRepo loginRepo;

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<String>errors=[];
  String? email;
  String? password;
  bool remember = false;

  LoginController({required this.loginRepo});


  void forgetPassword() {
    Get.toNamed(RouteHelper.forgetPasswordScreen);
  }



  void checkAndGotoNextStep(LoginResponseModel responseModel) async{

    bool needEmailVerification=responseModel.data?.user?.ev == "1" ? false:true;
    bool needSmsVerification=responseModel.data?.user?.sv == '1' ? false:true;
    bool isTwoFactorEnable = responseModel.data?.user?.tv == '1' ? false:true;

    if(remember){
      await loginRepo.apiClient.sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, true);
    }else{
      await loginRepo.apiClient.sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey,false);
    }

    await loginRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userIdKey, responseModel.data?.user?.id.toString()??'-1');
    await loginRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.accessTokenKey, responseModel.data?.accessToken??'');
    await loginRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.accessTokenType, responseModel.data?.tokenType??'');
    await loginRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userEmailKey, responseModel.data?.user?.email??'');
    await loginRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userPhoneNumberKey, responseModel.data?.user?.mobile??'');
    await loginRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userNameKey, responseModel.data?.user?.username??'');

    await loginRepo.sendUserToken();

    bool isProfileCompleteEnable = responseModel.data?.user?.regStep == '0'?true:false;

    if( needSmsVerification == false && needEmailVerification == false && isTwoFactorEnable == false) {
      if(isProfileCompleteEnable){
        // Get.offAndToNamed(RouteHelper.profileCompleteScreen);
        Get.toNamed(RouteHelper.profileCompleteScreen);
      }else{
        Get.offAndToNamed(RouteHelper.homeScreen);
      }
    }else if(needSmsVerification==true&&needEmailVerification==true && isTwoFactorEnable == true){
      Get.offAndToNamed(RouteHelper.emailVerificationScreen,arguments: [true,isProfileCompleteEnable,isTwoFactorEnable]);
    }
    else if(needSmsVerification==true&&needEmailVerification==true){
      Get.offAndToNamed(RouteHelper.emailVerificationScreen,arguments: [true,isProfileCompleteEnable,isTwoFactorEnable]);
    }else if(needSmsVerification){
      Get.offAndToNamed(RouteHelper.smsVerificationScreen,arguments: [isProfileCompleteEnable,isTwoFactorEnable]);
    }else if(needEmailVerification){
      Get.offAndToNamed(RouteHelper.emailVerificationScreen,arguments: [false,isProfileCompleteEnable,isTwoFactorEnable]);
    } else if(isTwoFactorEnable){
      Get.offAndToNamed(RouteHelper.twoFactorVerificationScreen,arguments: isProfileCompleteEnable);
    }

    if(remember){
      changeRememberMe();
    }

  }

  bool isSubmitLoading = false;
  void loginUser() async {

    isSubmitLoading = true;
    update();

    ResponseModel model= await loginRepo.loginUser(emailController.text.toString(), passwordController.text.toString());

    if(model.statusCode==200){
      LoginResponseModel loginModel = LoginResponseModel.fromJson(jsonDecode(model.responseJson));
      if(loginModel.status.toString().toLowerCase() == MyStrings.success.toLowerCase()){
        isSubmitLoading = false;
        update();
        checkAndGotoNextStep(loginModel);
        return;
      }else{
        CustomSnackBar.error(errorList: loginModel.message?.error??[MyStrings.loginFailedTryAgain],);
      }
    }
    else{
      CustomSnackBar.error(errorList: [model.message],);
    }
    isSubmitLoading = false;
    update();
  }

  changeRememberMe() {
    remember = !remember;
    update();
  }

  void clearAllSharedPreData(){
    loginRepo.apiClient.sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
    loginRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.accessTokenKey, '');
    return;
  }

  void clearData() {
    remember = false;
    isSubmitLoading = false;
    emailController.text = '';
    passwordController.text = '';
  }

}
