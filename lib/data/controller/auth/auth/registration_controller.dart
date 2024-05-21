import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/shared_preference_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/data/model/auth/error_model.dart';
import 'package:eastern_trust/data/model/auth/registration_response_model.dart';
import 'package:eastern_trust/data/model/auth/sign_up_model/sign_up_model.dart';
import 'package:eastern_trust/data/model/country_model/country_model.dart';
import 'package:eastern_trust/data/model/general_setting/general_settings_response_model.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/repo/auth/general_setting_repo.dart';
import 'package:eastern_trust/data/repo/auth/signup_repo.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';

class RegistrationController extends GetxController {
  RegistrationRepo registrationRepo;
  GeneralSettingRepo generalSettingRepo;

  RegistrationController({required this.registrationRepo, required this.generalSettingRepo});

  bool isLoading = true;
  bool agreeTC = false;

  GeneralSettingsResponseModel generalSettingMainModel =
  GeneralSettingsResponseModel();

  //it will come from general setting api
  bool checkPasswordStrength = false;
  bool needAgree=true;

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();
  final FocusNode firstNameFocusNode = FocusNode();
  final FocusNode lastNameFocusNode = FocusNode();
  final FocusNode countryNameFocusNode = FocusNode();
  final FocusNode mobileFocusNode = FocusNode();
  final FocusNode userNameFocusNode = FocusNode();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();


  String? email;
  String? password;
  String? confirmPassword;
  String? countryName;
  String? countryCode;
  String? mobileCode;
  String? userName;
  String? phoneNo;
  String? firstName;
  String? lastName;

  RegExp regex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

  bool submitLoading=false;
  signUpUser() async {

    if (countryName == null) {
      CustomSnackBar.error(errorList: [MyStrings.selectACountry],);
      update();
      return;
    }

    if(mobileController.text.isEmpty) {
      CustomSnackBar.error(errorList: [MyStrings.enterYourPhoneNumber],);
      return;
    }

    if(needAgree && !agreeTC) {
      CustomSnackBar.error(errorList: [MyStrings.agreePolicyMessage],);
      return;
    }

    submitLoading=true;
    update();

    SignUpModel model = getUserData();
    final response = await registrationRepo.registerUser(model);
    if(response.statusCode==200){
      RegistrationResponseModel responseModel = RegistrationResponseModel.fromJson(jsonDecode(response.responseJson));
      if (responseModel.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        CustomSnackBar.success(successList:responseModel.message?.success ??[MyStrings.success.tr]);
        checkAndGotoNextStep(responseModel);
      } else {
        CustomSnackBar.error(errorList:responseModel.message?.error ?? [MyStrings.somethingWentWrong.tr]);
      }
    } else{
      CustomSnackBar.error(errorList: [response.message]);
    }
    submitLoading=false;
    update();
  }



  setCountryNameAndCode(String cName, String countryCode, String mobileCode) {
    countryName = cName;
    this.countryCode = countryCode;
    this.mobileCode = '+$mobileCode';
    update();
  }


  updateAgreeTC() {
    agreeTC = !agreeTC;
    update();
  }

  SignUpModel getUserData() {
    SignUpModel model = SignUpModel(
        mobile: mobileController.text.toString(),
        email: emailController.text.toString(),
        agree: agreeTC ? true : false,
        username: userNameController.text.toString(),
        password: passwordController.text.toString(),
        country: countryName.toString(),
        mobileCode: mobileCode != null ? mobileCode!.replaceAll("[+]", "") : "",
        countryCode: countryCode??'',
       );

    return model;
  }


  void checkAndGotoNextStep(RegistrationResponseModel responseModel) async {
    bool needEmailVerification = responseModel.data?.user?.ev == "1" ? false : true;
    bool needSmsVerification = responseModel.data?.user?.sv == "1" ? false : true;

    SharedPreferences preferences=registrationRepo.apiClient.sharedPreferences;

    await preferences.setString(SharedPreferenceHelper.userIdKey, responseModel.data?.user?.id.toString()??'-1');
    await preferences.setString(SharedPreferenceHelper.accessTokenKey, responseModel.data?.accessToken ?? '');
    await preferences.setString(SharedPreferenceHelper.accessTokenType, responseModel.data?.tokenType ?? '');
    await preferences.setString(SharedPreferenceHelper.userEmailKey, responseModel.data?.user?.email ?? '');
    await preferences.setString(SharedPreferenceHelper.userNameKey, responseModel.data?.user?.username ?? '');
    await preferences.setString(SharedPreferenceHelper.userPhoneNumberKey, responseModel.data?.user?.mobile ?? '');

    await registrationRepo.sendUserToken();

    bool isProfileCompleteEnable = true;
    bool isTwoFactorEnable =  false;

    if(needEmailVerification == false && needSmsVerification == false){
      Get.offAndToNamed(RouteHelper.profileCompleteScreen);
    }
    else if(needEmailVerification == true && needSmsVerification == true){
      Get.offAndToNamed(RouteHelper.emailVerificationScreen, arguments: [true,isProfileCompleteEnable,isTwoFactorEnable]);
    }
    else if(needEmailVerification){
      Get.offAndToNamed(RouteHelper.emailVerificationScreen, arguments: [false, isProfileCompleteEnable, isTwoFactorEnable]);
    }
    else if(needSmsVerification){
      Get.offAndToNamed(RouteHelper.smsVerificationScreen,arguments: [isProfileCompleteEnable,isTwoFactorEnable]);
    }

  }

  void closeAllController() {
    isLoading = false;
    emailController.text      = '';
    passwordController.text   = '';
    cPasswordController.text  = '';
    fNameController.text      = '';
    lNameController.text      = '';
    mobileController.text     = '';
    countryController.text    = '';
    userNameController.text   = '';
  }

  clearAllData() {
    closeAllController();
  }

  bool isCountryLoading=true;

  void initData() async {

    isLoading = true;
    update();
    await getCountryData();

    ResponseModel response = await generalSettingRepo.getGeneralSetting();
    if(response.statusCode==200){
      GeneralSettingsResponseModel model =
      GeneralSettingsResponseModel.fromJson(jsonDecode(response.responseJson));
      if (model.status?.toLowerCase()=='success') {
        generalSettingMainModel =model;
        registrationRepo.apiClient.storeGeneralSetting(model);
      } else {
        List<String>message=[MyStrings.somethingWentWrong.tr];
        CustomSnackBar.error(errorList:model.message?.error??message);
        return;
      }
    }else{
      if(response.statusCode==503){
        noInternet=true;
        update();
      }
      CustomSnackBar.error(errorList:[response.message]);
      return;
    }

    needAgree = generalSettingMainModel.data?.generalSetting?.agree.toString() == '0' ? false : true;
    checkPasswordStrength = generalSettingMainModel.data?.generalSetting?.securePassword.toString() == '0' ? false : true;

    isLoading = false;
    update();
  }

  // country data
  bool countryLoading = true;
  List<Countries> countryList = [];

  Future<dynamic> getCountryData() async {

    ResponseModel mainResponse = await registrationRepo.getCountryList();

    if (mainResponse.statusCode == 200) {
      CountryModel model =
      CountryModel.fromJson(jsonDecode(mainResponse.responseJson));
      List<Countries>? tempList = model.data?.countries;

      if (tempList != null && tempList.isNotEmpty) {
        countryList.addAll(tempList);
      }
      countryLoading = false;
      update();
      return;
    } else {
      CustomSnackBar.error(errorList: [mainResponse.message],);

      countryLoading = false;
      update();
      return;
    }
  }

  String? validatPassword(String value) {
    if (value.isEmpty) {
      return MyStrings.enterYourPassword_.tr;
    } else {
      if(checkPasswordStrength){
        if (!regex.hasMatch(value)) {
          return MyStrings.invalidPassMsg.tr;
        } else {
          return null;
        }
      }else{
        return null;
      }
    }
  }

  bool noInternet=false;
  void changeInternet(bool hasInternet){
    noInternet = false;
    initData();
    update();
  }


  List<ErrorModel> passwordValidationRulse = [
    ErrorModel(text: MyStrings.hasUpperLetter.tr, hasError: true),
    ErrorModel(text: MyStrings.hasLowerLetter.tr, hasError: true),
    ErrorModel(text: MyStrings.hasDigit.tr, hasError: true),
    ErrorModel(text: MyStrings.hasSpecialChar.tr, hasError: true),
    ErrorModel(text: MyStrings.minSixChar.tr, hasError: true),
  ];

  void updateValidationList(String value){
    passwordValidationRulse[0].hasError = value.contains(RegExp(r'[A-Z]'))?false:true;
    passwordValidationRulse[1].hasError = value.contains(RegExp(r'[a-z]'))?false:true;
    passwordValidationRulse[2].hasError = value.contains(RegExp(r'[0-9]'))?false:true;
    passwordValidationRulse[3].hasError = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))?false:true;
    passwordValidationRulse[4].hasError = value.length>=6?false:true;

    update();
  }

  bool hasPasswordFocus = false;
  void changePasswordFocus(bool hasFocus) {
    hasPasswordFocus = hasFocus;
    update();
  }

  bool hasMobileFocus = false;
  void changeMobileFocus(bool hasFocus) {
    hasMobileFocus = hasFocus;
    update();
  }


  void setMobileFocus() {
    try{
      FocusScope.of(Get.context!).requestFocus(mobileFocusNode);
    }catch(e){print(e.toString());}

    update();
  }

}
