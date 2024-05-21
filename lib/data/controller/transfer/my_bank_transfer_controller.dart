import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/data/model/authorization/authorization_response_model.dart' as auth_model;
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/model/transfer/beneficiary/check_account_response_model.dart';
import 'package:eastern_trust/data/model/transfer/beneficiary/my_bank_beneficiary_response_model.dart';
import 'package:eastern_trust/data/repo/transfer_repo/beneficiaries_repo/beneficiaries_repo.dart';
import 'package:eastern_trust/data/repo/transfer_repo/transfer_repo.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';

class MyBankTransferController extends GetxController{

  TransferRepo repo;
  BeneficiaryRepo beneficiaryRepo;
  MyBankTransferController({required this.repo,required this.beneficiaryRepo});

  bool isLoading = true;
  List<Data> beneficiaryList = [];

  int page = 1;
  String nextPageUrl = "";
  String currency = "";
  String currencySymbol = "";
  String limitPerTrx = '0';
  String dailyMaxLimit = '0';
  String monthlyLimit = '0';
  String chargePerTrx = '0';

  List<String>authorizationList = [];
  String? selectedAuthorizationMode ;

  void changeAuthorizationMode(String? value){
    if(value!=null){
      selectedAuthorizationMode = value;
      update();
    }
  }

  Future<void> loadPaginationData() async{
    await loadHistoryList();
    update();
  }

  void initialSelectedValue() async{
    currency = repo.apiClient.getCurrencyOrUsername();
    currencySymbol = repo.apiClient.getCurrencyOrUsername(isSymbol: true);
    authorizationList = repo.apiClient.getAuthorizationList();
    changeAuthorizationMode(authorizationList[0]);
    page = 0;
    beneficiaryList.clear();
    isLoading = true;
    update();
    await loadHistoryList();
    isLoading = false;
    update();
  }

  Future<void> loadHistoryList() async{

    page = page + 1;
    if(page == 1){
      beneficiaryList.clear();
    }

    ResponseModel responseModel = await beneficiaryRepo.getMyBankBeneficiary(page);
    if(responseModel.statusCode == 200){
      MyBankBeneficiaryResponseModel model = MyBankBeneficiaryResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      nextPageUrl = model.data?.beneficiaries?.nextPageUrl ?? "";
      if(model.status.toString().toLowerCase() == "success"){
        List<Data>? tempBeneficiaryList = model.data?.beneficiaries?.data;
        loadLimit(model);
        if(tempBeneficiaryList != null && tempBeneficiaryList.isNotEmpty){
          beneficiaryList.addAll(tempBeneficiaryList);
        }
      }
      else{
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong]);
      }
    }
    else{
      CustomSnackBar.error(errorList: [responseModel.message],);
    }
  }
  
  void loadLimit(MyBankBeneficiaryResponseModel model){
    chargePerTrx = model.data?.transferCharge??'';
    limitPerTrx =  model.data?.general?.minimumTransferLimit??'0';
    dailyMaxLimit =  model.data?.general?.dailyTransferLimit ?? '0';
    monthlyLimit =  model.data?.general?.monthlyTransferLimit ?? '0';
  }

  bool hasNext(){
    return nextPageUrl.isNotEmpty && nextPageUrl != 'null' ? true : false;
  }




  TextEditingController amountController = TextEditingController();
  bool submitLoading = false;
  void transferMoney(String id) async{
    String amount = amountController.text;
    if(amount.isEmpty){
      CustomSnackBar.error(errorList: [MyStrings.invalidAmount]);
      return;
    }

    if(authorizationList.length>1 && selectedAuthorizationMode?.toLowerCase()==MyStrings.selectOne.toLowerCase()){
      CustomSnackBar.error(errorList: [MyStrings.selectAuthModeMsg]);
      return;
    }

    submitLoading = true;
    update();
    ResponseModel response = await repo.myBankTransferRequest(id,amount,selectedAuthorizationMode);
    if(response.statusCode==200){
      auth_model.AuthorizationResponseModel model = auth_model.AuthorizationResponseModel.fromJson(jsonDecode(response.responseJson));
      if(model.status?.toLowerCase()==MyStrings.success.toLowerCase()){
        String otp = model.data?.otpId??'';
        if(otp.isNotEmpty && authorizationList.length>1){
          Get.offAndToNamed(RouteHelper.otpScreen,arguments:[RouteHelper.transferHistoryScreen,model.data?.otpId,selectedAuthorizationMode?.toLowerCase().toString()]);
        } else{
          Get.offAndToNamed(RouteHelper.transferHistoryScreen);
          CustomSnackBar.success(successList: model.message?.success??[MyStrings.requestSuccess]);
        }
      } else{
        CustomSnackBar.error(errorList: model.message?.error??[MyStrings.requestFail]);
      }
    } else{
      CustomSnackBar.error(errorList: [response.message]);
    }
    amountController.text = '';
    submitLoading = false;
    update();
  }


  void clearTextField(){
    accountNoController.text = '';
    accountNameController.text = '';
    shortNameController.text = '';
  }

  TextEditingController accountNoController   = TextEditingController();
  TextEditingController accountNameController = TextEditingController();
  TextEditingController shortNameController   = TextEditingController();

  bool isSubmitLoading = false;
  void addBeneficiary() async{

    String accountNumber = accountNoController.text;
    String accountName = accountNameController.text;
    String shortName = shortNameController.text;

    if(accountNumber.isEmpty){
      CustomSnackBar.error(errorList: [MyStrings.accountNumberRequired]);
      return ;
    }

    if(accountName.isEmpty){
      CustomSnackBar.error(errorList: [MyStrings.accountNameRequired]);
      return ;
    }

    if(shortName.isEmpty){
      CustomSnackBar.error(errorList: [MyStrings.shortNameRequired]);
      return ;
    }

    isSubmitLoading = true;
    update();
    ResponseModel response = await beneficiaryRepo.addBeneficiary(accountNumber,accountName,shortName);
    if(response.statusCode==200){
      auth_model.AuthorizationResponseModel model = auth_model.AuthorizationResponseModel.fromJson(jsonDecode(response.responseJson));
      if(model.status?.toLowerCase()==MyStrings.success.toLowerCase()){
        Get.back();
        CustomSnackBar.success(successList: model.message?.success??[MyStrings.requestSuccess]);
        initialSelectedValue();
      } else{
        CustomSnackBar.error(errorList: model.message?.error??[MyStrings.requestFail]);
      }
    } else{
      CustomSnackBar.error(errorList: [response.message]);
    }
    isSubmitLoading = false;
    update();
  }

  bool hasAccountNumberFocus = false;
  void changeMobileFocus(bool hasFocus,bool isAccountNo) async{
    hasAccountNumberFocus = hasFocus;
    if(hasAccountNumberFocus==false){
      String value = isAccountNo?'account_number=${accountNoController.text.toString()}':'account_name=${accountNameController.text.toString()}';
      ResponseModel responseModel = await beneficiaryRepo.checkMyBankBeneficiary(value);
      if(responseModel.statusCode == 200){
        CheckAccountResponseModel model = CheckAccountResponseModel.fromJson(jsonDecode(responseModel.responseJson));
        if(model.data?.user!=null){
          String accountNumber = model.data?.user?.accountNumber??'';
          String accountName = model.data?.user?.accountName??'';
          accountNameController.text = accountName;
          accountNoController.text = accountNumber;
          try{
            FocusScope.of(Get.context!).unfocus();
          }catch(e){
            if (kDebugMode) {
            print(e.toString());
          }}

        }
      }
    }
    update();
  }

  bool isLimitShow = false;
  void changeLimitShowStatus(){
    isLimitShow = !isLimitShow;
    update();
  }



}