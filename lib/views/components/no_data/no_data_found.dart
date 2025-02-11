import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_images.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';

class NoDataWidget extends StatelessWidget {

  final double topMargin;
  final double bottomMargin;
  final String title;
  final double imageHeight;
  final bool isNeedHeight;
  final double fontSize;

  const NoDataWidget({Key? key,
    this.topMargin = 0,
    this.title = MyStrings.noDataFound,
    this.imageHeight = 100,
    this.isNeedHeight = false,
    this.bottomMargin = 0,
    this.fontSize = Dimensions.fontDefault,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isNeedHeight ? SizedBox(
      height: MediaQuery.of(context).size.height*0.5,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: topMargin,),
            SvgPicture.asset(
                MyImages.noDataImage,
                height: imageHeight,
                width: 100,
                color: MyColor.getUnselectedIconColor()
            ),
            const SizedBox(height: Dimensions.space20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: interRegularDefault.copyWith(color: MyColor.getTextColor().withOpacity(.6), fontSize: fontSize),
            )
          ],
        ),
      ),
    ):Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: topMargin,),
          SvgPicture.asset(
              MyImages.noDataImage,
              height: 100,
              width: 100,
              color: MyColor.getUnselectedIconColor()
          ),
          const SizedBox(height: Dimensions.space20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: interRegularDefault.copyWith(color: MyColor.getTextColor().withOpacity(.6), fontSize: Dimensions.fontDefault),
          )
        ],
      ),
    );
  }
}
