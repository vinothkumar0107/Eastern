import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/style.dart';

import '../../../../../core/utils/my_strings.dart';

class CountryTextField extends StatelessWidget {

  final String text;
  final VoidCallback press;
  final bool allBorder;

  const CountryTextField({Key? key,
    required this.text,
    required this.press,
    this.allBorder = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: Dimensions.space15,horizontal: allBorder ? 15 : 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.paddingSize25),
          color: MyColor.liteGreyColor,
          border: allBorder ? Border.all(color: MyColor.liteGreyColor,width: 1) : const Border(bottom:BorderSide(color: MyColor.borderColor))
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              Text(text.tr,style: interMediumLarge.copyWith(color: text == MyStrings.selectACountry.tr ? MyColor.colorGrey : MyColor.colorBlack),),
              const Icon(Icons.expand_more_rounded,color: MyColor.colorBlack,size: 20,)
            ],
          ),
      ),
    );
  }
}
