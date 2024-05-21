

import 'dart:convert';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_images.dart';
import 'package:eastern_trust/data/model/authorization/authorization_response_model.dart' as auth;
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/model/notification/notification_response_model.dart';
import 'package:eastern_trust/data/repo/notification_repo/notification_repo.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';
import '../../../core/utils/my_strings.dart';

class NotificationsController extends GetxController {
  NotificationRepo repo;
  bool isLoading = true;

  NotificationsController({required this.repo});

  String? nextPageUrl;
  String? imageUrl;


   List<Data> notificationList = [];

   int page = 0;

  Future<void> initData() async {
    page=page+1;
     if(page==1){
       notificationList.clear();
       isLoading=true;
       update();
     }

     ResponseModel response = await repo.loadAllNotification(page);
     if(response.statusCode==200){
       NotificationResponseModel model = NotificationResponseModel.fromJson(jsonDecode(response.responseJson));

       nextPageUrl=model.data?.notifications?.nextPageUrl;
       if(model.status?.toLowerCase() == MyStrings.success.toLowerCase()){
         List<Data>?tempList= model.data?.notifications?.data;
         if(tempList!=null && tempList.isNotEmpty){
           notificationList.addAll(tempList);
         }
       }else{
         CustomSnackBar.error(errorList: model.message?.error??[MyStrings.somethingWentWrong]);
       }
     }else{
       CustomSnackBar.error(errorList: [response.message]);
     }

     if(page==1){
       isLoading=false;
     }
    update();
   }



  bool hasNext() {
    return nextPageUrl != null && nextPageUrl!.isNotEmpty && nextPageUrl!.toLowerCase()!='null'? true : false;
  }



  bool nextPageLoading = true;
  int clickIndex = -1;
  Future<bool> markAsReadAndGotoThePage(int index) async {
        String? remark = notificationList[index].remark;
        int? id = notificationList[index].id;
    if(remark!=null && remark.isNotEmpty){
      nextPageLoading = true;
      clickIndex = index;
      update();
      ResponseModel response = await repo.readNotification(id??0);
      if(response.statusCode==200){
        auth.AuthorizationResponseModel model = auth.AuthorizationResponseModel.fromJson(jsonDecode(response.responseJson));
        if(model.status!.toLowerCase()==MyStrings.success.toLowerCase()){
          checkAndRedirect(remark);
        }else{
          CustomSnackBar.error(errorList: model.message?.error??[MyStrings.somethingWentWrong]);
        }
      }else{
        CustomSnackBar.error(errorList: [response.message]);
      }
    }

    clickIndex = -1;
    nextPageLoading = false;
    return true;
  }

  checkAndRedirect(String remark) async{

    if(trxHistoryRemark.contains(remark)){
      Get.toNamed(RouteHelper.transactionScreen);
    }else if(withdrawRemark.contains(remark)){
      Get.toNamed(RouteHelper.withdrawScreen);
    }else if(depositHistoryRemark.contains(remark)){
      Get.toNamed(RouteHelper.depositsScreen);
    }else if(transferHistoryRemark.contains(remark)){
      Get.toNamed(RouteHelper.transferHistoryScreen);
    }else if(loanHistoryRemark.contains(remark)){
      Get.toNamed(RouteHelper.loanScreen,arguments: 'list');
    }else if(dpsHistoryRemark.contains(remark)){
      Get.toNamed(RouteHelper.dpsScreen,arguments: 'list');
    }else if(fdrHistoryRemark.contains(remark)){
      Get.toNamed(RouteHelper.fdrScreen,arguments: 'list');
    }

    clickIndex = -1;
    update();

  }

  List<String>trxHistoryRemark = ['BAL_ADD','BAL_SUB','REFERRAL-COMMISSION','BALANCE_TRANSFER','BALANCE_RECEIVE'];
  List<String>withdrawRemark = ['WITHDRAW_APPROVE','WITHDRAW_REJECT','WITHDRAW_REJECT','WITHDRAW_REQUEST'];
  List<String>transferHistoryRemark = ["TRANSFER",'OTHER_BANK_TRANSFER_COMPLETE','WIRE_TRANSFER_COMPLETED','OWN_BANK_TRANSFER_MONEY_SEND','OWN_BANK_TRANSFER_MONEY_RECEIVE','OTHER_BANK_TRANSFER_REQUEST_SEND'];
  List<String>depositHistoryRemark = ['DEPOSIT_APPROVE','DEPOSIT_COMPLETE','DEPOSIT_REJECT','DEPOSIT_REQUEST'];
  List<String>loanHistoryRemark = ['LOAN_APPROVE','LOAN_REJECT','LOAN_PAID','LOAN_INSTALLMENT_DUE'];
  List<String>dpsHistoryRemark = ['DPS_OPENED','DPS_MATURED','DPS_CLOSED','DPS_INSTALLMENT_DUE'];
  List<String>fdrHistoryRemark = ['FDR_OPENED','FDR_CLOSED'];

  String getIcon(String remark) {

     String myIcon = '';
    if(trxHistoryRemark.contains(remark)){
      myIcon = MyImages.transactionIcon;
    }else if(withdrawRemark.contains(remark)){
      myIcon = MyImages.withdrawIcon;
    }else if(transferHistoryRemark.contains(remark)){
      myIcon = MyImages.transferHistoryIcon;
    } else if(depositHistoryRemark.contains(remark)){
      myIcon = MyImages.depositIcon;
    }else if(loanHistoryRemark.contains(remark)){
      myIcon = MyImages.loanIcon1;
    }else if(fdrHistoryRemark.contains(remark)){
      myIcon = MyImages.fdrIcon;
    }else if(dpsHistoryRemark.contains(remark)){
      myIcon = MyImages.dpsIcon;
    }
    else{
      myIcon = MyImages.notificationIcon;
    }
     return myIcon;
  }

  Color getIconColor(String remark) {

    Color iconColor = MyColor.greenSuccessColor;
    if(trxHistoryRemark.contains(remark)){
      iconColor = MyColor.colorPlate[0];
    }else if(withdrawRemark.contains(remark)){
      iconColor = MyColor.colorPlate[1];
    }else if(transferHistoryRemark.contains(remark)){
      iconColor = MyColor.colorPlate[2];
    } else if(depositHistoryRemark.contains(remark)){
      iconColor = MyColor.colorPlate[3];
    }else if(loanHistoryRemark.contains(remark)){
      iconColor = MyColor.colorPlate[4];
    }else if(fdrHistoryRemark.contains(remark)){
      iconColor = MyColor.colorPlate[5];
    }else if(dpsHistoryRemark.contains(remark)){
      iconColor = MyColor.colorPlate[6];
    }
    else{
      iconColor = MyColor.colorPlate[7];
    }
     return iconColor;
  }


}
