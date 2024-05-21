import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/style.dart';

class LabelColumn extends StatelessWidget {
  final String header;
  final String body;
  final bool alignmentEnd;
  final bool lastTextRed;
  final bool isSmallFont;
  const LabelColumn({Key? key,this.isSmallFont = false,this.lastTextRed = false,this.alignmentEnd=false,required this.header,required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignmentEnd?CrossAxisAlignment.end:CrossAxisAlignment.start,
      children: [
        Text(header.tr,style: interLightDefault.copyWith(fontSize:isSmallFont?Dimensions.fontSmall:Dimensions.fontDefault,color: MyColor.getBodyTextColor()),overflow: TextOverflow.ellipsis,),
        const SizedBox(height: 5,),
        Text(body.tr,style: lastTextRed?interRegularDefault.copyWith(fontSize:isSmallFont?Dimensions.fontSmall:Dimensions.fontDefault,color: MyColor.redCancelTextColor):interRegularDefault.copyWith(fontSize:isSmallFont?Dimensions.fontSmall:Dimensions.fontDefault,),overflow: TextOverflow.ellipsis,)
      ],
    );
  }
}
