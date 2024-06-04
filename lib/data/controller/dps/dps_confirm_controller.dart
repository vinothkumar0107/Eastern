import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/string_format_helper.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/data/model/authorization/authorization_response_model.dart';
import 'package:eastern_trust/data/model/dps/dps_preview_response_model.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/repo/dps/dps_repo.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';

class DPSConfirmController extends GetxController{

  DPSRepo dpsRepo;
  DPSConfirmController({required this.dpsRepo});

  bool isLoading = true;
  int index = 0;


  String currency = "";
  String currencySymbol = "";
  String verificationId = "";
  String amount = '';
  String delayCharge = '';
  Plan? plan = Plan();


  Future<void> loadPreviewData() async{
    currency = dpsRepo.apiClient.getCurrencyOrUsername();
    currencySymbol = dpsRepo.apiClient.getCurrencyOrUsername(isSymbol: true);

    ResponseModel responseModel = await dpsRepo.getDPSPreview(verificationId);
    if(responseModel.statusCode == 200){
      DpsPreviewResponseModel model = DpsPreviewResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if(model.status.toString().toLowerCase() == "success"){
        plan = model.data?.plan;
        amount = Converter.roundDoubleAndRemoveTrailingZero(model.data?.plan?.finalAmount??'');
        delayCharge = Converter.roundDoubleAndRemoveTrailingZero(model.data?.delayCharge??'');
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
  void confirmDPSRequest() async{
    isSubmitLoading = true;
    update();
    ResponseModel response = await dpsRepo.confirmDPSRequest(verificationId);
    if(response.statusCode==200){
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(response.responseJson));
      if(model.status?.toLowerCase()==MyStrings.success.toLowerCase()){
       Get.offAndToNamed(RouteHelper.dpsScreen,arguments: 'list');
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

  void cancelDPSRequest(){
    Get.offAndToNamed(RouteHelper.homeScreen);
  }

  String getProfitAmount() {
    double myAmount     = double.tryParse(amount)??0;
    double interestRate = double.tryParse(plan?.interestRate??'0')??0;
    double percent      = (myAmount*interestRate)/100;
    return Converter.roundDoubleAndRemoveTrailingZero(percent.toString());
  }

  String getDepositAmount() {
    double perInstallment = double.tryParse(plan?.perInstallment??'0')??0;
    double totalInstallment = double.tryParse(plan?.totalInstallment??'0')??0;
    double amount      = perInstallment*totalInstallment;
    return Converter.roundDoubleAndRemoveTrailingZero(amount.toString());
  }

}