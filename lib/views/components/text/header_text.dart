import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/style.dart';

class HeaderText extends StatelessWidget {

  final String text;
  final TextAlign? textAlign;
  final TextStyle textStyle;

  const HeaderText({
    Key? key,
    required this.text,
    this.textAlign,
    this.textStyle = interRegularDefault
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.tr,
      textAlign: textAlign,
      style: textStyle,
    );
  }
}
