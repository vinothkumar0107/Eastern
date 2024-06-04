import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/core/utils/util.dart';
import 'package:eastern_trust/data/controller/airtime/airtime_controller.dart';
import 'package:eastern_trust/data/model/airtime/operator_response_model.dart';
import 'package:eastern_trust/views/components/appbar/custom_appbar.dart';
import 'package:eastern_trust/views/components/buttons/custom_rounded_button.dart';
import 'package:eastern_trust/views/components/buttons/rounded_button.dart';
import 'package:eastern_trust/views/components/custom_loader.dart';

import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
import '../../components/custom_cash_network_image.dart';
class SelectOperatorScreen extends StatefulWidget {

  final String countryId;

  const SelectOperatorScreen({super.key,required this.countryId});

  @override
  State<SelectOperatorScreen> createState() => _SelectOperatorScreenState();
}

class _SelectOperatorScreenState extends State<SelectOperatorScreen>{

  TabController? tabController;

  @override
  void initState() {

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<AirtimeController>().loadOperator(countryId: widget.countryId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AirtimeController>(
      builder: (controller) => Scaffold(
        backgroundColor: MyColor.containerBgColor,
        appBar: CustomAppBar(
          title: MyStrings.selectOperator.tr,
        ),
        body: controller.isLoading ? const CustomLoader() : controller.isLoading ? const CustomLoader() : SafeArea(
          child:  Padding(
            padding: const EdgeInsets.only(left: 8,right: 8,top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 5),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(controller.tabsList.length, (index) {

                        var tabs = controller.tabsList[index];

                        return GestureDetector(
                          onTap: () {
                            controller.onTabClick(index);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 7),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: MyColor.primaryColor),
                                color: controller.currentTab == index ? MyColor.primaryColor : MyColor.blueLight
                            ),
                            child: Text(tabs.title ?? "".tr,style: interMediumDefault.copyWith(color:controller.currentTab == index ? MyColor.colorWhite : MyColor.primaryColor),),
                          ),
                        );
                      })
                    ),
                  ),
                ),

                const SizedBox(height: Dimensions.space16,),

                Expanded(
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: controller.tabsList[controller.currentTab].operator?.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: Dimensions.space12,
                      mainAxisSpacing: Dimensions.space12,
                      childAspectRatio: 1
                    ),
                    itemBuilder: (context, index) {
                      Operator operator = controller.tabsList[controller.currentTab].operator?[index] ?? Operator(id: -1);
                      return InkWell(
                        onTap: () {
                          controller.onOperatorClick(operator, index);
                        },
                        child: Stack(
                          clipBehavior: Clip.none,
                          fit: StackFit.expand,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color:  MyColor.blueLight,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: MyColor.primaryColor.withOpacity(.7),width: .5),
                                boxShadow: MyUtil.getCardShadow()
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomCashNetworkImage(
                                    imageWidth: 40,
                                    imageHeight: 40,
                                    imageUrl: operator.logoUrls?.first ?? "".tr,
                                  ),
                                  const SizedBox(height: 14,),
                                  Text(operator.name ?? "".tr,style: interRegularLarge.copyWith(
                                      color:MyColor.colorBlack),
                                      maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
                                ],
                              ),
                            ),
                            controller.operatorCurrentIndex == index ?
                            Positioned(
                              right: Dimensions.space12,
                              top: Dimensions.space10,
                              child: Container(
                                height: 20, width: 20,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: MyColor.getPrimaryColor(),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.check, color: MyColor.colorWhite, size: 10),
                              ),
                            ) : const SizedBox.shrink()
                          ],
                        ),
                      );
                    },
                  ),
                ),

              ],
            ),
          ),
        ),
        bottomNavigationBar: controller.isLoading ? const SizedBox.shrink() : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
          child: CustomRoundedButton(
            labelName: MyStrings.confirm.tr,
            press: () {
              Get.back();
            },
          )
        ),
      ),
    );
  }
}


