import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/string_format_helper.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/core/utils/util.dart';
import 'package:eastern_trust/data/controller/loan/loan_plan_controller.dart';
import 'package:eastern_trust/views/components/buttons/rounded_button.dart';
import 'package:eastern_trust/views/components/widget-divider/widget_divider.dart';

import 'loan_card_middle.dart';

class LoanCard extends StatelessWidget {

  final String cardStatusTitle;
  final String percentRate;
  final String takeMin;
  final String takeMax;
  final String perInstallment;
  final String installmentInterval;
  final String totalInstallment;
  final VoidCallback onPressed;
  final int index;

  const LoanCard({
    Key? key,
    required this.cardStatusTitle,
    required this.percentRate,
    required this.takeMin,
    required this.takeMax,
    required this.perInstallment,
    required this.installmentInterval,
    required this.totalInstallment,
    required this.onPressed,
    required this.index
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetBuilder<LoanPlanController>(builder: (controller)=>GestureDetector(
      onTap: (){
        controller.selectedIndex == index ? controller.changeIndex(-1) : controller.changeIndex(index);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: MyColor.colorWhite,
            borderRadius: BorderRadius.circular(Dimensions.defaultBorderRadius),
            boxShadow: MyUtil.getBottomSheetShadow()
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: Dimensions.space15,
                  right: Dimensions.space15,
                  top: Dimensions.space15,
                  bottom: index == controller.selectedIndex ? 0 : Dimensions.space15
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          cardStatusTitle.tr,
                          style: interRegularDefault.copyWith(color: MyColor.colorBlack, fontWeight: FontWeight.w500)
                      ),
                      const SizedBox(height: Dimensions.space5),
                      RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(
                                  text: Converter.formatNumber(percentRate),
                                  style: interRegularMediumLarge.copyWith(color: MyColor.primaryColor, fontWeight: FontWeight.w600)
                              ),
                              TextSpan(
                                  text: "%",
                                  style: interRegularLarge.copyWith(color: MyColor.primaryColor, fontWeight: FontWeight.w600)
                              ),
                              TextSpan(
                                  text: " / ",
                                  style: interRegularSmall.copyWith(color: MyColor.smallTextColor1)
                              ),
                              TextSpan(
                                  text: "$installmentInterval ${MyStrings.days.tr}",
                                  style: interRegularSmall.copyWith(color: MyColor.smallTextColor1)
                              ),
                            ]
                        ),
                      ),
                    ],
                  ),

                  Container(
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: MyColor.getScreenBgColor(),
                          shape: BoxShape.circle
                      ),
                      child: Icon(
                          index == controller.selectedIndex ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                          color: MyColor.smallTextColor1,
                          size: 15)
                  )
                ],
              ),
            ),

            Visibility(
              visible: index == controller.selectedIndex,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const WidgetDivider(),
                  LoanCardMiddle(
                    minimum: Converter.formatNumber(takeMin),
                    maximum: Converter.formatNumber(takeMax),
                    perInstallment: perInstallment,
                    installmentInterval: '$installmentInterval ${MyStrings.days.tr}',
                    totalInstallment: totalInstallment,
                  ),
                  const WidgetDivider(lineColor: Colors.transparent,),
                  Padding(
                    padding: const EdgeInsets.only(left: Dimensions.space15, bottom: Dimensions.space20, right: Dimensions.space15),
                    child: RoundedButton(
                      press: onPressed,
                      text: MyStrings.applyNow,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
