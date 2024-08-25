import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/style.dart';

class PreviewRow extends StatelessWidget {

  final String firstText,secondText;
  final bool showDivider;

  const PreviewRow({
    Key? key,
    required this.firstText,
    required this.secondText,
    this.showDivider = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(firstText.tr,style: interMediumDefault.copyWith(fontSize: Dimensions.fontDefault,color:  MyColor.colorBlack)),
            Text(secondText.tr,style: interMediumDefault.copyWith(fontSize: Dimensions.fontSmall12,color:  MyColor.colorBlack))
          ],
        ),
        const SizedBox(height: 15),
        Visibility(
          visible: showDivider,
          child: Divider(height:.5,color: MyColor.getBorderColor(),),),
        Visibility(
          visible: showDivider,
          child: const SizedBox(height: 15),),
      ],
    );
  }
}
