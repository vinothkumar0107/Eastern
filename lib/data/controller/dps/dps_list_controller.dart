import 'dart:convert';

import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/date_converter.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/data/model/authorization/authorization_response_model.dart' as global_model;
import 'package:eastern_trust/data/model/dps/dps_list_response_model.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/repo/dps/dps_repo.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';


class DPSListController extends GetxController{

  DPSRepo dpsRepo;
  DPSListController({required this.dpsRepo});

  bool isLoading = true;
  List<Data> dpsList = [];

  int page = 1;
  String nextPageUrl = "";
  String currency = "";
  String currencySymbol = "";

  Future<void> loadPaginationData() async{
    await loadFdrList();
    update();
  }

  void initialSelectedValue() async{
    currency = dpsRepo.apiClient.getCurrencyOrUsername();
    currencySymbol = dpsRepo.apiClient.getCurrencyOrUsername(isSymbol: true);

    page = 0;
    dpsList.clear();
    isLoading = true;
    update();

    await loadFdrList();
    isLoading = false;
    update();
  }

  Future<void> loadFdrList() async{

    page = page + 1;
    if(page == 1){
      dpsList.clear();
    }

    ResponseModel responseModel = await dpsRepo.getDPSList(page);
    if(responseModel.statusCode == 200){
      DpsListResponseModel model = DpsListResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      nextPageUrl = model.data?.allDps?.nextPageUrl ?? "";

      if(model.status.toString().toLowerCase() == "success"){
        List<Data>? tempDPSList = model.data?.allDps?.data;
        if(tempDPSList != null && tempDPSList.isNotEmpty){
          dpsList.addAll(tempDPSList);
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
    String status = dpsList[index].status??'';
    double dueCount = double.tryParse(dpsList[index].dueInstallmentsCount??'0')??0;
    bool isDue = false;
    if(dueCount>0){
      isDue = true;
    }
    if(isStatus){
      return isDue?MyStrings.due:status=='1'?MyStrings.running:status=='2'?MyStrings.matured:MyStrings.closed;
    } else{
      return isDue?MyColor.pendingColor:status=='1'?MyColor.greenSuccessColor:status=='2'?MyColor.pendingColor:MyColor.secondaryColor;
    }
  }

  bool isWithdrawEnable(int index) {
    String status = dpsList[index].status??'-1';
    return status == '2'?true:false;
  }

  bool isWithdrawLoading = false;
  void makeDPSWithdraw(int index)async{
    String dpsPlanId = dpsList[index].id.toString();
    isWithdrawLoading = true;
    update();
    ResponseModel response = await dpsRepo.withdrawDPS(dpsPlanId);
    if(response.statusCode==200){
      global_model.AuthorizationResponseModel model = global_model.AuthorizationResponseModel.fromJson(jsonDecode(response.responseJson));
      if(model.status?.toLowerCase()==MyStrings.success.toLowerCase()){
        Get.back();
        CustomSnackBar.success(successList: model.message?.success??[MyStrings.requestSuccess]);
      } else{
        CustomSnackBar.error(errorList: model.message?.error??[MyStrings.requestFail]);
      }
    } else{
      CustomSnackBar.error(errorList: [response.message]);
    }
  }


}