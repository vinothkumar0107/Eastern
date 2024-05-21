import 'package:flutter/material.dart';
import 'package:eastern_trust/core/utils/my_color.dart';

class RoundedLoadingBtn extends StatelessWidget {
  final Color? textColor;
  final double width;
  final double horizontalPadding;
  final double verticalPadding;
  final double cornerRadius;
  const RoundedLoadingBtn({
    Key? key,
    this.width=1,
    this.cornerRadius=8,
    this.horizontalPadding=5,
    this.verticalPadding=8,
    this.textColor = MyColor.colorWhite,
  }):super(key: key) ;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(cornerRadius),
        child: ElevatedButton(
          onPressed: (){},
          style: ElevatedButton.styleFrom(
              backgroundColor: MyColor.primaryColor,
              shadowColor: MyColor.transparentColor,
              padding:  EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding-3),
              textStyle: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.w500)),
          child: const SizedBox(width:20, height:20, child: CircularProgressIndicator(color: MyColor.colorWhite, strokeWidth: 2)),
        ),
      ),
    );
  }

}
