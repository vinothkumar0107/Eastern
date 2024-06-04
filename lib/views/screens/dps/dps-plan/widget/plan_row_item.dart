import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_images.dart';
import 'package:eastern_trust/core/utils/style.dart';

class PlanRow extends StatelessWidget {

  final String firstText, secondText;
  final double space;

  const PlanRow({
    Key? key,
    required this.firstText,
    required this.secondText,
    this.space = 12
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(MyImages.check, height: 15, width: 15,color: MyColor.green,),
                const SizedBox(width: Dimensions.space10),
                Text(firstText.tr, style: interRegularDefault.copyWith(color: MyColor.colorBlack)),
              ],
            ),
            Flexible(child: Text(secondText.tr, overflow:TextOverflow.ellipsis,style: interRegularDefault.copyWith(color:MyColor.colorBlack,fontWeight: FontWeight.w500))),
          ],
        ),
        SizedBox(height: space)
      ],
    );
  }
}
