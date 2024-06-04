import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/string_format_helper.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/data/model/authorization/authorization_response_model.dart' as auth;
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/model/loan/loan_plan_response_model.dart';
import 'package:eastern_trust/data/model/loan/loan_preview_response_model.dart';
import 'package:eastern_trust/data/repo/dps/dps_repo.dart';
import 'package:eastern_trust/data/repo/loan/loan_repo.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';

class LoanPlanController extends GetxController{

  LoanRepo loanRepo;
  LoanPlanController({required this.loanRepo});

  bool isLoading = true;
  int index = 0;

  List<Data> planList = [];
  List<String>authorizationList = [];
  String? selectedAuthorizationMode ;

  String currency = "";
  String currencySymbol = "";

  void changeAuthorizationMode(String? value){
    if(value!=null){
      selectedAuthorizationMode = value;
      update();
    }
  }

  Future<void> loadLoanPlan() async{
    authorizationList = loanRepo.apiClient.getAuthorizationList();
    changeAuthorizationMode(authorizationList[0]);
    planList.clear();

    currency = loanRepo.apiClient.getCurrencyOrUsername();
    currencySymbol = loanRepo.apiClient.getCurrencyOrUsername(isSymbol: true);

    ResponseModel responseModel = await loanRepo.getLoanPlan();
    if(responseModel.statusCode == 200){
      LoanPlanResponseModel model = LoanPlanResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if(model.status.toString().toLowerCase() == "success"){
        List<Data>? tempPlanList = model.data?.loanPlans?.data;
        if(tempPlanList != null && tempPlanList.isNotEmpty){
          planList.addAll(tempPlanList);
        }
      }
      else{
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong],);
      }
    }
    else{
      CustomSnackBar.error(errorList: [responseModel.message],);
    }

    isLoading = false;
    update();
  }

  int selectedIndex = -1;
  void changeIndex(int index){
    selectedIndex = index;
    update();
  }

  bool submitLoading = false;
  TextEditingController amountController = TextEditingController();
  void submitLoanPlan(String planId) async{
    double amount = double.tryParse(amountController.text)??0;
    if(amount<=0){
      CustomSnackBar.error(errorList: [MyStrings.invalidAmount]);
      return;
    }

    double minLimit = double.tryParse(planList[index].minimumAmount??'0')??0;
    double maxLimit = double.tryParse(planList[index].maximumAmount??'0')??0;

    if(amount>maxLimit || amount<minLimit){
      CustomSnackBar.error(errorList: [MyStrings.loanLimitMsg]);
      return;
    }

    submitLoading = true;
    update();

    ResponseModel response = await loanRepo.submitLoanPlan(planId,amount.toString(),selectedAuthorizationMode);
    if(response.statusCode==200){
     LoanPreviewResponseModel model = LoanPreviewResponseModel.fromJson(jsonDecode(response.responseJson));
      if(model.status?.toLowerCase()==MyStrings.success.toLowerCase()){
        Get.offAndToNamed(RouteHelper.loanConfirmScreen,arguments:model);
      } else{
        CustomSnackBar.error(errorList: model.message?.error??[MyStrings.requestFail]);
      }
    } else{
      CustomSnackBar.error(errorList: [response.message]);
    }

    submitLoading = false;
    update();
  }


  String getDepositAmount(int index) {
     double totalInstallment = double.tryParse(planList[index].totalInstallment??'0')??0;
     double perInstallment = double.tryParse(planList[index].perInstallment??'0')??0;
     double depositAmount = totalInstallment*perInstallment;
     return Converter.formatNumber(depositAmount.toString(),precision: 2);
  }

}