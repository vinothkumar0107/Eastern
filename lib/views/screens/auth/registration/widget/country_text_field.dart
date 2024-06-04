import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/style.dart';

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
        padding: EdgeInsets.symmetric(vertical: Dimensions.space15,horizontal: allBorder ? 10 : 0),
        decoration: BoxDecoration(
          color: MyColor.transparentColor,
          border: allBorder ? Border.all(color: MyColor.naturalLight,width: .5) : const Border(bottom:BorderSide(color: MyColor.borderColor))
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              Text(text.tr,style: interRegularDefault.copyWith(color: MyColor.colorWhite),),
              Icon(Icons.expand_more_rounded,color: MyColor.colorWhite,size: 20,)
            ],
          ),
      ),
    );
  }
}
