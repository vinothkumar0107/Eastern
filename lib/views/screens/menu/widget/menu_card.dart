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
      borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1), // Shadow color
          spreadRadius: 0, // Spread radius
          blurRadius: 5, // Blur radius
          offset: const Offset(0, 2), // Shadow offset
        ),
      ],
    ),
    child: child,
    );
  }
}
