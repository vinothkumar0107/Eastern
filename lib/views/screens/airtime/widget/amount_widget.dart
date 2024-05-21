import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';

import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/style.dart';
import '../../../../data/services/api_service.dart';
class AmountWidget extends StatelessWidget {

  final String amount;
  final String? description;
  final VoidCallback? onTap;
  final bool selectedAmount;
  final String currency;

  const AmountWidget({
    super.key,
    required this.amount,
    this.description,
    this.onTap,
    required this.selectedAmount,
    required this.currency
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        // width: 150,
        margin: const EdgeInsetsDirectional.only(end: 10),
        padding: const EdgeInsets.symmetric(horizontal: 13,vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: MyColor.primaryColor.withOpacity(.7)),
            color: selectedAmount ? MyColor.primaryColor.withOpacity(.8) : null
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("$amount $currency",textAlign:TextAlign.center,style: interMediumDefault.copyWith(
                fontSize: 14,
                fontWeight:  FontWeight.w600 ,
                color: selectedAmount ? MyColor.colorWhite : MyColor.primaryColor),
            ),
            description == null ?  const SizedBox.shrink() :
            AutoSizeText("$description",textAlign:TextAlign.center,maxLines:4,minFontSize:7,maxFontSize: Dimensions.fontDefault,style: interRegularDefault.copyWith(color: selectedAmount ? MyColor.colorWhite : null),),
          ],
        ),
      ),
    );
  }
}
