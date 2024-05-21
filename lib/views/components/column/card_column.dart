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
  
  const CardColumn({Key? key,
    this.alignmentEnd=false,
    required this.header,
    this.isDate = false,
    this.textColor,
    required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignmentEnd?CrossAxisAlignment.end:CrossAxisAlignment.start,
      children: [
        Text(header.tr,style: interRegularSmall.copyWith(color: MyColor.getGreyText(),fontWeight: FontWeight.w600),overflow: TextOverflow.ellipsis,),
        const SizedBox(height: 8,),
        Text(body.tr,style: isDate?interRegularDefault.copyWith(fontStyle: FontStyle.italic,color:textColor??MyColor.smallTextColor1,fontSize: Dimensions.fontSmall):interRegularDefault.copyWith(color:textColor??MyColor.smallTextColor1 ))
      ],
    );
  }
}
