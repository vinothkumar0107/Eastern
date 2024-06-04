import 'dart:convert';

import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/date_converter.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/data/model/authorization/authorization_response_model.dart';
import 'package:eastern_trust/data/model/fdr/fdr_list_response_model.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';

import '../../repo/fdr/fdr_repo.dart';

class FDRListController extends GetxController{

  FDRRepo fdrRepo;
  FDRListController({required this.fdrRepo});

  bool isLoading = true;
  List<FdrListData> fdrList = [];

  int page = 1;
  String nextPageUrl = "";
  String currency = "";
  String currencySymbol = "";

  Future<void> loadPaginationData() async{
    await loadFdrList();
    update();
  }

  Future<void> initialSelectedValue() async{
    currency = fdrRepo.apiClient.getCurrencyOrUsername();
    currencySymbol = fdrRepo.apiClient.getCurrencyOrUsername(isSymbol: true);

    page = 0;
    fdrList.clear();
    isLoading = true;
    update();

    await loadFdrList();
    isLoading = false;
    update();
  }

  Future<void> loadFdrList() async{

    page = page + 1;
    if(page == 1){
      fdrList.clear();
    }

    ResponseModel responseModel = await fdrRepo.getFdrList(page);
    if(responseModel.statusCode == 200){
      FdrListResponseModel model = FdrListResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      nextPageUrl = model.data?.fdr?.nextPageUrl ?? "";
      if(model.status.toString().toLowerCase() == "success"){
        List<FdrListData>? tempFdrList = model.data?.fdr?.data;
        if(tempFdrList != null && tempFdrList.isNotEmpty){
          fdrList.addAll(tempFdrList);
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
    String status = fdrList[index].status??'';
    bool lockOver = DateConverter.isOverDate(fdrList[index].nextInstallmentDate??'',);
    bool isDue = false;
    if(status=='1' && lockOver){
      isDue = true;
    }
    if(isStatus){
      return isDue?MyStrings.due:status=='1'?MyStrings.running:MyStrings.closed;
    } else{
      return isDue?MyColor.pendingColor:status=='1'?MyColor.greenSuccessColor:MyColor.redCancelTextColor;
    }
  }

  bool canClose(int index) {
      String? lockedAt = fdrList[index].lockedDate;
      if(lockedAt != null && lockedAt.isNotEmpty && lockedAt != 'null'){
        bool  isLockTimeStart = DateConverter.isOverDate(lockedAt,checkLessThen: false);
        String status =  fdrList[index].status.toString();
        if((status=='1' && isLockTimeStart )|| status =='2'){
          return false;
        }  else{
          return true;
        }
      } else{
        return true;
      }
  }

  bool isCloseFDRLoading = false;
  void closeFDR(int index)async{
    String dpsPlanId = fdrList[index].id.toString();
    isCloseFDRLoading = true;
    update();
    ResponseModel response = await fdrRepo.closeFDR(dpsPlanId);
    if(response.statusCode==2011){
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(response.responseJson));
      if(model.status?.toLowerCase()==MyStrings.success.toLowerCase()){
        Get.back();
        page = 0;
        nextPageUrl = '';
        await loadFdrList();
        CustomSnackBar.success(successList: model.message?.success??[MyStrings.requestSuccess]);
      } else{
        CustomSnackBar.error(errorList: model.message?.error??[MyStrings.requestFail]);
      }
    } else{
      CustomSnackBar.error(errorList: [response.message]);
    }
    isCloseFDRLoading = false;
    update();
  }


}