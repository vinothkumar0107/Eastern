import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/style.dart';

class BottomSection extends StatelessWidget {
  const BottomSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(MyStrings.doNotHaveAccount.tr, style: interSemiBoldDefault.copyWith(color: MyColor.colorBlack,decorationColor:MyColor.colorGrey,decoration: TextDecoration.none)),
        TextButton(
          onPressed: () {
            Get.offAndToNamed(RouteHelper.registrationScreen);
          },
          child: Text(
            MyStrings.createNew.tr,
            style: interSemiBoldLarge.copyWith(
                color: MyColor.appPrimaryColorSecondary2,
                decorationColor: MyColor.appPrimaryColorSecondary2,
                decoration: TextDecoration.none
            ),
          ),
        )
      ],
    );
  }
}

