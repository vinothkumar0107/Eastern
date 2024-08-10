import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/style.dart';

class BottomSectionRegistration extends StatelessWidget {
  const BottomSectionRegistration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(MyStrings.alreadyAccount.tr, style: interMediumLarge.copyWith(color: MyColor.colorBlack,decorationColor:MyColor.colorGrey,decoration: TextDecoration.none)),
        TextButton(
          onPressed: () {
            Get.offAndToNamed(RouteHelper.loginScreen);
          },
          child: Text(
            MyStrings.signInNow.tr,
            style: interBoldLarge.copyWith(color: MyColor.appPrimaryColorSecondary2, decoration: TextDecoration.underline),
          ),
        )
      ],
    );
  }
}
