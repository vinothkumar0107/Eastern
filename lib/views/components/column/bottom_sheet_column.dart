import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/style.dart';
import '../../../../../../../core/utils/my_color.dart';

class BottomSheetColumn extends StatelessWidget {

  final bool isCharge;
  final String header;
  final String body;
  final bool alignmentEnd;
  const BottomSheetColumn({Key? key,this.isCharge = false,this.alignmentEnd=false,required this.header,required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignmentEnd?CrossAxisAlignment.end:CrossAxisAlignment.start,
      children: [
        Text(header.tr,style: interLightDefault.copyWith(color: MyColor.getBodyTextColor()),overflow: TextOverflow.ellipsis,),
        const SizedBox(height: 5,),
        Text(body.tr,style: isCharge?interRegularDefault.copyWith(color: MyColor.redCancelTextColor):interRegularLarge,overflow: TextOverflow.ellipsis,)
      ],
    );
  }
}
