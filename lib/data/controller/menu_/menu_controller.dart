import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/shared_preference_helper.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/data/model/authorization/authorization_response_model.dart';
import 'package:eastern_trust/data/model/general_setting/general_settings_response_model.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/repo/auth/general_setting_repo.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';

class MenuController extends GetxController  {

  GeneralSettingRepo repo;
  bool isLoading = true;
  bool noInternet = false;

  bool balTransferEnable = true;
  bool langSwitchEnable = true;
  bool isDepositEnable = true;
  bool isReferralEnable = true;
  bool isWithdrawEnable = true;

  MenuController({required this.repo});

  void loadData()async{
    GeneralSettingsResponseModel model = repo.apiClient.getGSData();
    isDepositEnable = model.data?.generalSetting?.modules?.deposit=='0'?false:true;
    isWithdrawEnable = model.data?.generalSetting?.modules?.withdraw=='0'?false:true;
    isReferralEnable = model.data?.generalSetting?.modules?.referralSystem=='0'?false:true;
    isLoading = true;
    update();
    await configureMenuItem();
    isLoading = false;
    update();
  }

  configureMenuItem()async{

    ResponseModel response = await repo.getGeneralSetting();

    if(response.statusCode==200){
      GeneralSettingsResponseModel model =
      GeneralSettingsResponseModel.fromJson(jsonDecode(response.responseJson));
      if (model.status?.toLowerCase()==MyStrings.success.toLowerCase()) {
        bool langStatus = true;
        langSwitchEnable = langStatus;
        repo.apiClient.storeGeneralSetting(model);
        update();
      }
      else {
        List<String>message=[MyStrings.somethingWentWrong];
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
  }

  bool logoutLoading = false;
  Future<void>logout()async{
    List<String>msg = [];
    logoutLoading = true;
    update();
    try{
      ResponseModel response = await repo.logout();
      if(response.statusCode == 200){
        AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(response.responseJson));
        if(model.status?.toLowerCase() == MyStrings.success.toLowerCase() || model.status?.toLowerCase() == 'ok'){
          msg.addAll(model.message?.success??[MyStrings.logoutSuccessMsg]);
        } else{
          msg.add(MyStrings.logoutSuccessMsg);
        }
      }
      else{
        msg.add(MyStrings.logoutSuccessMsg);
      }
    } catch(e){
      if(kDebugMode){
        print(e.toString());
      }
    }

    logoutLoading = false;
    update();
    repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.accessTokenKey, '');
    repo.apiClient.sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
    Get.offAllNamed(RouteHelper.loginScreen);
    CustomSnackBar.success(successList: msg);
  }

  bool deleteLoading = false;
  Future<void>deleteAccount()async{
    List<String>msg = [];
    deleteLoading = true;
    update();
    try{
      ResponseModel response = await repo.deleteAccount();
      if(response.statusCode == 200){
        AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(response.responseJson));
        if(model.status?.toLowerCase() == MyStrings.success.toLowerCase() || model.status?.toLowerCase() == 'ok'){
          msg.addAll(model.message?.success??[MyStrings.deleteSuccessMsg]);
        } else{
          msg.add(MyStrings.deleteSuccessMsg);
        }
      } else{
        msg.add(MyStrings.deleteSuccessMsg);
      }
    } catch(e){
      if(kDebugMode){
        print(e.toString());
      }
    }

    deleteLoading = false;
    update();
    repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.accessTokenKey, '');
    repo.apiClient.sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
    Get.offAllNamed(RouteHelper.loginScreen);
    CustomSnackBar.success(successList: msg);
  }

}