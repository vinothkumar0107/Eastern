import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/string_format_helper.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_images.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';

class CustomSnackBar{

  static  error({required List<String>errorList,int duration=5}){
    String message='';
      if(errorList.isEmpty){
        message = MyStrings.somethingWentWrong.tr;
      }else{
        for (var element in errorList) {
          String tempMessage = element.tr;
          message = message.isEmpty?tempMessage.tr:"$message\n$tempMessage";
        }
      }
      message = Converter.removeQuotationAndSpecialCharacterFromString(message);
    Get.rawSnackbar(
      progressIndicatorBackgroundColor: MyColor.transparentColor,
      progressIndicatorValueColor: const AlwaysStoppedAnimation<Color>(Colors.transparent),
      messageText: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 2,),
          Text(message,style: interRegularDefault.copyWith(color: MyColor.colorWhite ),),
        ],
      ),
      dismissDirection: DismissDirection.horizontal,
      snackPosition: SnackPosition.BOTTOM,
     /* titleText: Row(
        children: [
          SvgPicture.asset(MyImages.errorIcon,height: 20,width: 20,color: MyColor.colorWhite,),
          const SizedBox(width: 5),
          Text(MyStrings.error.tr.capitalizeFirst??'',style: interSemiBoldSmall.copyWith(fontSize: Dimensions.fontLarge,color: MyColor.colorWhite)),
        ],
      ),*/
      backgroundColor: MyColor.red,
      borderRadius: 4,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      duration:  Duration(seconds: duration),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeIn,
      showProgressIndicator: true,
      leftBarIndicatorColor: MyColor.transparentColor,
      animationDuration: const Duration(seconds: 1),
      borderColor: MyColor.transparentColor,
      reverseAnimationCurve:Curves.easeOut,
      borderWidth: 2,
    );
  }


  static  success({required List<String>successList,int duration=5}){
    String message='';
      if(successList.isEmpty){
        message = MyStrings.somethingWentWrong.tr;
      }else{
        for (var element in successList) {
          String tempMessage = element.tr;
          message = message.isEmpty?tempMessage:"$message\n$tempMessage";
        }
      }
      message = Converter.removeQuotationAndSpecialCharacterFromString(message);
    Get.rawSnackbar(
      progressIndicatorBackgroundColor: MyColor.green,
      progressIndicatorValueColor: AlwaysStoppedAnimation<Color>(MyColor.transparentColor),
      messageText: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 2,),
          Text(message,style: interRegularDefault.copyWith(color: MyColor.colorWhite)),
        ],
      ),
      dismissDirection: DismissDirection.horizontal,
      snackPosition: SnackPosition.BOTTOM,
      titleText: Row(
        children: [
          SvgPicture.asset(MyImages.successIcon,height: 20,width: 20,color: MyColor.colorWhite,),
          const SizedBox(width: 5,),
          Text(MyStrings.success.tr,style: interSemiBoldSmall.copyWith(fontSize: Dimensions.fontLarge, color: MyColor.colorWhite)),
        ],
      ),
      backgroundColor: MyColor.greenSuccessColor,
      borderRadius: 4,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      duration:  Duration(seconds: duration),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeInOutCubicEmphasized,
      showProgressIndicator: true,
      leftBarIndicatorColor: MyColor.transparentColor,
      animationDuration: const Duration(seconds: 2),
      borderColor: MyColor.transparentColor,
      reverseAnimationCurve:Curves.easeOut,
      borderWidth: 2,
    );
  }
}