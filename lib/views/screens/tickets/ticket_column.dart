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
  final TextStyle? headerTextStyle;
  final TextStyle? bodyTextStyle;
  
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
    this.headerTextStyle,
    this.bodyTextStyle,
    required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignmentEnd?CrossAxisAlignment.end:CrossAxisAlignment.start,
      children: [
       isNeedHeaderBox ?
       Container(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 2, bottom: 2), // Padding inside the border
        decoration: BoxDecoration(
          color: headerColor?.withOpacity(0.2), // Background color
          borderRadius: BorderRadius.circular(20.0), // Border radius
        ),
        child:  header.tr.isNotEmpty ? Text(
          header.tr,
          style: headerTextStyle ?? interRegularDefault.copyWith(color: headerColor, fontSize: 12)) : const SizedBox.shrink(),
      )
        : header.tr.isNotEmpty ? Text(header.tr,style: headerTextStyle ?? interRegularDefault.copyWith(color: headerColor, fontSize: 12)) : const SizedBox.shrink(),
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
          child: body.tr.isNotEmpty ? Text(body.tr,style: bodyTextStyle ?? interRegularDefault.copyWith(color: bodyColor, fontSize: 12)) : const SizedBox.shrink(),
        ) :  body.tr.isNotEmpty ?
          Text(body.tr,style: bodyTextStyle ?? interRegularDefault.copyWith(color: bodyColor, fontSize: 12)) : const SizedBox.shrink(),
        const SizedBox(height: 8)
      ],
    );
  }
}
