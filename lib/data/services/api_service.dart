import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eastern_trust/core/helper/shared_preference_helper.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/core/utils/method.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_images.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/data/model/authorization/authorization_response_model.dart';
import 'package:eastern_trust/data/model/general_setting/general_settings_response_model.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/views/components/buttons/circle_animated_button_with_text.dart';

import '../../views/components/buttons/dashboard_button_with_text.dart';


class ApiClient extends GetxService{

  SharedPreferences sharedPreferences;
  ApiClient({required this.sharedPreferences});

  Future<ResponseModel> request(
      String uri,
      String method,
      Map<String, dynamic>? params,
      {bool passHeader=false, bool isOnlyAcceptType=false,}) async {

    Uri url=Uri.parse(uri);
    http.Response response;


    try {
      if (method == Method.postMethod) {

        if(passHeader){

          initToken();
          if(isOnlyAcceptType){
            response = await http.post(url, body: params,headers: {
              "Accept": "application/json",
            });
          }
          else{
            response = await http.post(url, body: params,headers: {
              "Accept": "application/json",
              "Authorization": "$tokenType $token"
            });

          }

        }

        else{
          response = await http.post(url, body: params);
        }

      }
      else if (method == Method.postMethod) {

        if(passHeader){

          initToken();
          response = await http.post(
              url,
              body: params,
              headers: {
                "Accept": "application/json",
                "Authorization": "$tokenType $token"
              });

        }
        else{
          response = await http.post(
              url,
              body: params
          );
        }
      }
      else if (method == Method.deleteMethod) {
        response = await http.delete(url);
      } else if (method == Method.updateMethod) {
        response = await http.patch(url);
      } else {

        if(passHeader){
          initToken();
          response = await http.get(
              url,headers: {
            "Accept": "application/json",
            "Authorization": "$tokenType $token"
          });

        }else{
          response = await http.get(url);
        }
      }

      print(response.statusCode);
      print(response.body.toString());
      print(url.toString());
      print(token);
      print(params.toString());


      if (response.statusCode == 200) {
        print(response.body.toString());
        try{
          AuthorizationResponseModel model=AuthorizationResponseModel.fromJson(jsonDecode(response.body));
          if( model.remark == 'profile_incomplete' ){
            Get.toNamed(RouteHelper.profileCompleteScreen);
          }else if( model.remark == 'kyc_verification' ){
            Get.offAndToNamed(RouteHelper.kycScreen);
          }else if( model.remark == 'unauthenticated' ){
            sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
            sharedPreferences.remove(SharedPreferenceHelper.token);
            Get.offAllNamed(RouteHelper.loginScreen);
          }
        }catch(e){
          e.toString();
        }

        return ResponseModel(true, 'Success', 200, response.body);
      }
      else if (response.statusCode == 401) {
        sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
        Get.offAllNamed(RouteHelper.loginScreen);
        return ResponseModel(false, MyStrings.unAuthorized.tr, 401, response.body);
      } else if (response.statusCode == 500) {
        return ResponseModel(false, MyStrings.serverError.tr, 500, response.body);
      } else {
        return ResponseModel(false, MyStrings.somethingWentWrong.tr, 499, response.body);
      }
    } on SocketException {
      return ResponseModel(false, MyStrings.noInternet.tr, 503, '');
    } on FormatException {
      return ResponseModel(false, MyStrings.badResponseMsg.tr, 400, '');
    } catch (e) {
      return ResponseModel(false, MyStrings.somethingWentWrong.tr, 499, '');
    }
  }

  String token='';
  String tokenType='';

  initToken() {
    if (sharedPreferences.containsKey(SharedPreferenceHelper.accessTokenKey)) {
      String? t =
      sharedPreferences.getString(SharedPreferenceHelper.accessTokenKey);
      String? tType =
      sharedPreferences.getString(SharedPreferenceHelper.accessTokenType);
      token = t ?? '';
      tokenType = tType ?? 'Bearer';
    } else {
      token = '';
      tokenType = 'Bearer';
    }
  }

  storeGeneralSetting(GeneralSettingsResponseModel model){
    String json=jsonEncode(model.toJson());
    sharedPreferences.setString(SharedPreferenceHelper.generalSettingKey, json);
    getGSData();
  }

  GeneralSettingsResponseModel getGSData(){
    String pre= sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey)??'';
    if(pre.isNotEmpty && pre!='null'){
      GeneralSettingsResponseModel model=GeneralSettingsResponseModel.fromJson(jsonDecode(pre));
      return model;
    } else{
      GeneralSettingsResponseModel model = GeneralSettingsResponseModel();
      return model;
    }
  }

  String getCurrencyOrUsername({bool isCurrency = true,bool isSymbol = false}){
    if(isCurrency){
      String pre= sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey)??'';
      GeneralSettingsResponseModel model=GeneralSettingsResponseModel.fromJson(jsonDecode(pre));
      String currency = isSymbol? model.data?.generalSetting?.curSym??'': model.data?.generalSetting?.curText??'';
      return currency;
    } else{
      String username = sharedPreferences.getString(SharedPreferenceHelper.userNameKey)??'';
      return username;
    }
  }

  bool getPasswordStrengthStatus(){
    String pre= sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey)??'';
    GeneralSettingsResponseModel model=GeneralSettingsResponseModel.fromJson(jsonDecode(pre));
    bool checkPasswordStrength =  model.data?.generalSetting?.securePassword.toString() == '0' ? false : true;
    return checkPasswordStrength;
  }

  int getOtpTimerTime (){
    String pre= sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey)??'';
    GeneralSettingsResponseModel model=GeneralSettingsResponseModel.fromJson(jsonDecode(pre));
    String timer =  model.data?.generalSetting?.otpTime??'300';
    return int.tryParse(timer)??300;
  }

  List<String> getAuthorizationList (){
    String pre= sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey)??'';
    GeneralSettingsResponseModel model=GeneralSettingsResponseModel.fromJson(jsonDecode(pre));
    List<String>authList = [];
    String selectOne = MyStrings.selectOne;
    authList.insert(0, selectOne);
    bool isEmailEnable =  model.data?.generalSetting?.modules?.otpEmail=='1'?true:false;
    bool isSMSEnable =  model.data?.generalSetting?.modules?.otpSms=='1'?true:false;
    if(isEmailEnable){
      authList.add(MyStrings.email);
    }
    if(isSMSEnable){
      authList.add(MyStrings.sms);
    }
    return authList;
  }


  List<Widget>getModuleList(){

    List<Widget>moduleList = [];

    String pre= sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey)??'';
    GeneralSettingsResponseModel model=GeneralSettingsResponseModel.fromJson(jsonDecode(pre));
    bool isDepositEnable = model.data?.generalSetting?.modules?.deposit=='0'?false:true;
    bool isWithdrawEnable = model.data?.generalSetting?.modules?.withdraw=='0'?false:true;
    bool isFDREnable = model.data?.generalSetting?.modules?.fdr=='0'?false:true;
    bool isDPSEnable = model.data?.generalSetting?.modules?.dps=='0'?false:true;
    bool isLoanEnable = model.data?.generalSetting?.modules?.loan=='0'?false:true;
    bool isAirtimeEnable = model.data?.generalSetting?.modules?.airtime=='0'?false:true;
    bool isReferralEnable = model.data?.generalSetting?.modules?.referralSystem=='0'?false:true;
   // bool isWireTransferEnable = model.data?.generalSetting?.modules?.referralSystem=='0'?false:true;



    if(isDepositEnable){
      moduleList.add(DashboardAnimatedButtonWithText(
        buttonName: MyStrings.deposit,
        height: 40, width: 40,
        backgroundColor: MyColor.homeColorList[0].withOpacity(.0),
        child: SvgPicture.asset(MyImages.depositIcon, height: 35, width: 35),
        onTap: (){
          Get.toNamed(RouteHelper.depositsScreen);
        },
      ));
    }


    if(isFDREnable){
      moduleList.add(CircleAnimatedButtonWithText(
        buttonName: MyStrings.fdr,
        height: 50, width: 50,
        backgroundColor: MyColor.homeColorList[1].withOpacity(.0),
        child: Image.asset(MyImages.fdrIcon, height: 50, width: 50),
        onTap: (){
          Get.toNamed(RouteHelper.fdrScreen);
        },
      ));
    }
    if(isDPSEnable){
      moduleList.add(CircleAnimatedButtonWithText(
        buttonName: MyStrings.dps,
        height: 50, width: 50,
        backgroundColor:  MyColor.homeColorList[2].withOpacity(.0),
        child: Image.asset(MyImages.dpsIcon,  height: 50, width: 50),
        onTap: (){
          Get.toNamed(RouteHelper.dpsScreen);
        },
      ));
    }
    if(isLoanEnable){
      moduleList.add(CircleAnimatedButtonWithText(
        buttonName: MyStrings.loan,
        height: 50, width: 50,
        backgroundColor: MyColor.homeColorList[3].withOpacity(.0),
        child: Image.asset(MyImages.loanIcon1, height: 50, width: 50,fit: BoxFit.cover,),
        onTap: (){
          Get.toNamed(RouteHelper.loanScreen);
        },
      ));
    }
    // if(isWithdrawEnable){
    //   moduleList.add(CircleAnimatedButtonWithText(
    //     buttonName: MyStrings.withdrawal,
    //     height: 40, width: 40,
    //     backgroundColor: MyColor.homeColorList[4].withOpacity(.1),
    //     child: SvgPicture.asset(MyImages.withdrawIcon, color: MyColor.homeColorList[4], height: 20, width: 20),
    //     onTap: (){
    //       Get.toNamed(RouteHelper.withdrawScreen);
    //     },
    //   ));
    // }
    if(isWithdrawEnable){
      moduleList.add(DashboardAnimatedButtonWithText(
        buttonName: MyStrings.withdrawal,
        height: 40, width: 40,
        backgroundColor: MyColor.homeColorList[4].withOpacity(.0),
        child: SvgPicture.asset(MyImages.withdrawIcon, height: 35, width: 35),
        onTap: (){
          Get.toNamed(RouteHelper.withdrawScreen);
        },
      ));
    }

      moduleList.add(CircleAnimatedButtonWithText(
        buttonName: MyStrings.transfer,
        height: 40, width: 40,
        backgroundColor: MyColor.homeColorList[5].withOpacity(.1),
        child: SvgPicture.asset(MyImages.transferIcon2, height: 35, width: 35),
        onTap: (){
          Get.toNamed(RouteHelper.transferScreen);
        },
      ));

      if(isAirtimeEnable){
        moduleList.add(CircleAnimatedButtonWithText(
          buttonName: MyStrings.airTime.tr,
          height: 40, width: 40,
          backgroundColor: MyColor.homeColorList[6].withOpacity(.1),
          child: SvgPicture.asset(MyImages.mobile, color: MyColor.homeColorList[6], height: 20, width: 20),
          onTap: (){
            Get.toNamed(RouteHelper.airtimeScreen);
          },
        ));
      }




    if(isReferralEnable){
      moduleList.add(CircleAnimatedButtonWithText(
        buttonName: MyStrings.referral,
        height: 40, width: 40,
        backgroundColor: MyColor.homeColorList[7].withOpacity(.1),
        child: SvgPicture.asset(MyImages.referralIcon1, color:MyColor.homeColorList[7], height: 20, width: 20),
        onTap: (){
          Get.toNamed(RouteHelper.referralScreen);
        },
      ));
    }

    return moduleList;
  }

  bool isWireTransferEnable(){


    String pre= sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey)??'';
    GeneralSettingsResponseModel model=GeneralSettingsResponseModel.fromJson(jsonDecode(pre));
    bool isWireTransferEnable = model.data?.generalSetting?.modules?.referralSystem=='0'?false:true;

    return isWireTransferEnable;
  }

  String getTemplateName(){
    String pre= sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey)??'';
    GeneralSettingsResponseModel model=GeneralSettingsResponseModel.fromJson(jsonDecode(pre));
    String templateName = model.data?.generalSetting?.activeTemplate??'';
    return templateName;
  }

}
