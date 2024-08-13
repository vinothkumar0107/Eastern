import 'package:flutter/material.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/util.dart';
import 'tab_widget.dart';

class TabContainer extends StatelessWidget {

  final String firstText;
  final String secondText;
  final VoidCallback firstTabPress;
  final VoidCallback secondTabPress;
  final bool isFirstSelected;

  const TabContainer({Key? key,
    this.isFirstSelected = true,
    required this.secondText,
    required this.firstTabPress,
    required this.secondTabPress,
    required this.firstText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: Dimensions.space7,vertical: Dimensions.space5),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.space30),
        color: MyColor.liteGreyColorBorder,
        boxShadow: MyUtil.getBottomSheetShadow()
      ),
      child: Row(
        children: [

          Expanded(child: PlanTabBar(
              text:firstText,
              isActive: isFirstSelected,
              press: firstTabPress)),

          Expanded(child: PlanTabBar(
              text: secondText,
              isActive: !isFirstSelected,
              press: secondTabPress)),
        ],
      ),
    );
  }
}
