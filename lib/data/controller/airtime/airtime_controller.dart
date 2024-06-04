import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/data/model/airtime/apply_topup_response_model.dart';
import 'package:eastern_trust/data/model/airtime/operator_response_model.dart';

import '../../../core/utils/my_strings.dart';
import '../../../views/components/snackbar/show_custom_snackbar.dart';
import '../../model/airtime/airtime_country_model.dart';
import '../../model/global/response_model/response_model.dart';
import '../../repo/airtime/airtime_repo.dart';

class AirtimeController extends GetxController{

  AirtimeRepo airtimeRepo;

  AirtimeController({required this.airtimeRepo});

  final FocusNode mobileFocusNode = FocusNode();
  final FocusNode amountFocusNode = FocusNode();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  List<Country> countryList = [];
  List<TabsModel> tabsList = [];
  String currency = "";
  String curSymbol = "";
  Country selectedCountry = Country(id: -1);
  Operator selectedOperator = Operator(id: -1);

  List<String>authorizationList = [];
  String? selectedAuthorizationMode ;

  void changeAuthorizationMode(String? value){
    if(value!=null){
      selectedAuthorizationMode = value;
      update();
    }
  }

  void initialSelectedValue() async{
    authorizationList = airtimeRepo.apiClient.getAuthorizationList();
    changeAuthorizationMode(authorizationList[0]);
    update();
  }

  var isLoading = false;

  Future<void> loadCountryData() async {

    currency = airtimeRepo.apiClient.getCurrencyOrUsername();
    curSymbol = airtimeRepo.apiClient.getCurrencyOrUsername(isSymbol: true);

    isLoading = true;
    update();

    ResponseModel responseModel = await airtimeRepo.getAirtimeCountry();

    if(responseModel.statusCode == 200){
      AirtimeCountryModel model = AirtimeCountryModel.fromJson(jsonDecode(responseModel.responseJson));

      if(model.status.toString().toLowerCase() == MyStrings.success.toString().toLowerCase()){

        List<Country>? tempCountryList = model.data?.countries;
        if(tempCountryList != null && tempCountryList.isNotEmpty){
          countryList.clear();
          countryList.addAll(tempCountryList);
        }

      }else{
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong]);
      }
    }else{
      CustomSnackBar.error(errorList: [MyStrings.somethingWentWrong]);
    }

    isLoading = false;
    update();
  }

  Future<void> loadOperator({required String countryId}) async {

    isLoading = true;
    update();

    ResponseModel responseModel = await airtimeRepo.getOperator(countryId: countryId);

    if(responseModel.statusCode == 200){
      OperatorResponseModel model = OperatorResponseModel.fromJson(jsonDecode(responseModel.responseJson));

      if(model.status.toString().toLowerCase() == MyStrings.success.toString().toLowerCase()){

        List<TabsModel>? tempTabsList = model.data?.tabs;
        if(tempTabsList != null && tempTabsList.isNotEmpty){
          tabsList.clear();
          tabsList.addAll(tempTabsList);
        }

      }else{
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong]);
      }
    }else{
      CustomSnackBar.error(errorList: [responseModel.message]);
    }

    isLoading = false;
    update();
  }


  setCountry(Country country){
    selectedCountry = country;
    update();
  }


  int currentTab = 0;
  void onTabClick(int index){
    currentTab = index;
    operatorCurrentIndex = -1;
    update();
  }

  void onCountryTap(Country country){
    selectedCountry = country;
    selectedOperator = Operator(id: -1);
    currentTab = 0;
    fixAmountDescriptionList.clear();
    fixedAmountList.clear();suggestedAmountList.clear();
    update();
    Get.back();
  }



  List<Description> fixAmountDescriptionList = [];
  List<String> fixedAmountList = [];
  List<String> suggestedAmountList = [];
  int operatorCurrentIndex = -1;
  void onOperatorClick(Operator operator,int index){
    selectedOperator = operator;
    operatorCurrentIndex = index;

    fixAmountDescriptionList.clear();
    fixedAmountList.clear();
    suggestedAmountList.clear();

    if(operator.fixedAmountsDescriptions != null && operator.fixedAmountsDescriptions!.isNotEmpty){
      fixAmountDescriptionList.addAll(operator.fixedAmountsDescriptions!);
    }

    if(operator.fixedAmounts != null && operator.fixedAmounts!.isNotEmpty){
      fixedAmountList.addAll(operator.fixedAmounts!);
    }

    if(operator.suggestedAmounts != null && operator.suggestedAmounts!.isNotEmpty){
      suggestedAmountList.addAll(operator.suggestedAmounts!);
    }

    update();
  }

  int selectedAmountIndex = -1;
  String selectedAmount = "";

  void onSelectedAmount(int index, String amount){
    selectedAmountIndex = index;
    selectedAmount = amount;
    update();
  }


  bool submitLoading = false;
  submitTopUp() async {

    if(selectedCountry.id == -1){
      CustomSnackBar.error(errorList: [MyStrings.selectCountry.tr]);
      return ;
    }else if(selectedOperator.id == -1){
      CustomSnackBar.error(errorList: [MyStrings.selectOperator.tr]);
      return ;
    }else if(mobileController.text.isEmpty){
      CustomSnackBar.error(errorList: [MyStrings.enterPhoneNumber.tr]);
      return ;
    }else if(authorizationList.length>1 && selectedAuthorizationMode?.toLowerCase()==MyStrings.selectOne.toLowerCase()){
      CustomSnackBar.error(errorList: [MyStrings.selectAuthModeMsg]);
      return;
    } else if(selectedCountry.callingCodes == null || selectedCountry.callingCodes![0].isEmpty){
      CustomSnackBar.error(errorList: [MyStrings.callingCodeIsEmpty.tr]);
      return ;
    }else if(selectedOperator.denominationType == MyStrings.fixed && selectedAmount.isEmpty){
      CustomSnackBar.error(errorList: [MyStrings.selectAmount.tr]);
      return ;
    }else if(selectedOperator.denominationType == MyStrings.range && amountController.text.isEmpty){
      CustomSnackBar.error(errorList: [MyStrings.enterAmount.tr]);
      return ;
    }

    Map<String, String> model = {
      "country_id" : selectedCountry.id.toString(),
      "operator_id" : selectedOperator.id.toString(),
      "calling_code" : selectedCountry.callingCodes![0].toString(),
      "mobile_number" : mobileController.text.toString(),
      "amount" : getAmount(selectedOperator.denominationType ?? MyStrings.range),
      "auth_mode" : selectedAuthorizationMode?.toLowerCase()??""
    };

    submitLoading=true;
    update();

    ResponseModel responseModel = await airtimeRepo.airtimeApply(model);

    ApplyTopUpResponseModel topUpResponseModel =  ApplyTopUpResponseModel.fromJson(jsonDecode(responseModel.responseJson));

    if(topUpResponseModel.status.toString().toLowerCase() == MyStrings.success.toLowerCase()){

      Get.offAllNamed(RouteHelper.homeScreen);
      CustomSnackBar.success(successList: topUpResponseModel.message?.success ?? [MyStrings.somethingWentWrong.tr]);

    }else{
      CustomSnackBar.error(errorList: topUpResponseModel.message?.error ?? [MyStrings.somethingWentWrong.tr]);
    }

    submitLoading=false;
    update();

  }


  String getAmount(String denominationType){
    if(denominationType == MyStrings.fixed){
      return selectedAmount;
    }else{
      return amountController.text;
    }
  }
}