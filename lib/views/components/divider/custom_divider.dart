import 'package:flutter/material.dart';
import 'package:eastern_trust/core/utils/my_color.dart';

class CustomDivider extends StatelessWidget {
  final double space;
  final Color? borderColor;
  const CustomDivider({Key? key, this.space = 10,this.borderColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: space),
        Divider(color: borderColor??MyColor.getBorderColor(), height: 0.5, thickness: .5),
        SizedBox(height: space),
      ],
    );
  }
}
