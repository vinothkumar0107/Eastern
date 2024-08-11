import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/my_images.dart';
import 'package:eastern_trust/core/utils/util.dart';

import '../../../core/route/route.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/my_strings.dart';
import '../../../core/utils/style.dart';
import '../custom_cash_network_image.dart';
import '../image_loader.dart';
class OperatorWidget extends StatelessWidget {

  final String? title;
  final String? image;
  final bool isShowChangeButton;
  final VoidCallback? onTap;

  const OperatorWidget({
    super.key,
    this.image,
    this.title,
    this.isShowChangeButton = false,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: Dimensions.space60,
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.space20,vertical: 13),
        decoration: BoxDecoration(
            color: MyColor.transparentColor,
            border:  Border.all(color: MyColor.borderColor, width: .9),
            borderRadius: BorderRadius.circular(Dimensions.paddingSize25)
        ),
        child: Row(
          children: [
            Expanded(child: Text(title ?? "".tr,style: interMediumOverLarge.copyWith(color:MyColor.menu_icon_color),maxLines: 1,overflow: TextOverflow.ellipsis,)),

            isShowChangeButton ?
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: MyColor.primaryColor
              ),
              child: Text(MyStrings.change.tr,style: interMediumLarge.copyWith(color: MyColor.menu_icon_color),),
            ) : const SizedBox.shrink(),
            const Icon(Icons.expand_more_rounded,color: MyColor.menu_icon_color,size: 20,)
          ],
        ),
      ),
    );
  }
}
