import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/core/utils/url.dart';
import 'package:eastern_trust/data/controller/home/home_controller.dart';
import 'package:eastern_trust/views/components/circle_widget/circle_image_button.dart';

import 'balance_animated_app_bar.dart';

class HomeScreenTop extends StatefulWidget {
  const HomeScreenTop({Key? key}) : super(key: key);

  @override
  State<HomeScreenTop> createState() => _HomeScreenTopState();
}

class _HomeScreenTopState extends State<HomeScreenTop> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 8,
                child: GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.profileScreen);
                  },
                  child: Row(
                    children: [
                      CircleImageWidget(
                        height:40,
                        width:40,
                        isProfile:true,
                        isAsset: false,
                        imagePath: '${UrlContainer.domainUrl}/assets/images/user/profile/${controller.imagePath}',
                        press: (){
                           Get.toNamed(RouteHelper.profileScreen);
                        },),
                      const SizedBox(width: Dimensions.space15),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(controller.username, overflow:TextOverflow.ellipsis,textAlign: TextAlign.left, style: interRegularLarge.copyWith(color: MyColor.colorWhite, fontWeight: FontWeight.w500)),
                            const SizedBox(height: Dimensions.space5),
                            Text(controller.accountNumber, overflow:TextOverflow.ellipsis,textAlign: TextAlign.left, style: interRegularSmall.copyWith(fontSize:Dimensions.fontExtraSmall+1,color: MyColor.colorWhite.withOpacity(.8))),
                            const SizedBox(height: Dimensions.space5),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Spacer(),
              SizedBox(width:120,child: BalanceAnimationContainer(amount: controller.balance,curSymbol: controller.currencySymbol,)),
            ],
          ),
        ],
      ),
    );
  }
}