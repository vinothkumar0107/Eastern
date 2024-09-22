import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/my_images.dart';
import '../../../core/utils/style.dart';
import '../../../core/utils/util.dart';
import '../custom_loader.dart';
class CustomRoundedButton extends StatelessWidget {

  final String labelName;
  final String? svgImage;
  final VoidCallback? press;
  final double verticalPadding;
  final Color buttonColor;
  final Color buttonTextColor;
  final double horizontalPadding;
  final bool isLoading;
  final bool isOutline;
  final Color textColor;
  final double imageSize;
  const CustomRoundedButton({
    super.key,
    required this.labelName,
    this.press,
    this.svgImage,
    this.verticalPadding = 13,
    this.horizontalPadding = 15,
    this.buttonColor = MyColor.primaryColor,
    this.buttonTextColor = MyColor.colorWhite,
    this.isLoading = false,
    this.isOutline = false,
    this.textColor = MyColor.colorWhite,
    this.imageSize = 34
  });

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: press,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: verticalPadding,horizontal: horizontalPadding),
        decoration: BoxDecoration(
          color: isOutline ? MyColor.transparentColor : buttonColor,
          borderRadius: BorderRadius.circular(Dimensions.paddingSize30),
          border: isOutline ? Border.all(color: buttonColor) : null,
          boxShadow: MyUtil.getCardShadow(),
          gradient: const LinearGradient(
            colors: [MyColor.appPrimaryColorSecondary2, MyColor.primaryColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: isLoading ? const CustomLoader(strokeWidth: 2,circularLoader: true,) : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            svgImage != null ?
                SvgPicture.asset(svgImage!, height: imageSize,width: imageSize,color: textColor,) :
            svgImage != null ? const SizedBox(width: Dimensions.space7): const SizedBox.shrink(),
            svgImage != null ? const SizedBox(width: 8,) : const SizedBox.shrink(),
            Text(labelName.tr,style: interMediumLarge.copyWith(color: textColor,fontSize: Dimensions.fontMediumLarge, fontWeight: FontWeight.w600),),
          ],
        ),
      ),
    );
  }
}