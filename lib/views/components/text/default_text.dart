import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/style.dart';

class DefaultText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final TextStyle textStyle;
  final int maxLines;
  final Color? textColor;
  final double fontSize;

  const DefaultText({
    Key? key,
    required this.text,
    this.textAlign,
    this.textStyle = interRegularDefault,
    this.maxLines = 2,
    this.textColor,
    this.fontSize = Dimensions.fontDefault
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.tr,
      textAlign: textAlign,
      style: textStyle.copyWith(color: textColor,fontSize: fontSize),
      maxLines: maxLines,
    );
  }
}
