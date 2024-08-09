import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/style.dart';

class RoundedButton extends StatelessWidget {

  final String text;
  final VoidCallback press;
  final Color color;
  final Color? textColor;
  final double width;
  final double horizontalPadding;
  final double verticalPadding;
  final double cornerRadius;
  final bool isOutlined;
  final Color borderColor;

  const RoundedButton({
    Key? key,
    this.width=1,
    this.cornerRadius=6,
    required this.text,
    required this.press,
    this.isOutlined=false,
    this.horizontalPadding=35,
    this.verticalPadding=18,
    this.color = MyColor.primaryColor,
    this.textColor = MyColor.colorWhite,
    this.borderColor = MyColor.borderColor,
  }):super(key: key) ;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return isOutlined? Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: press,
        splashColor: MyColor.transparentColor,
        child: Container(
            padding:  EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
            width: size.width * width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(cornerRadius),
                border: Border.all(color: borderColor),
                color: Colors.transparent
            ),
            child: Center(child: Text(text.tr,style:TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.w600)))),
      ),
    ): SizedBox(
      width: size.width * width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(0),
        child: ElevatedButton(
          onPressed: press,
          style: ElevatedButton.styleFrom(

              backgroundColor: color,
              shadowColor: MyColor.transparentColor,
              padding:  EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
              textStyle: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.w600)),
          child: Text(
            text.tr,
            maxLines: 1,
            style: interBoldExtraLarge.copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}