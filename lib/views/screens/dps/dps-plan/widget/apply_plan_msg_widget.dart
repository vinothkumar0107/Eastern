import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/views/components/divider/custom_divider.dart';

class ApplyPlanMsgWidget extends StatefulWidget {
  const ApplyPlanMsgWidget({Key? key}) : super(key: key);

  @override
  State<ApplyPlanMsgWidget> createState() => _ApplyPlanMsgWidgetState();
}

class _ApplyPlanMsgWidgetState extends State<ApplyPlanMsgWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        const CustomDivider(space:20),
        Text(MyStrings.applyPlanMsg.tr,style: interRegularDefault.copyWith(fontSize: Dimensions.fontLarge),),
        const CustomDivider(space:20),
      ],
    );
  }
}
