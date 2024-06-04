import 'dart:convert';

import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/string_format_helper.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/model/loan/loan_installment_response_model.dart';
import 'package:eastern_trust/data/repo/loan/loan_repo.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';


class LoanInstallmentLogController extends GetxController{

  LoanRepo loanRepo;
  LoanInstallmentLogController({required this.loanRepo});

  bool isLoading = true;
  List<Data> installmentLogList = [];

  int page = 1;
  String nextPageUrl = "";
  String currency = "";
  String currencySymbol = "";
  String loanId = '';

  String depositAmount = '0';
  String profitAmount = '0';
  Loan? loan = Loan();

  Future<void> loadPaginationData() async{
    await loadInstallmentLog();
    update();
  }

  void initialSelectedValue() async{
    
    currency = loanRepo.apiClient.getCurrencyOrUsername();
    currencySymbol = loanRepo.apiClient.getCurrencyOrUsername(isSymbol: true);

    page = 0;
    installmentLogList.clear();
    isLoading = true;
    update();
    await loadInstallmentLog();
    isLoading = false;
    update();
  }

  Future<void> loadInstallmentLog() async{
    page = page + 1;
    if(page == 1){
      installmentLogList.clear();
    }

    ResponseModel responseModel = await loanRepo.getLoanInstallmentLog(loanId,page);
    if(responseModel.statusCode == 200){
      LoanInstallmentResponseModel model = LoanInstallmentResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      nextPageUrl = model.data?.installments?.nextPageUrl ?? "";
      
      loan = model.data?.loan;

      if(model.status.toString().toLowerCase() == MyStrings.success.toLowerCase()){
        List<Data>? tempDPSList = model.data?.installments?.data;
        if(tempDPSList != null && tempDPSList.isNotEmpty){
          installmentLogList.addAll(tempDPSList);
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

  bool hasNext(){
    return nextPageUrl.isNotEmpty && nextPageUrl != 'null' ? true : false;
  }

  getStatus() {}

  String getIncludingProfit() {
    return Converter.sum(depositAmount,profitAmount);
  }

 /* dynamic getStatusAndColor(int index,{isStatus=true}) {
    String status = installmentLogList[index].status??'';
    if(isStatus){
      return status=='1'?MyStrings.running:status=='2'?MyStrings.closed:MyStrings.due;
    } else{
      return status=='1'?MyColor.greenSuccessColor:status=='2'?MyColor.secondaryColor:MyColor.pendingColor;
    }
  }

  bool isWithdrawEnable(int index) {
    String? withdrawAt = installmentLogList[index].createdAt;
    if(withdrawAt!=null && withdrawAt.isNotEmpty && withdrawAt!='null'){
      bool  canWithdraw = DateConverter.isOverDate(withdrawAt);
      return canWithdraw;
    } else{
      return false;
    }
  }*/


}