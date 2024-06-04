import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/style.dart';

class InfoItem extends StatelessWidget {

  final String firstText,lastText;
  final String icon;
  final bool isShowDivider;

  const InfoItem({Key? key,
    required this.firstText,
    required this.lastText,
    required this.icon,
    this.isShowDivider = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: Dimensions.space10, top: Dimensions.space10),
          child: Row(
            children: [
              Container(
                height: 40, width: 40,
                padding: const EdgeInsets.all(Dimensions.space5),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: MyColor.containerBgColor,
                    shape: BoxShape.circle
                ),
                child: SvgPicture.asset(icon, color: MyColor.primaryColor, height: 20, width: 20),
              ),
              const SizedBox(width: Dimensions.space10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(firstText.tr, style: interRegularSmall.copyWith(color: MyColor.smallTextColor1)),
                  Text(lastText.tr, style: interRegularSmall.copyWith(color: MyColor.titleColor)),
                ],
              )
            ],
          ),
        ),
        Visibility(
          visible: isShowDivider,
          child: const Divider(color: MyColor.lineColor, height: 0.5, thickness: 1))
      ],
    );
  }
}
