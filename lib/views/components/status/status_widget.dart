import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/style.dart';

class StatusWidget extends StatelessWidget {

  final String status;
  final Color foregroundColor;
  final Color? backgroundColor;
  final Color borderColor;
  final bool needBorder;

  const StatusWidget({
    Key? key,
    required this.status,
    this.foregroundColor = MyColor.primaryColor,
    this.backgroundColor,
    this.borderColor = MyColor.primaryColor,
    this.needBorder = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return needBorder ? Container(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.space5, horizontal: Dimensions.space10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: MyColor.transparentColor,
        borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
        border: Border.all(color: borderColor, width: 0.5)
      ),
      child: Text(status.tr, textAlign: TextAlign.center, style: interRegularExtraSmall.copyWith(color: borderColor)),
    ) : Container(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.space5, horizontal: Dimensions.space10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
      ),
      child: Text(status.tr, textAlign: TextAlign.center, style: interRegularExtraSmall.copyWith(color: foregroundColor)),
    );
  }
}

