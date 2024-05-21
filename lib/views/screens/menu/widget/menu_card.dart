import 'package:flutter/material.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';

class MenuCard extends StatelessWidget {
  final Widget child;
  const MenuCard({Key? key,required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
    width: MediaQuery.of(context).size.width,
    padding: const EdgeInsets.all(Dimensions.space15),
    decoration: BoxDecoration(
      color: MyColor.getCardBg(),
      borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
    child: child,
    );
  }
}
