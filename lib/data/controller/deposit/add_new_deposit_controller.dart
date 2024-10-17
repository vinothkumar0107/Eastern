import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/string_format_helper.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/data/model/authorized/deposit/deposit_insert_method.dart';
import 'package:eastern_trust/data/model/authorized/deposit/deposit_insert_response_model.dart';
import 'package:eastern_trust/data/model/authorized/deposit/deposit_method_response_model.dart';
import 'package:eastern_trust/data/model/general_setting/general_settings_response_model.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';

import '../../repo/deposit/deposit_repo.dart';

class AddNewDepositController extends GetxController{

  DepositRepo depositRepo;

  AddNewDepositController({required this.depositRepo});

  bool isLoading = true;

  List<Methods> methodList = [];

  String selectedValue = "";

  String depositLimit = "";
  String charge = "";
  String payable = "";
  String amount = "";
  String fixedCharge = "";
  String currency = '';
  String payableText = '';
  String conversionRate = '';
  String inLocal = '';
  Methods? paymentMethod =  Methods(name: MyStrings.selectOne,id: -1);


  TextEditingController amountController = TextEditingController();

  double rate = 1;
  double mainAmount = 0;
  setPaymentMethod(Methods? method) {
    String amt = amountController.text.toString();
    mainAmount = amt.isEmpty?0:double.tryParse(amt)??0;
    paymentMethod = method;
    depositLimit =
    '${Converter.formatNumber(
        method?.minAmount?.toString() ?? '-1')} - ${Converter
        .formatNumber(
        method?.maxAmount?.toString() ?? '-1')} $currency';
    changeInfoWidgetValue(mainAmount);
    update();
  }

  Future<void> getDepositMethod() async {
    currency = depositRepo.apiClient.getCurrencyOrUsername();
    methodList.clear();
    methodList.add(paymentMethod!);
    ResponseModel responseModel = await depositRepo.getDepositMethods();
    if (responseModel.statusCode == 200) {
      DepositMethodResponseModel methodsModel =
      DepositMethodResponseModel.fromJson(jsonDecode(responseModel.responseJson));

      if (methodsModel.message != null &&
          methodsModel.message!.success != null) {
        List<Methods>? tempList = methodsModel.data?.methods;
        if (tempList != null && tempList.isNotEmpty) {
          methodList.addAll(tempList);
        }
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
      return;
    }
    isLoading = false;
    update();
  }

  bool submitLoading = false;
  Future<void> submitDeposit() async {

    if(paymentMethod?.id.toString()=='-1'){
      CustomSnackBar.error(errorList: [MyStrings.selectPaymentMethod]);
      return;
    }

    String amount = amountController.text.toString();
    if (amount.isEmpty) {
      CustomSnackBar.error(errorList: [MyStrings.enterAmount]);
      return;
    }

    submitLoading = true;
    update();

    ResponseModel responseModel = await depositRepo.insertDeposit(
        amount: amount,
        methodCode: paymentMethod?.methodCode ?? "",
        currency: paymentMethod?.currency ?? "");

    if (responseModel.statusCode == 200) {
      DepositInsertResponseModel insertResponseModel =
      DepositInsertResponseModel.fromJson(
          jsonDecode(responseModel.responseJson));
      if (insertResponseModel.status.toString().toLowerCase() == "success") {
        showWebView(insertResponseModel.data?.redirectUrl ?? "", insertResponseModel);
      } else {
        CustomSnackBar.error(errorList: insertResponseModel.message?.error ?? [MyStrings.somethingWentWrong]);
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message],);
    }

    submitLoading = false;
    update();

  }



  void changeInfoWidgetValue(double amount){
    if(paymentMethod?.id.toString() == '-1'){
      return;
    }
    mainAmount = amount;
    double percent = double.tryParse(paymentMethod?.percentCharge??'0')??0;
    double percentCharge = (amount*percent)/100;
    double temCharge = double.tryParse(paymentMethod?.fixedCharge??'0')??0;
    double totalCharge = percentCharge+temCharge;
    charge = '${Converter.formatNumber('$totalCharge')} $currency';
    double payable = totalCharge + amount;
    payableText = '$payable $currency';

    rate = double.tryParse(paymentMethod?.rate??'0')??0;
    conversionRate = '1 $currency = $rate ${paymentMethod?.currency??''}';
    inLocal = Converter.formatNumber('${payable*rate}');
    update();
    return;
  }

  void clearData() {
    depositLimit = '';
    charge = '';
    methodList.clear();
    amountController.text = '';
    isLoading = false;
  }

  bool isShowRate() {
    if(rate>=1.0 && currency.toLowerCase() != paymentMethod?.currency?.toLowerCase()){
      return true;
    }else{
      return false;
    }
  }

  void showWebView(String redirectUrl, DepositInsertResponseModel model) {
    // Get.offAndToNamed(RouteHelper.depositWebViewScreen, arguments: redirectUrl);
    Get.offAndToNamed(RouteHelper.depositPayNowScreen, arguments: [model, paymentMethod]);
  }

}