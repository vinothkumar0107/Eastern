import 'package:flutter/material.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';

class WidgetDivider extends StatelessWidget {

  final double space;
  final Color? lineColor;

  const WidgetDivider({
    Key? key,
    this.lineColor,
    this.space = Dimensions.space20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(

      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: space),
        Divider(color: lineColor ?? MyColor.getBorderColor(), height: 0.5, thickness: 1),
        SizedBox(height: space),
      ],
    );
  }
}
