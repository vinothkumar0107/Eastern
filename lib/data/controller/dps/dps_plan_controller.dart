import 'dart:convert';
import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/string_format_helper.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/data/model/authorization/authorization_response_model.dart';
import 'package:eastern_trust/data/model/dps/dps_plan_response_model.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/repo/dps/dps_repo.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';

class DPSPlanController extends GetxController{

  DPSRepo dpsRepo;
  DPSPlanController({required this.dpsRepo});

  bool isLoading = true;
  int index = 0;

  List<DpsPlansData> planList = [];
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

  Future<void> loadDPSPlanData() async{
    isLoading = true;
    authorizationList = dpsRepo.apiClient.getAuthorizationList();
    changeAuthorizationMode(authorizationList[0]);
    planList.clear();

    update();

    currency = dpsRepo.apiClient.getCurrencyOrUsername();
    currencySymbol = dpsRepo.apiClient.getCurrencyOrUsername(isSymbol: true);

    ResponseModel responseModel = await dpsRepo.getDpsPlan();
    if(responseModel.statusCode == 200){
      DpsPlanResponseModel model = DpsPlanResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if(model.status.toString().toLowerCase() == "success"){
        List<DpsPlansData>? tempPlanList = model.data?.dpsPlans?.data;
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
  void submitDpsPlan(String planId) async{
    if(authorizationList.length>1&&selectedAuthorizationMode?.toLowerCase()==MyStrings.selectOne.toLowerCase()){
      CustomSnackBar.error(errorList: [MyStrings.selectAuthModeMsg]);
      return;
    }
    submitLoading = true;
    update();
    ResponseModel response = await dpsRepo.submitDPSPlan(planId,selectedAuthorizationMode);
    if(response.statusCode==200){
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(response.responseJson));
      if(model.status?.toLowerCase()==MyStrings.success.toLowerCase()){
        String otpId = model.data?.otpId??'';
        if(authorizationList.length>1 && otpId.isNotEmpty){
          Get.offAndToNamed(RouteHelper.otpScreen,arguments:[RouteHelper.dpsConfirmScreen,model.data?.otpId,selectedAuthorizationMode?.toLowerCase().toString()]);
        } else{
          String verificationId = model.data?.verificationId??'';
          Get.offAndToNamed(RouteHelper.dpsConfirmScreen,arguments:verificationId);
        }

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

  void clearBottomSheetData() {
    if(selectedAuthorizationMode!=null && selectedAuthorizationMode!.isNotEmpty && selectedAuthorizationMode!.toLowerCase()!=MyStrings.selectOne.toLowerCase()){
      changeAuthorizationMode(MyStrings.selectOne);
    }
  }

}