import 'dart:convert';

import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/string_format_helper.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/data/model/dps/dps_installment_log_response_model.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/repo/dps/dps_repo.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';


class DPSInstallmentLogController extends GetxController{

  DPSRepo dpsRepo;
  DPSInstallmentLogController({required this.dpsRepo});

  bool isLoading = true;
  List<Data> installmentLogList = [];

  int page = 1;
  String nextPageUrl = "";
  String currency = "";
  String currencySymbol = "";
  String dpsId = '';

  String depositAmount = '0';
  String profitAmount = '0';
  Dps? dps = Dps();

  Future<void> loadPaginationData() async{
    await loadInstallmentLog();
    update();
  }

  void initialSelectedValue() async{
    
    currency = dpsRepo.apiClient.getCurrencyOrUsername();
    currencySymbol = dpsRepo.apiClient.getCurrencyOrUsername(isSymbol: true);

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

    ResponseModel responseModel = await dpsRepo.getDPSInstallmentLog(dpsId,page);
    if(responseModel.statusCode == 200){
      DpsInstallmentLogResponseModel model = DpsInstallmentLogResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      nextPageUrl = model.data?.installments?.nextPageUrl ?? "";
      
      depositAmount = model.data?.depositAmount??'0';
      profitAmount = model.data?.profitAmount??'0';
      dps = model.data?.dps;

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


  String getIncludingProfit() {
    return Converter.sum(depositAmount,profitAmount);
  }



}