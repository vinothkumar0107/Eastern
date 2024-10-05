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
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.space16,vertical: 13),
        height: 45,
        decoration: BoxDecoration(
            color: MyColor.liteGreyColor,
            border:  Border.all(color: MyColor.naturalLight,width: .5),
            borderRadius: BorderRadius.circular(Dimensions.paddingSize25)
        ),
        child: Row(
          children: [

            CachedNetworkImage(
              height: 25,
              width: 25,
              fit: BoxFit.cover,
              imageUrl: image ?? "",
              placeholder: (context, url) => const CustomImageLoader(),
              errorWidget: (context, url, error) => Image.asset(MyImages.tower,width: 25,height: 25,),
            ),
            const SizedBox(width: 14,),
            Expanded(child: Text(title ?? "".tr,style: interRegularLarge.copyWith(color:MyColor.colorBlack),maxLines: 1,overflow: TextOverflow.ellipsis,)),
            !isShowChangeButton?Icon(Icons.expand_more_rounded,color: MyColor.getGreyText(),size: 20,):const SizedBox.shrink(),

            isShowChangeButton ?
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: MyColor.primaryColor
              ),
              child: Text(MyStrings.change.tr,style: interMediumLarge.copyWith(color: MyColor.textColor),),
            ) : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
