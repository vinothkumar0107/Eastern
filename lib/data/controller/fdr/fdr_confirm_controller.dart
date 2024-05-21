import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/string_format_helper.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/data/model/authorization/authorization_response_model.dart';
import 'package:eastern_trust/data/model/fdr/fdr_review_response_model.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/repo/fdr/fdr_repo.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';

class FDRConfirmController extends GetxController{

  FDRRepo fdrPlanRepo;
  FDRConfirmController({required this.fdrPlanRepo});

  bool isLoading = true;
  int index = 0;

  String currency = "";
  String currencySymbol = "";
  String verificationId = "";
  String withdrawAvailableTil = "";
  String amount = '';
  Plan? plan = Plan();


  Future<void> loadPreviewData() async{
    currency = fdrPlanRepo.apiClient.getCurrencyOrUsername();
    currencySymbol = fdrPlanRepo.apiClient.getCurrencyOrUsername(isSymbol: true);

    ResponseModel responseModel = await fdrPlanRepo.getFDRPreview(verificationId);
    if(responseModel.statusCode == 200){
      FdrPreviewResponseModel model = FdrPreviewResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if(model.status.toString().toLowerCase() == "success"){
        plan = model.data?.plan;
        withdrawAvailableTil = model.data?.withdrawAvailable??'';
        amount = Converter.formatNumber(model.data?.amount??'0');
      } else{
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong],);
      }
    }
    else{
      CustomSnackBar.error(errorList: [responseModel.message],);
    }

    isLoading = false;
    update();
  }

  TextEditingController amountController = TextEditingController();
  bool isSubmitLoading = false;
  void confirmFDRRequest() async{
    isSubmitLoading = true;
    update();
    ResponseModel response = await fdrPlanRepo.confirmFDRRequest(verificationId);
    if(response.statusCode==200){
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(response.responseJson));
      if(model.status?.toLowerCase()==MyStrings.success.toLowerCase()){
       Get.offAndToNamed(RouteHelper.fdrScreen,arguments: 'list');
       CustomSnackBar.success(successList: model.message?.success??[MyStrings.requestSuccess]);
      } else{
        CustomSnackBar.error(errorList: model.message?.error??[MyStrings.requestFail]);
      }
    } else{
      CustomSnackBar.error(errorList: [response.message]);
    }
    isSubmitLoading = false;
    update();
  }

  void cancelFDRRequest(){
    Get.offAndToNamed(RouteHelper.homeScreen);
  }

  String getProfitAmount() {
    double myAmount     = double.tryParse(amount)??0;
    double interestRate = double.tryParse(plan?.interestRate??'0')??0;
    double percent      = (myAmount*interestRate)/100;
    return Converter.roundDoubleAndRemoveTrailingZero(percent.toString());
  }

}