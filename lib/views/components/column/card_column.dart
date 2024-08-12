import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/style.dart';

class CardColumn extends StatelessWidget {
  
  final String header;
  final String body;
  final bool alignmentEnd;
  final bool isDate;
  final Color? textColor;
  final TextAlign? textAlignment;
  
  const CardColumn({Key? key,
    this.alignmentEnd=false,
    required this.header,
    this.isDate = false,
    this.textColor,
    this.textAlignment,
    required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignmentEnd?CrossAxisAlignment.end:CrossAxisAlignment.start,
      children: [
        header.tr.isNotEmpty ? Text(header.tr,style: isDate?interMediumDefault.copyWith(color:textColor??MyColor.smallTextColor1,fontSize: Dimensions.fontSize14, fontWeight: FontWeight.w600):interMediumDefault.copyWith(color:textColor??MyColor.smallTextColor1, fontSize: Dimensions.fontSize14, fontWeight: FontWeight.w600 )) : const SizedBox.shrink(),
        const SizedBox(height: 5,),
        body.tr.isNotEmpty ? Text(body.tr,textAlign: textAlignment, style: isDate?interRegularSmall.copyWith(color:textColor??MyColor.smallTextColor1,fontSize: Dimensions.fontSmall12, fontWeight: FontWeight.w400):interRegularSmall.copyWith(color:textColor??MyColor.smallTextColor1, fontSize: Dimensions.fontSmall12, fontWeight: FontWeight.w400 )) : const SizedBox.shrink()
      ],
    );
  }
}
