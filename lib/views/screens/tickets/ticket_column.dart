import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/style.dart';

class TicketColumn extends StatelessWidget {
  
  final String header;
  final String body;
  final bool alignmentEnd;
  final bool isDate;
  final Color? textColor;
  final bool isNeedBox;
  final bool isNeedHeaderBox;
  final bool isNeedBodyBox;
  final Color? headerColor;
  final Color? bodyColor;
  
  const TicketColumn({Key? key,
    this.alignmentEnd=false,
    required this.header,
    this.isDate = false,
    this.textColor,
    this.isNeedBox = false,
    required this.isNeedHeaderBox,
    required this.isNeedBodyBox,
    this.headerColor,
    this.bodyColor,
    required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignmentEnd?CrossAxisAlignment.end:CrossAxisAlignment.start,
      children: [
       isNeedHeaderBox ?
       Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 1, bottom: 1), // Padding inside the border
        decoration: BoxDecoration(
          color: headerColor?.withOpacity(0.2), // Background color
          border: Border.all(
            color: headerColor ?? MyColor.colorBlack, // Border color
            width: 1.0, // Border width
          ),
          borderRadius: BorderRadius.circular(6.0), // Border radius
        ),
        child: Text(
          header.tr,
          style: isDate?interRegularDefault.copyWith(color:headerColor??
          MyColor.red,fontSize: Dimensions.fontSmall12):
          interRegularDefault.copyWith(color:headerColor??MyColor.primaryColor, fontSize: Dimensions.fontSmall12 )),
      )
        : Text(header.tr,style: isDate?interRegularDefault.copyWith(color:textColor??
          MyColor.red,fontSize: Dimensions.fontLarge):
      interRegularDefault.copyWith(color:textColor??MyColor.primaryColor, fontSize: Dimensions.fontLarge )),
        // Text(header.tr,style: interRegularSmall.copyWith(color: MyColor.getGreyText(),fontWeight: FontWeight.w600),overflow: TextOverflow.ellipsis,),
        const SizedBox(height: 8,),
        isNeedBodyBox ?
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 1, bottom: 1), // Padding inside the border
          decoration: BoxDecoration(
            color: bodyColor?.withOpacity(0.2), // Background color
            border: Border.all(
              color: bodyColor ?? MyColor.colorBlack, // Border color
              width: 1.0, // Border width
            ),
            borderRadius: BorderRadius.circular(6.0), // Border radius
          ),
          child: Text(body.tr,style: isDate?interRegularDefault.copyWith(
              color: bodyColor??
                  MyColor.smallTextColor1,fontSize: Dimensions.fontSmall12):interRegularDefault.copyWith(color:bodyColor??MyColor.smallTextColor1, fontSize: Dimensions.fontSmall12 )),
        ) :
        Text(body.tr,style: isDate?interRegularDefault.copyWith(
            color: MyColor.colorGrey??
            MyColor.smallTextColor1,fontSize: Dimensions.fontSmall12):interRegularDefault.copyWith(color:textColor??MyColor.smallTextColor1, fontSize: Dimensions.fontDefault )),

      ],
    );
  }
}
