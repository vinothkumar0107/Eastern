
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:eastern_trust/data/controller/menu_/menu_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/views/components/buttons/rounded_button.dart';
import 'package:eastern_trust/data/controller/menu_/menu_controller.dart' as menu;

import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/style.dart';



  showExitDialog(BuildContext context){
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      dialogBackgroundColor: MyColor.getCardBg(),
      width: 300,
      buttonsBorderRadius: const BorderRadius.all(
        Radius.circular(2),
      ),
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: true,
      onDismissCallback: (type) {},
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: MyStrings.exitTitle.tr,
      titleTextStyle:interRegularDefault.copyWith(color: MyColor.getTextColor(),fontSize: Dimensions.fontLarge),
      showCloseIcon: false,
      btnCancel: RoundedButton(text: MyStrings.no.tr, press: (){
        Navigator.pop(context);
      },horizontalPadding: 3,verticalPadding: 3,color: MyColor.primaryColor2,),
      btnOk:
      RoundedButton(text: MyStrings.yes.tr, press: (){
        SystemNavigator.pop();
      },horizontalPadding: 3,verticalPadding: 3,color: MyColor.red,textColor: MyColor.colorWhite,),
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        SystemNavigator.pop();
      },
    ).show();
  }

deleteAccountDialog(BuildContext context, menu.MenuController menuController){
  AwesomeDialog(
    context: context,
    dialogType: DialogType.noHeader,
    dialogBackgroundColor: MyColor.getCardBg(),
    width: 300,
    buttonsBorderRadius: const BorderRadius.all(
      Radius.circular(2),
    ),
    dismissOnTouchOutside: true,
    dismissOnBackKeyPress: true,
    onDismissCallback: (type) {},
    headerAnimationLoop: false,
    animType: AnimType.bottomSlide,
    title: MyStrings.deleteTitle.tr,
    titleTextStyle:interRegularDefault.copyWith(color: MyColor.getTextColor(),fontSize: Dimensions.fontLarge),
    showCloseIcon: false,
    btnCancel: RoundedButton(text: MyStrings.no.tr, press: (){
      Navigator.pop(context);
    },horizontalPadding: 3,verticalPadding: 3,color: MyColor.primaryColor2,),
    btnOk:
    RoundedButton(text: MyStrings.yes.tr, press: (){
      menuController.deleteAccount();
      // SystemNavigator.pop();
    },horizontalPadding: 3,verticalPadding: 3,color: MyColor.red,textColor: MyColor.colorWhite,),
    btnCancelOnPress: () {},
    btnOkOnPress: () {
      SystemNavigator.pop();
    },
  ).show();
}
