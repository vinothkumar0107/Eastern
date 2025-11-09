import 'package:eastern_trust/views/screens/home/widget/top_buttons.dart';
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

class _HomeScreenTopState123 extends State<HomeScreenTop> {

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
                        height:60,
                        width:60,
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
                            Text(controller.username, overflow:TextOverflow.ellipsis,textAlign: TextAlign.left, style: interRegularLarge.copyWith(color: MyColor.colorWhite, fontWeight: FontWeight.w800, fontSize: Dimensions.fontExtraLarge)),
                            const SizedBox(height: Dimensions.space5),
                            Text(controller.accountNumber, overflow:TextOverflow.ellipsis,textAlign: TextAlign.left, style: interRegularSmall.copyWith(fontSize:Dimensions.fontExtraSmall+3,fontWeight: FontWeight.w800, color: MyColor.colorWhite.withOpacity(.8))),
                            const SizedBox(height: Dimensions.space5),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: Dimensions.space10),
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(width:120,child: BalanceAnimationContainer(amount: controller.balance,curSymbol: controller.currencySymbol))
                    ],
                  )

                ],
              ),
              IconButton(
                icon: const Icon(Icons.notifications_none_sharp, color: Colors.white),
                onPressed: () {
                  Get.toNamed(RouteHelper.notificationScreen);
                },
              ),
            ],
          ),
          const SizedBox(height: Dimensions.space30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: controller.homeTopModuleList
                .map((widget) => Expanded(child: widget))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _HomeScreenTopState extends State<HomeScreenTop> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        final modules = controller.homeTopModuleList;

        return Column(
          children: [
            // --- Top section (profile + balance + notification)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 8,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.profileScreen);
                    },
                    child: Row(
                      children: [
                        CircleImageWidget(
                          height: 60,
                          width: 60,
                          isProfile: true,
                          isAsset: false,
                          imagePath:
                          '${UrlContainer.domainUrl}/assets/images/user/profile/${controller.imagePath}',
                          press: () {
                            Get.toNamed(RouteHelper.profileScreen);
                          },
                        ),
                        const SizedBox(width: Dimensions.space15),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.username,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: interRegularLarge.copyWith(
                                  color: MyColor.colorWhite,
                                  fontWeight: FontWeight.w800,
                                  fontSize: Dimensions.fontExtraLarge,
                                ),
                              ),
                              const SizedBox(height: Dimensions.space5),
                              Text(
                                controller.accountNumber,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: interRegularSmall.copyWith(
                                  fontSize:
                                  Dimensions.fontExtraSmall + 3,
                                  fontWeight: FontWeight.w800,
                                  color:
                                  MyColor.colorWhite.withOpacity(.8),
                                ),
                              ),
                              const SizedBox(height: Dimensions.space5),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: Dimensions.space10),
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 120,
                          child: BalanceAnimationContainer(
                            amount: controller.balance,
                            curSymbol: controller.currencySymbol,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.notifications_none_sharp,
                      color: Colors.white),
                  onPressed: () {
                    Get.toNamed(RouteHelper.notificationScreen);
                  },
                ),
              ],
            ),

            // --- Show modules only if available
            if (modules.isNotEmpty) ...[
              const SizedBox(height: Dimensions.space30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                modules.map((w) => Expanded(child: w)).toList(),
              ),
            ],
          ],
        );
      },
    );
  }
}
