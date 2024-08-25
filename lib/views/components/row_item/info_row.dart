import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/style.dart';

class InfoRow extends StatelessWidget {
  final String text;
  final double iconSize;
  final Color textColor;
  const InfoRow({
    Key? key,
    required this.text,
    this.iconSize = 18,
    this.textColor = MyColor.colorGrey2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Icon(Icons.info_outline,size: iconSize,color: MyColor.primaryColor,),
        const SizedBox(width: 5,),
        Text(text.tr, style:interSemiBold.copyWith(fontSize:Dimensions.fontDefault,color: textColor,)
        ),
      ],
    );
  }
}
