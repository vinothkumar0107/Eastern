import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/data/model/fdr/fdr_review_response_model.dart';
import 'package:eastern_trust/data/model/fdr/fdr_plan_response_model.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/repo/fdr/fdr_repo.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';

class FDRPlanController extends GetxController{

  FDRRepo fdrPlanRepo;
  FDRPlanController({required this.fdrPlanRepo});

  bool isLoading = true;
  int index = 0;

  List<FdrPlans> planList = [];
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

  Future<void> loadFDRPlanData() async{
    isLoading = true;
    selectedIndex = -1;
    update();
    authorizationList = fdrPlanRepo.apiClient.getAuthorizationList();
    changeAuthorizationMode(authorizationList[0]);
    planList.clear();

    currency = fdrPlanRepo.apiClient.getCurrencyOrUsername();
    currencySymbol = fdrPlanRepo.apiClient.getCurrencyOrUsername(isSymbol: true);

    ResponseModel responseModel = await fdrPlanRepo.getFdrPlan();
    if(responseModel.statusCode == 200){
      FdrPlanResponseModel model = FdrPlanResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if(model.status.toString().toLowerCase() == "success"){
        List<FdrPlans>? tempPlanList = model.data?.fdrPlans;
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

  TextEditingController amountController = TextEditingController();
  bool isSubmitLoading = false;
  void submitFDRPlan(String planId,int index) async{

    double amount = double.tryParse(amountController.text)??0;
    if(amount<=0){
      CustomSnackBar.error(errorList: [MyStrings.invalidAmount]);
      return;
    }

    double minLimit = double.tryParse(planList[index].minimumAmount??'0')??0;
    double maxLimit = double.tryParse(planList[index].maximumAmount??'0')??0;

    if(amount>maxLimit || amount<minLimit){
      CustomSnackBar.error(errorList: [MyStrings.fdrLimitMsg]);
      return;
    }

    if(authorizationList.length>1 && selectedAuthorizationMode?.toLowerCase()==MyStrings.selectOne.toLowerCase()){
      CustomSnackBar.error(errorList: [MyStrings.selectAuthModeMsg]);
      return;
    }

    isSubmitLoading = true;
    update();
    ResponseModel response = await fdrPlanRepo.submitFDRPlan(planId,amount.toString(),selectedAuthorizationMode);
    if(response.statusCode==200){
      FdrPreviewResponseModel model = FdrPreviewResponseModel.fromJson(jsonDecode(response.responseJson));
      if(model.status?.toLowerCase()==MyStrings.success.toLowerCase()){
        String otpId = model.data?.otpId??'';
        Get.back();
        if(otpId.isNotEmpty){
          Get.toNamed(RouteHelper.otpScreen,arguments:[RouteHelper.fdrConfirmScreen,model.data?.otpId,selectedAuthorizationMode?.toLowerCase().toString()]);
        } else{
          Get.toNamed(RouteHelper.fdrConfirmScreen,arguments:model.data?.verificationId??'');
        }
      } else{
        CustomSnackBar.error(errorList: model.message?.error??[MyStrings.requestFail]);
      }
    } else{
      CustomSnackBar.error(errorList: [response.message]);
    }
    isSubmitLoading = false;
    update();
  }

  void clearBottomSheetData() {
    amountController.text = '';
    if(selectedAuthorizationMode!=null && selectedAuthorizationMode!.isNotEmpty && selectedAuthorizationMode!.toLowerCase()!=MyStrings.selectOne.toLowerCase()){
      changeAuthorizationMode(MyStrings.selectOne);
    }
  }

  bool isPlanSelected = true;
  void changeActiveTab(int index){
    isPlanSelected = index==0;
    update();
  }

}