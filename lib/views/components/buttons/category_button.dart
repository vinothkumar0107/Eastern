import 'package:flutter/material.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/style.dart';

class CategoryButton extends StatelessWidget {

  final String text;
  final VoidCallback press;
  final Color color, textColor;
  final double horizontalPadding;
  final double verticalPadding;
  final double textSize;

  const CategoryButton({
    Key? key,
    required this.text,
    this.horizontalPadding=3,
    this.verticalPadding=3,
    this.textSize = Dimensions.fontExtraSmall,
    required this.press,
    this.color = MyColor.primaryColor,
    this.textColor = Colors.white,
  }):super(key: key) ;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      borderRadius: BorderRadius.circular(4),
      child:  Container(
        alignment: Alignment.center,
        padding:  EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: MyColor.containerBgColor.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0,0),
            ),
          ]
        ),
        child: Text(
          text,
          style: interRegularDefault.copyWith(color: textColor,fontWeight: FontWeight.w500),
        ),
      ),
    );
  }



}