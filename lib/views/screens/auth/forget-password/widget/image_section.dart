import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_images.dart';

class ImageSection extends StatelessWidget {
  const ImageSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90, width: 90,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(Dimensions.space5),
      decoration: BoxDecoration(
          color: MyColor.containerBgColor,
          shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(20)
      ),
      child: Container(
        height: 75, width: 75,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(Dimensions.space5),
        decoration: BoxDecoration(
            color: MyColor.imageContainerBg,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20)
        ),
        child: SvgPicture.asset(MyImages.forgotPassword, height: 37.5, width: 37.5),
      ),
    );
  }
}
