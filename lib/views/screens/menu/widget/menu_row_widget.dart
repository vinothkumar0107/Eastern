import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/views/components/text/default_text.dart';

class MenuRowWidget extends StatelessWidget {

  final String image;
  final String label;
  final VoidCallback onPressed;
  final String? number;
  final bool isLoading;

  const MenuRowWidget({
    Key? key,
    required this.image,
    required this.label,
    required this.onPressed,
    this.number,
    this.isLoading = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: isLoading?const Center(child: SizedBox(
          height:20,
          width:20,
          child: CircularProgressIndicator(color: MyColor.primaryColor,))):Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              image.isEmpty?const SizedBox.shrink():
              image.contains('svg')?
              SvgPicture.asset(image, color: MyColor.getTextColor2(), height: 15, width: 15,fit: BoxFit.cover):
              Image.asset(image, color: MyColor.getTextColor2(), height: 15, width: 15,fit: BoxFit.cover,),
              image.isEmpty?const SizedBox.shrink():const SizedBox(width: Dimensions.space15),
              DefaultText(text: label, textColor: MyColor.getTextColor())
            ],
          ),
          image.isEmpty?DefaultText(text: number.toString()):Container(
            alignment: Alignment.center,
            height: 30, width: 30,
            decoration: BoxDecoration(color: MyColor.transparentColor, shape: BoxShape.circle),
            child: Icon(Icons.arrow_forward_ios_rounded, color: MyColor.getTextColor2(), size: 15),
          )
        ],
      ),
    );
  }
}
