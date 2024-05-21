import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/model/referral/referral_response_model.dart';
import 'package:eastern_trust/data/repo/referral/referral_repo.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';

class ReferralController extends GetxController{
  ReferralRepo referralRepo;
  ReferralController({required this.referralRepo});

  bool isLoading = true;
  List<Referrals> dataList = [];

  String? nextPageUrl;
  int page = 0;
  String searchReferrals = "";

  TextEditingController searchController = TextEditingController();

  void initialSelectedValue() async{
    page = 0;
    dataList.clear();
    isLoading = true;
    update();

    await allReferralsData();
    isLoading = false;
    update();
  }

  void initData() async{
    await allReferralsData();
    isLoading=false;
    update();
  }

  void loadPaginationData()async{
    await allReferralsData();
    update();
  }

  Future<void> allReferralsData() async{
    page = page + 1;
    if(page == 1){
      dataList.clear();
    }

    ResponseModel responseModel = await referralRepo.getReferralData(page, searchText: searchReferrals);


    if(responseModel.statusCode == 200){
      ReferralModel referralModel = ReferralModel.fromJson(jsonDecode(responseModel.responseJson));

      if(referralModel.status.toString().toLowerCase() == "success"){
        List<Referrals>? tempList = referralModel.data?.referrals;
        if(tempList != null && tempList.isNotEmpty){
          dataList.addAll(tempList);
        }

        if(page==1){
          isLoading = false;
          update();
        }
      }
      else{
        CustomSnackBar.error(errorList: [referralModel.message.toString()],);
        return ;
      }
    }
    else{
      CustomSnackBar.error(errorList: [responseModel.message.toString()],);
      return ;
    }
  }

  bool filterLoading = false;

  Future<void> filterData()async{
    searchReferrals = searchController.text;
    page = 0;
    filterLoading = true;
    update();

    await allReferralsData();

    filterLoading=false;
    update();
  }

  bool hasNext(){
    return nextPageUrl != null && nextPageUrl!.isNotEmpty && nextPageUrl != 'null' ? true : false;
  }
}