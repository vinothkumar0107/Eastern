import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/string_format_helper.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/model/withdraw/withdraw_method_response_model.dart';
import 'package:eastern_trust/data/model/withdraw/withdraw_request_response_model.dart';
import 'package:eastern_trust/data/repo/withdraw/withdraw_repo.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';

class AddNewWithdrawController extends GetxController{

  WithdrawRepo repo;
  AddNewWithdrawController({required this.repo});
  bool isLoading = true;
  List<WithdrawMethod>withdrawMethodList=[];
  String currency='';

  TextEditingController amountController=TextEditingController();

  WithdrawMethod? withdrawMethod=WithdrawMethod();
  String withdrawLimit='';
  String charge='';
  String payableText = '';
  String conversionRate = '';
  String inLocal = '';

  List<String>authorizationList = [];
  String? selectedAuthorizationMode ;



  void changeAuthorizationMode(String? value){
    if(value!=null){
      selectedAuthorizationMode = value;
      update();
    }
  }





  double rate = 1;
  double mainAmount = 0;
  setWithdrawMethod(WithdrawMethod?method){

    withdrawMethod = method;
    withdrawLimit   = '${MyStrings.depositLimit.tr}: ${Converter.formatNumber(method?.minLimit??'-1')} - ${Converter.formatNumber(method?.maxLimit?.toString()??'-1')} ${method?.currency}';
    charge         = '${MyStrings.charge.tr}: ${Converter.formatNumber(method?.fixedCharge?.toString()??'0')} + ${Converter.formatNumber(method?.percentCharge?.toString()??'0')} %';
    update();

    String amt = amountController.text.toString();
    mainAmount = amt.isEmpty?0:double.tryParse(amt)??0;
    withdrawMethod = method;
    withdrawLimit   =
    '${Converter.formatNumber(
        method?.minLimit?.toString() ?? '-1')} - ${Converter
        .formatNumber(
        method?.maxLimit?.toString() ?? '-1')} $currency';
    changeInfoWidgetValue(mainAmount);
    update();
  }

  void changeInfoWidgetValue(double amount){

    mainAmount = amount;
    double percent = double.tryParse(withdrawMethod?.percentCharge??'0')??0;
    double percentCharge = (amount*percent)/100;
    double temCharge = double.tryParse(withdrawMethod?.fixedCharge??'0')??0;
    double totalCharge = percentCharge+temCharge;
    charge = '${Converter.formatNumber('$totalCharge')} $currency';
    double payable = amount - totalCharge;
    payableText = '$payable $currency';

    rate = double.tryParse(withdrawMethod?.rate??'0')??0;
    conversionRate = '1 $currency = $rate ${withdrawMethod?.currency??''}';
    inLocal = Converter.formatNumber('${payable*rate}');
    update();
    return;
  }


  Future<void>loadDepositMethod()async{

    authorizationList = repo.apiClient.getAuthorizationList();
    changeAuthorizationMode(authorizationList[0]);

    currency = repo.apiClient.getCurrencyOrUsername();
    clearPreviousValue();
    WithdrawMethod method1 = WithdrawMethod(id: -1,name:MyStrings.selectOne,currency:"",minLimit:"0",maxLimit:"0",percentCharge:"",fixedCharge:"",rate:"");
    withdrawMethodList.insert(0, method1);
    setWithdrawMethod(withdrawMethodList[0]);

    isLoading = true;
    update();

    ResponseModel responseModel = await repo.getAllWithdrawMethod();

    if(responseModel.statusCode==200){

      WithdrawMethodResponseModel model=WithdrawMethodResponseModel.fromJson(jsonDecode(responseModel.responseJson));

      if(model.status ==  'success'){
        List<WithdrawMethod>?tempMethodList = model.data?.withdrawMethod;
        if(tempMethodList != null && tempMethodList.isNotEmpty){
          withdrawMethodList.addAll(tempMethodList);
        }
      }else{
        CustomSnackBar.error(errorList: model.message?.error??[MyStrings.somethingWentWrong],);
      }
    }else{
      CustomSnackBar.error(errorList:[responseModel.message]);
    }
    isLoading = false;
    update();

    }

    bool submitLoading = false;
    Future<void>submitWithdrawRequest()async{
      String amount=amountController.text;
      String id =withdrawMethod?.id.toString()??'-1';



      if(amount.isEmpty){
        CustomSnackBar.error(errorList: ['${MyStrings.please} ${MyStrings.enterAmount.toLowerCase()}']);
        return;
      }

      if(id == '-1'){
        CustomSnackBar.error(errorList: ['${MyStrings.please} ${MyStrings.selectAWallet.toLowerCase()}']);
        return;
      }

      if(authorizationList.length>1 && selectedAuthorizationMode?.toLowerCase()==MyStrings.selectOne){
        CustomSnackBar.error(errorList: [MyStrings.selectAuthModeMsg]);
        return;
      }

      double amount1 = 0;
      double maxAmount = 0;
      try{
        amount1=double.parse(amount);
        maxAmount=double.parse(withdrawMethod?.maxLimit??'0');
      }catch(e){
        return;
      }
      if(maxAmount==0||amount1==0){
        List<String>errorList=[MyStrings.invalidAmount];
        CustomSnackBar.error(errorList: errorList);
        return;
      }
      submitLoading = true;
      update();
      ResponseModel response = await repo.addWithdrawRequest(withdrawMethod?.id ?? -1, amount1,selectedAuthorizationMode);

      if(response.statusCode==200){
        WithdrawRequestResponseModel model= WithdrawRequestResponseModel.fromJson(jsonDecode(response.responseJson));
        String otpId = model.data?.otpId??'';
        if(model.status?.toLowerCase() ==  MyStrings.success.toLowerCase()){
          if(otpId.isNotEmpty&&authorizationList.length>1){
            Get.toNamed(RouteHelper.otpScreen,arguments:[ RouteHelper.withdrawConfirmScreenScreen,model.data?.otpId,selectedAuthorizationMode?.toLowerCase().toString()]);
          } else{
            String trxId = model.data?.trxId??'';
            Get.toNamed(RouteHelper.withdrawConfirmScreenScreen,arguments: trxId);
          }

        }else{
         CustomSnackBar.error(errorList: model.message?.error??[MyStrings.requestFail]);
        }
      }else{
        CustomSnackBar.error(errorList: [response.message]);
      }
      submitLoading = false;
      update();
    }

  bool isShowRate() {
    if(rate>=1.0 && currency.toLowerCase()!= withdrawMethod?.currency?.toLowerCase()){
      return true;
    }else{
      return false;
    }
  }

  void clearPreviousValue(){
    withdrawMethodList.clear();
    amountController.text = '';
    rate = 1;
    submitLoading = false;
    withdrawMethod = WithdrawMethod();
  }

}