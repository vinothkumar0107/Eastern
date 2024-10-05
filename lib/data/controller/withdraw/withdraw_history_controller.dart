import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/url.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/model/withdraw/withdraw_history_response_model.dart';
import 'package:eastern_trust/data/repo/withdraw/withdraw_history_repo.dart';
import 'package:eastern_trust/views/components/file_download_dialog/download_dialogue.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';

class WithdrawHistoryController extends GetxController{

  WithdrawHistoryRepo withdrawHistoryRepo;
  WithdrawHistoryController({required this.withdrawHistoryRepo});

  bool isLoading = true;
  String currency = "";
  String curSymbol = "";
  String nextPageUrl = "";

  List<WithdrawListModel> withdrawList = [];
  int page = 0;

  Future<void> loadPaginationData() async{
    await loadWithdrawData();
    update();
  }

  Future<void> loadWithdrawData() async{
    currency = withdrawHistoryRepo.apiClient.getCurrencyOrUsername();
    curSymbol = withdrawHistoryRepo.apiClient.getCurrencyOrUsername(isSymbol: true);
    page = page + 1;
    if(page == 1){
      withdrawList.clear();
    }
    String searchText = searchController.text;

    ResponseModel responseModel = await withdrawHistoryRepo.getWithdrawHistoryData(page, searchText: searchText);
    if(responseModel.statusCode == 200){
      WithdrawHistoryResponseModel model = WithdrawHistoryResponseModel.fromJson(jsonDecode(responseModel.responseJson));

      nextPageUrl = model.data?.withdrawals?.nextPageUrl ?? "";

      if(model.status.toString().toLowerCase() == "success"){
        List<WithdrawListModel>? tempWithdrawList = model.data?.withdrawals?.data;
        if(tempWithdrawList != null && tempWithdrawList.isNotEmpty){
          withdrawList.addAll(tempWithdrawList);
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

  bool filterLoading = false;
  Future<void> filterData() async{
    page = 0;
    filterLoading = true;
    update();
    await loadWithdrawData();
    filterLoading = false;
    update();
  }

  bool hasNext(){
    return nextPageUrl.isNotEmpty && nextPageUrl != 'null' ? true : false;
  }

  void initData() async{
    currency = withdrawHistoryRepo.apiClient.getCurrencyOrUsername();
    page = 0;
    searchController.text = '';
    withdrawList.clear();
    isLoading = true;
    update();
    await loadWithdrawData();
    isLoading = false;
    update();
  }


  bool isSearch = true; // By default set to true
  TextEditingController searchController = TextEditingController();
  void changeSearchStatus() async{
    // isSearch = ! isSearch;
    update();
    if(!isSearch){
      initData();
    }
  }

  String getStatus(int index) {
    String status = withdrawList[index].status == "1" ? MyStrings.approved
        : withdrawList[index].status == "2" ? MyStrings.pending
        : withdrawList[index].status == "3" ? MyStrings.rejected : "";

    return status;
  }

  Color getColor(int index) {
    String status = withdrawList[index].status??'';
      return status == '1'? MyColor.greenSuccessColor:status == '2' ? MyColor.pendingColor : status == '3'? MyColor.redCancelTextColor : MyColor.colorGrey;
  }

  void downloadAttachment(String url,BuildContext context) {
    String mainUrl = '${UrlContainer.baseUrl}assets/verify/$url';
    if(url.isNotEmpty && url != 'null'){
      showDialog(
        context: context,
        builder: (context) => DownloadingDialog(isPdf:false,url: mainUrl,fileName: '',),
      );
      update();
    }
  }

  bool isGoHome(){
    String previousRoute = Get.previousRoute;
    if(previousRoute==RouteHelper.notificationScreen || previousRoute == RouteHelper.menuScreen){
      return false;
    } else{
      return true;
    }
  }
}