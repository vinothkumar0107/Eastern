import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/style.dart';

class CardTopItem extends StatelessWidget {

 final String imageName;
 final String title;
 final String subText;

  const CardTopItem({
    Key? key,
    required this.imageName,
    required this.title,
    required this.subText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(

      padding: const EdgeInsets.only(bottom: Dimensions.space10, top: Dimensions.space10),
      child: Row(
        children: [
          Container(
              height: 35, width: 35,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(Dimensions.space10 / 5),
              decoration: const BoxDecoration(
                color: MyColor.containerBgColor, shape: BoxShape.circle
              ),
              child: SvgPicture.asset(imageName, color: MyColor.primaryColor, height: 17.5, width: 17.5)
          ),
          const SizedBox(width: Dimensions.space10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title.tr, style: interRegularSmall.copyWith(color: MyColor.smallTextColor1)),
              const SizedBox(height: Dimensions.space5),
              Text(subText.tr, style: interRegularSmall.copyWith(color: MyColor.titleColor))
            ],
          )
        ],
      ),
    );
  }
}
