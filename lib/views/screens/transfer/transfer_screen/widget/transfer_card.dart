
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/core/utils/util.dart';

class TransferCard extends StatelessWidget {

  const TransferCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.press,
    this.isSelected = false
  }) : super(key: key);

  final String icon;
  final String title;
  final VoidCallback press;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal:Dimensions.space15,vertical: Dimensions.space25),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected? MyColor.primaryColor : MyColor.colorWhite,
          borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
          border: Border.all(color: isSelected? MyColor.primaryColor : MyColor.colorWhite),
          boxShadow: MyUtil.getCardShadow()
        ),
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 35, width: 35,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(Dimensions.space10 / 5),
                decoration:  BoxDecoration(
                    color: isSelected? MyColor.colorWhite:MyColor.primaryColor , shape: BoxShape.circle
                ),
                child: SvgPicture.asset(icon, color: isSelected? MyColor.primaryColor : MyColor.colorWhite, height: 17.5, width: 17.5,fit: BoxFit.cover,)
            ),
            const SizedBox(height: Dimensions.space15),
            Text(title.tr, textAlign: TextAlign.center,style: interRegularSmall.copyWith(color: isSelected?  MyColor.colorWhite:MyColor.titleColor,fontSize: Dimensions.fontDefault,fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
