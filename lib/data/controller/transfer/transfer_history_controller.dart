
import 'dart:convert';

import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/date_converter.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/model/transfer/history/transfer_history_response_model.dart';
import 'package:eastern_trust/data/repo/transfer_repo/transfer_repo.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';

class TransferHistoryController extends GetxController{

  TransferRepo repo;
  TransferHistoryController({required this.repo});

  bool isLoading = true;
  List<Data> historyList = [];

  int page = 1;
  String nextPageUrl = "";
  String currency = "";
  String currencySymbol = "";

  Future<void> loadPaginationData() async{
    await loadHistoryList();
    update();
  }

  void initialSelectedValue() async{
    currency = repo.apiClient.getCurrencyOrUsername();
    currencySymbol = repo.apiClient.getCurrencyOrUsername(isSymbol: true);

    page = 0;
    historyList.clear();
    isLoading = true;
    update();
    await loadHistoryList();
    isLoading = false;
    update();
  }

  Future<void> loadHistoryList() async{

    page = page + 1;
    if(page == 1){
      historyList.clear();
    }

    ResponseModel responseModel = await repo.getTransferHistory(page);
    if(responseModel.statusCode == 200){
     TransferHistoryResponseModel model = TransferHistoryResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      nextPageUrl = model.data?.transfers?.nextPageUrl ?? "";
      if(model.status.toString().toLowerCase() == MyStrings.success.toLowerCase()){
        List<Data>? tempTransferList = model.data?.transfers?.data;
        if(tempTransferList != null && tempTransferList.isNotEmpty){
          historyList.addAll(tempTransferList);
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
    String status = historyList[index].status??'';
    if(isStatus){
      return status=='1'?MyStrings.completed:status=='2'?MyStrings.rejected:MyStrings.pending;
    } else{
      return status=='1'?MyColor.greenSuccessColor:status=='2'?MyColor.redCancelTextColor:MyColor.pendingColor;
    }
  }

  bool isWithdrawEnable(int index) {
    String? withdrawAt = historyList[index].createdAt;
    if(withdrawAt != null && withdrawAt.isNotEmpty && withdrawAt != 'null'){
      bool  canWithdraw = DateConverter.isOverDate(withdrawAt);
      return canWithdraw;
    } else{
      return false;
    }
  }

  String getAccountName(int index) {
   String accountName = '';
   if(historyList[index].wireTransferData!=null && historyList[index].beneficiary==null){
     accountName = historyList[index].wireTransferData!=null && historyList[index].wireTransferData!.length>1?historyList[index].wireTransferData![0].value??'----':'----';
    } else{
     accountName = historyList[index].beneficiary?.shortName??'------';
   }
   return accountName;
  }

  String getAccountNumber(int index) {
    String accountNumber = '';
    if(historyList[index].wireTransferData!=null && historyList[index].beneficiary==null){
      accountNumber = historyList[index].wireTransferData!=null && historyList[index].wireTransferData!.length>1?historyList[index].wireTransferData![1].value??'----':'----';
    } else{
      accountNumber = historyList[index].beneficiary?.accountNumber??'------';
    }
    return accountNumber;
  }

  bool isGoHome(){
    String previousRoute = Get.previousRoute;
    if(previousRoute.isNotEmpty && previousRoute.contains('transfer')){
      return false;
    } else if(previousRoute==RouteHelper.notificationScreen){
      return false;
    } else{
      return true;
    }
  }

}