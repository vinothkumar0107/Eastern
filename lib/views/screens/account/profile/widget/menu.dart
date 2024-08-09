import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/style.dart';


class Menu extends StatelessWidget {
  final String icon;
  final String label;
  final String value;
  const Menu({Key? key, required this.icon, required this.label, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('this icon${icon} contains svg: ${icon.contains('svg')}');
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 32, width: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: MyColor.getScreenBgColor(), shape: BoxShape.circle),
          child: icon.contains('svg')?
          SvgPicture.asset(
            icon,
            height: 16,
            width: 16,
            color: MyColor.menu_icon_color,
          ):
          Image.asset(
            icon,
            color: MyColor.getPrimaryColor(),
            height: 16, width: 16,
          ),
        ),
        const SizedBox(width: Dimensions.space15),
            Text(
              label,
              style: interMenuMedium.copyWith(color: MyColor.black),
            ),

      ],
    );
  }
}
