import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/views/components/buttons/custom_circle_animated_button.dart';
import 'package:eastern_trust/views/components/widget-divider/widget_divider.dart';

class BottomSheetTopRow extends StatelessWidget {
  final String header;
  final double bottomSpace;
  final Color bgColor;
  const BottomSheetTopRow({
    Key? key,
    required this.header,
    this.bottomSpace = 10,
    this.bgColor = MyColor.containerBgColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(header.tr, style: interRegularLarge.copyWith(fontWeight: FontWeight.w600)),
            CustomCircleAnimatedButton(
              press: (){
                Get.back();
              },
              height: 30,
              width: 30,
              backgroundColor: bgColor,
              child: const Icon(Icons.clear, color: MyColor.colorBlack, size: 15),
            )
          ],
        ),
        WidgetDivider(
          lineColor: Colors.transparent,
          space: bottomSpace,
        ),
      ],
    );
  }
}
