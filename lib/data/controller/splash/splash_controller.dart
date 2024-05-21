import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/shared_preference_helper.dart';
import 'package:eastern_trust/core/utils/messages.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/data/controller/localization/localization_controller.dart';
import 'package:eastern_trust/data/model/general_setting/general_settings_response_model.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/repo/auth/general_setting_repo.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';

class SplashController extends GetxController  {

  GeneralSettingRepo repo;
  LocalizationController localizationController;
  bool isLoading = true;

  SplashController({required this.repo,required this.localizationController});

  gotoNextPage() async {
    await loadLanguage();
    bool isRemember = repo.apiClient.sharedPreferences.getBool(SharedPreferenceHelper.rememberMeKey) ?? false;
    noInternet=false;
    update();
    initSharedData();

    try{ //redirect specific push screen
      RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null && initialMessage.data.isNotEmpty) {
        Map<dynamic, dynamic> payloadMap = initialMessage.data;
        Map<String, String> payload = payloadMap.map((key, value) => MapEntry(key.toString(), value.toString()));
        String? remark = payload['for_app'];
        if(remark!=null && remark.isNotEmpty){
          checkAndRedirect(remark);
        } else{
          getGSData(isRemember);
        }
      }else{
        getGSData(isRemember);
      }

    }catch(e){
      getGSData(isRemember);
    }


  }

  bool noInternet=false;
  void getGSData(bool isRemember)async{
    ResponseModel response = await repo.getGeneralSetting();
    bool requestSuccess = false;
    if(response.statusCode==200){
      GeneralSettingsResponseModel model =
      GeneralSettingsResponseModel.fromJson(jsonDecode(response.responseJson));
      if (model.status?.toLowerCase()==MyStrings.success.toLowerCase()) {
        repo.apiClient.storeGeneralSetting(model);
        requestSuccess = true;
      }
      else {
        List<String>message=[MyStrings.somethingWentWrong];
        CustomSnackBar.error(errorList:model.message?.error??message);
        requestSuccess = false;
      }
    }else{
      requestSuccess = false;
      CustomSnackBar.error(errorList:[response.message]);
    }

    if (isRemember && requestSuccess) {
      await Future.delayed(const Duration(seconds: 1), () {
        Get.offAndToNamed(RouteHelper.homeScreen);
      });
      return;
    } else{
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAndToNamed(RouteHelper.loginScreen);
      });
    }
    isLoading = false;
    update();
  }


  Future<bool> initSharedData() {
    if(!repo.apiClient.sharedPreferences.containsKey(SharedPreferenceHelper.countryCode)) {
      return repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.countryCode, MyStrings.languages[0].countryCode);
    }
    if(!repo.apiClient.sharedPreferences.containsKey(SharedPreferenceHelper.languageCode)) {
      return repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.languageCode, MyStrings.languages[0].languageCode);
    }

    return Future.value(true);
  }

  Future<void>loadLanguage()async{
    localizationController.loadCurrentLanguage();
    String languageCode = localizationController.locale.languageCode;
   /* try{*/
    ResponseModel response = await repo.getLanguage(languageCode);
    if(response.statusCode == 200){
        Map<String,Map<String,String>> language = {};
        var resJson = jsonDecode(response.responseJson);
        saveLanguageList(response.responseJson);
        var value = resJson['data']['language_data'] as Map<String,dynamic>;
        Map<String,String> json = {};
        value.forEach((key, value) {
          json[key] = value.toString();
        });
        language['${localizationController.locale.languageCode}_${localizationController.locale.countryCode}'] = json;
        Get.addTranslations(Messages(languages: language).keys);
    } else{
      if (kDebugMode) {
        print(response.message);
      }
    }
  /* }catch(e){
      if (kDebugMode) {
        print(e.toString());
      }
    }*/
  }

  void saveLanguageList(String languageJson)async{
    print(languageJson.toString());
    await repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.languageListKey, languageJson);
    return;
  }

  checkAndRedirect(String remark) async{
    repo.apiClient.sharedPreferences.setBool(SharedPreferenceHelper.hasNewNotificationKey,true);
    bool rememberMe =  repo.apiClient.sharedPreferences.getBool(SharedPreferenceHelper.rememberMeKey)??false;


    if(rememberMe){

      List<String>trxHistoryRemark = ['BAL_ADD','BAL_SUB','REFERRAL-COMMISSION','BALANCE_TRANSFER','BALANCE_RECEIVE'];
      List<String>withdrawRemark = ['WITHDRAW_APPROVE','WITHDRAW_REJECT','WITHDRAW_REJECT','WITHDRAW_REQUEST'];
      List<String>transferHistoryRemark = ["TRANSFER",'OTHER_BANK_TRANSFER_COMPLETE','WIRE_TRANSFER_COMPLETED','OWN_BANK_TRANSFER_MONEY_SEND','OWN_BANK_TRANSFER_MONEY_RECEIVE','OTHER_BANK_TRANSFER_REQUEST_SEND'];
      List<String>depositHistoryRemark = ['DEPOSIT_APPROVE','DEPOSIT_COMPLETE','DEPOSIT_REJECT','DEPOSIT_REQUEST'];
      List<String>loanHistoryRemark = ['LOAN_APPROVE','LOAN_REJECT','LOAN_PAID','LOAN_INSTALLMENT_DUE'];
      List<String>dpsHistoryRemark = ['DPS_OPENED','DPS_MATURED','DPS_CLOSED','DPS_INSTALLMENT_DUE'];
      List<String>fdrHistoryRemark = ['FDR_OPENED','FDR_CLOSED'];
      //List<String>homeRemark = ['KYC_REJECT','FDR_APPROVE'];

      if(trxHistoryRemark.contains(remark)){
        Get.offAndToNamed(RouteHelper.transactionScreen);
      }else if(withdrawRemark.contains(remark)){
        Get.offAndToNamed(RouteHelper.withdrawScreen);
      }else if(depositHistoryRemark.contains(remark)){
        Get.offAndToNamed(RouteHelper.depositsScreen);
      }else if(transferHistoryRemark.contains(remark)){
        Get.offAndToNamed(RouteHelper.transferHistoryScreen);
      }else if(loanHistoryRemark.contains(remark)){
        Get.offAndToNamed(RouteHelper.loanScreen,arguments: 'list');
      }else if(dpsHistoryRemark.contains(remark)){
        Get.offAndToNamed(RouteHelper.dpsScreen,arguments: 'list');
      }else if(fdrHistoryRemark.contains(remark)){
        Get.offAndToNamed(RouteHelper.fdrScreen,arguments: 'list');
      } else{
        Get.offAndToNamed(RouteHelper.homeScreen);
      }
    }else{
      Get.offAndToNamed(RouteHelper.loginScreen);
    }
  }



}
