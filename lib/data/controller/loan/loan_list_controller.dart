import 'dart:convert';

import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/string_format_helper.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/model/loan/loan_list_response_model.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';
import '../../repo/loan/loan_repo.dart';


class LoanListController extends GetxController{

  LoanRepo loanRepo;
  LoanListController({required this.loanRepo});

  bool isLoading = true;
  List<Data> loanList = [];

  int page = 1;
  String nextPageUrl = "";
  String currency = "";
  String currencySymbol = "";

  Future<void> loadPaginationData() async{
    await loadLoanList();
    update();
  }

  void initialSelectedValue() async{
    currency = loanRepo.apiClient.getCurrencyOrUsername();
    currencySymbol = loanRepo.apiClient.getCurrencyOrUsername(isSymbol: true);
    page = 0;
    loanList.clear();
    isLoading = true;
    update();

    await loadLoanList();
    isLoading = false;
    update();
  }

  Future<void> loadLoanList() async{

    page = page + 1;
    if(page == 1){
      loanList.clear();
    }

    ResponseModel responseModel = await loanRepo.getMyLoanList(page);
    if(responseModel.statusCode == 200){
      LoanListResponseModel model = LoanListResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      nextPageUrl = model.data?.loans?.nextPageUrl ?? "";

      if(model.status.toString().toLowerCase() == "success"){
        List<Data>? tempDPSList = model.data?.loans?.data;
        if(tempDPSList != null && tempDPSList.isNotEmpty){
          loanList.addAll(tempDPSList);
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

  dynamic getStatusAndColor(int index,{isStatus=true}) {
    String status = loanList[index].status??'';
    if(isStatus){
      return status == '0'? MyStrings.pending:status=='1'?MyStrings.running:status=='2'?MyStrings.paid:MyStrings.rejected;
    }else{
      return status == '0'? MyColor.pendingColor:status=='1'?MyColor.greenSuccessColor:status=='2'?MyColor.greenSuccessColor:MyColor.redCancelTextColor;
    }
  }

 String getNeedToPayAmount(int index) {
    double totalInstallment  = double.tryParse(loanList[index].totalInstallment??'0')??0;
    double perInstallment  = double.tryParse(loanList[index].perInstallment??'0')??0;
    double needToPay = totalInstallment*perInstallment;
    return Converter.formatNumber(needToPay.toString());
  }


}