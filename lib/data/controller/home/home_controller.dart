import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:eastern_trust/core/helper/string_format_helper.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/data/model/dashboard/dashboard_response_model.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/repo/home/home_repo.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';
import 'package:http/http.dart' as http;

import '../../../core/helper/shared_preference_helper.dart';

class HomeController extends GetxController {

  HomeRepo repo;
  HomeController({required this.repo});

  bool isLoading = true;
  String username = "";
  String email = "";
  String balance = "";
  String accountNumber = "";
  String accountName = "";
  String currency = "";
  String currencySymbol = "";
  String imagePath = "";

  List<LatestDebitsData> debitsLists = [];
  List<Widget>moduleList = [];
  List<Widget>homeTopModuleList = [];
  bool isContentScrollable = false;

  Future<void> loadData() async{

    moduleList = repo.apiClient.getModuleList();
    homeTopModuleList = repo.apiClient.getHomeTopModuleList();
    currency = repo.apiClient.getCurrencyOrUsername();
    currencySymbol = repo.apiClient.getCurrencyOrUsername(isSymbol: true);
    ResponseModel responseModel = await repo.getData();

    debitsLists.clear();

    if(responseModel.statusCode == 200){
      DashboardResponseModel model = DashboardResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if(model.status.toString().toLowerCase() == 'success'){
        username = model.data?.user?.username ?? "";
        email = model.data?.user?.email ?? "";
        accountNumber = model.data?.user?.accountNumber ?? "";
        imagePath = model.data?.user?.image??'';
        balance = Converter.formatNumber(model.data?.user?.balance ?? "");

        List<LatestCreditsData>? tempCreditList = model.data?.latestCredits?.data;
        if(tempCreditList != null && tempCreditList.isNotEmpty){
          for (var element in tempCreditList) {
            debitsLists.add(LatestDebitsData(
                amount: element.amount,
                charge: element.charge,
                postBalance: element.postBalance,
                trxType: element.trxType,
               trx: element.trx,
              details: element.details,
              remark: element.details,
              createdAt: element.createdAt,
              updatedAt: element.updatedAt
            ));
          }
        }

        List<LatestDebitsData>? tempDebitList = model.data?.latestDebits?.data;
        if(tempDebitList != null && tempDebitList.isNotEmpty){
          debitsLists.addAll(tempDebitList);
        }
        await repo.apiClient.sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, true);
        print('=====> home controller loggrd in');
      }
      else{
        CustomSnackBar.error(errorList: model.message?.error ??[ MyStrings.somethingWentWrong],);
      }
    }
    else{
      if (responseModel.statusCode == 503) {
        changeNoInternetStatus(true);
      }
      CustomSnackBar.error(errorList: [responseModel.message],);
    }

    isLoading = false;
    update();
    await repo.refreshGeneralSetting();
    moduleList = repo.apiClient.getModuleList();
    update();
  }

  void updateScrollStatus() {
    isContentScrollable = debitsLists.length > 3 ? true : false;
    update(); // triggers GetBuilder rebuild
  }

 /* bool isCreditSelected = true;
  void changeButtonState(bool status){
    isCreditSelected = status;
    update();
  }*/


  bool noInternet = false;
  void changeNoInternetStatus(bool status) {
    noInternet = status;
    update();
  }



}


