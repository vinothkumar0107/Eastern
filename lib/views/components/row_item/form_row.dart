import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/style.dart';

class FormRow extends StatelessWidget {

  final String label;
  final bool isRequired;

  const FormRow({Key? key,
    required this.label,
    required this.isRequired
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(label.tr,style: interSemiBoldLarge.copyWith(color: MyColor.getLabelTextColor(), fontSize: Dimensions.fontDefault)),
        Text(isRequired?' *':'',style: interBoldDefault.copyWith(color: MyColor.red),)
      ],
    );
  }
}
