import 'dart:convert';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/helper/string_format_helper.dart';
import '../../../core/utils/my_images.dart';
import '../../../core/utils/my_strings.dart';
import '../../../core/utils/style.dart';
import '../buttons/rounded_button.dart';

void showCustomBottomSheetNotification({
  required BuildContext context,
  required String icon, // Could pass Icons.check_circle_outline or others
  required String title,
  required List<String>successList,
  required String buttonText,
  required VoidCallback onButtonPressed,
}) {

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


  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
    ),
    backgroundColor: Colors.white,
    isDismissible: false,
    enableDrag: false,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SvgPicture.asset(icon, height: 60, width: 60),
            const SizedBox(height: 15),
            Text(
              title,
              style: interSemiBoldLarge.copyWith(
                color: MyColor.colorBlack,
                fontSize: Dimensions.fontHeader1,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              message,
              style: interMediumDefault.copyWith(
                color: MyColor.getGreyText(),
                fontSize: Dimensions.fontLarge,
              ),
            ),
            const SizedBox(height: 25),
            RoundedButton(
              press: onButtonPressed, // Use the callback provided
              text: buttonText,
              textColor: MyColor.colorWhite,
              color: MyColor.appPrimaryColorSecondary2,
            ),
            const SizedBox(height: 10),
          ],
        ),
      );
    },
  );
}
