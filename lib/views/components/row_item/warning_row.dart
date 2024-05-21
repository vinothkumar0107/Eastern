import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';

import '../../../core/utils/style.dart';

class WarningRow extends StatelessWidget {

  final String text;
  final IconData icon;
  final Color  iconColor;
  final Color textColor;
  final double textSize;
  final double iconSize;
  final double topMargin;
  final double iconSpace;

  const WarningRow({
    Key? key,
    required this.text,
    this.icon = Icons.info_outline,
    this.iconColor = MyColor.redCancelTextColor,
    this.iconSize = 12,
    this.textColor = MyColor.redCancelTextColor,
    this.textSize = Dimensions.fontSmall,
    this.topMargin = 7,
    this.iconSpace = 5
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: topMargin),
        Row(
          children: [
            Icon(Icons.info_outline,color: iconColor,size: iconSize),
            SizedBox(width: iconSpace),
            Text(text.tr,style: interRegularDefault.copyWith(color: textColor,fontSize: textSize),),
          ],
        ),
      ],
    );
  }
}
