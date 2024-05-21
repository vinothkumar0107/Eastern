import 'dart:convert';
import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/string_format_helper.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/data/model/fdr/fdr_installment_log_response_model.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/repo/fdr/fdr_repo.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';


class FDRInstallmentLogController extends GetxController{

  FDRRepo fdrRepo;
  FDRInstallmentLogController({required this.fdrRepo});

  bool isLoading = true;
  List<Data> installmentLogList = [];

  int page = 1;
  String nextPageUrl = "";
  String currency = "";
  String currencySymbol = "";
  String fdrId = '';

  String depositAmount = '0';
  String interestRate = '0';
  String profitAmount = '0';
  String receivedInstallment = '0';
  Fdr? fdr = Fdr();

  Future<void> loadPaginationData() async{
    await loadInstallmentLog();
    update();
  }

  void initialSelectedValue() async{
    
    currency = fdrRepo.apiClient.getCurrencyOrUsername();
    currencySymbol = fdrRepo.apiClient.getCurrencyOrUsername(isSymbol: true);

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

    ResponseModel responseModel = await fdrRepo.getFDRInstallmentLog(fdrId,page);
    if(responseModel.statusCode == 200){

      FdrInstallmentLogResponseModel model = FdrInstallmentLogResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      nextPageUrl = model.data?.installments?.nextPageUrl ?? "";
      interestRate = model.data?.interestRate??'';
      fdr = model.data?.fdr;
      profitAmount = fdr?.profit??'0';
      depositAmount = fdr?.amount??'0';
      receivedInstallment = model.data?.installments?.total??'0';

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


}