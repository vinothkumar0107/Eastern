import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/data/controller/home/home_controller.dart';
import 'package:eastern_trust/views/components/text/label_text1.dart';

class LatestTransaction extends StatelessWidget {
  const LatestTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller)=>Container(
      margin: const EdgeInsets.only(bottom: Dimensions.space25),
      alignment: Alignment.topLeft,
      child: LabelText1(text: MyStrings.latestTransaction.tr),
    ));
  }
}
