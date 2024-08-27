import 'package:eastern_trust/core/utils/my_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/string_format_helper.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/core/utils/util.dart';
import 'package:eastern_trust/data/controller/dps/dps_plan_controller.dart';
import 'package:eastern_trust/views/components/animated_widget/expanded_widget.dart';
import 'package:eastern_trust/views/components/buttons/rounded_button.dart';
import 'package:eastern_trust/views/components/widget-divider/widget_divider.dart';
import 'package:eastern_trust/views/screens/dps/dps-plan/widget/apply_dps_bottom_sheet.dart';

import 'dps_card_middle_section.dart';

class DPSPlanCard extends StatefulWidget {
  final int index;

  const DPSPlanCard({
    Key? key,
    required this.index
  }) : super(key: key);

  @override
  State<DPSPlanCard> createState() => _DPSPlanCardState();
}

class _DPSPlanCardState extends State<DPSPlanCard> {



  @override
  Widget build(BuildContext context) {

    return GetBuilder<DPSPlanController>(
      builder: (controller) => GestureDetector(
        onTap: (){
          ApplyDPSBottomSheet().bottomSheet(context, widget.index);
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
                padding: const EdgeInsets.only(
                    left: Dimensions.space15, right: Dimensions.space15, top: Dimensions.space15,
                    bottom: Dimensions.space5
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            (controller.planList[widget.index].name ?? "").tr,
                            style: interRegularDefault.copyWith(color: MyColor.appPrimaryColorSecondary2, fontSize: Dimensions.fontSize14, fontWeight: FontWeight.w600)
                        ),
                        const SizedBox(height: Dimensions.space5),
                        Text('${MyStrings.totalInstallment} - ${controller.planList[widget.index].totalInstallment??''}',
                            style: interRegularSmall.copyWith(color: MyColor.smallTextColor1)),
                      ],
                    ),
                    Container(
                        padding: const EdgeInsets.only(left: 10,top: 5,right: 10,bottom: 5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: MyColor.primaryColor2.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(10)
                          
                        ),
                        child: Column(
                          children: [
                            Text('${controller.planList[widget.index].interestRate ?? "0.00"}%',
                            style: interRegularDefault.copyWith(color: MyColor.appPrimaryColorSecondary2, fontSize: Dimensions.fontSize14, fontWeight: FontWeight.w600)),
                            Text(MyStrings.interestRate,
                                style: interRegularSmall.copyWith(color: MyColor.appPrimaryColorSecondary2)),
                          ],
                        )
                    ),
                  ],
                ),
              ),
              const WidgetDivider(space: 5),
              Padding(padding: const EdgeInsets.only(
                  left: Dimensions.space15, right: Dimensions.space15, top: Dimensions.space5,
                  bottom: Dimensions.space15
              ),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(MyStrings.deposit,
                            style: interRegularSmall.copyWith(color: MyColor.smallTextColor1, fontSize: Dimensions.fontSmall12, fontWeight: FontWeight.w400)),
                        const SizedBox(height: Dimensions.space5),
                        Text('${controller.currencySymbol}${controller.getDepositAmount(widget.index)}',
                            style: interRegularSmall.copyWith(color: MyColor.colorBlack,fontSize: Dimensions.fontSmall12, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(width: 15,),
                    Container(width: 1, color: MyColor.getBorderColor(),height: 30,),
                    const SizedBox(width: 15,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(MyStrings.perInstallment,
                            style: interRegularSmall.copyWith(color: MyColor.smallTextColor1, fontSize: Dimensions.fontSmall12, fontWeight: FontWeight.w400)),
                        const SizedBox(height: Dimensions.space5),
                        Text('${controller.currencySymbol}${Converter.roundDoubleAndRemoveTrailingZero(controller.planList[widget.index].perInstallment??'')}',
                            style: interRegularSmall.copyWith(color: MyColor.colorBlack,fontSize: Dimensions.fontSmall12, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(width: 15,),
                    Container(width: 1, color: MyColor.getBorderColor(),height: 30,),
                    const SizedBox(width: 15,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(MyStrings.youWillGet,
                            style: interRegularSmall.copyWith(color: MyColor.smallTextColor1, fontSize: Dimensions.fontSmall12, fontWeight: FontWeight.w400)),
                        const SizedBox(height: Dimensions.space5),
                        Text('${controller.currencySymbol}${Converter.formatNumber(controller.planList[widget.index].finalAmount??'')}',
                            style: interRegularSmall.copyWith(color: MyColor.colorBlack,fontSize: Dimensions.fontSmall12, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.space10, horizontal: Dimensions.space15),
                  decoration: BoxDecoration(
                      color: MyColor.colorGrey.withOpacity(0.1),
                      border: Border(
                        top: BorderSide(
                          color: MyColor.colorGrey.withOpacity(0.2), // Top border color
                          width: 1.0, // Top border width
                        ),
                      ),
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(Dimensions.space10), bottomRight: Radius.circular(Dimensions.space10))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${MyStrings.installmentInterval} - ${controller.planList[widget.index].installmentInterval??''}${MyStrings.days.tr}',
                          style: interRegularSmall.copyWith(color: MyColor.smallTextColor1)),
                      Icon(Icons.keyboard_arrow_down, color: MyColor.colorBlack.withOpacity(0.6),size: 15)
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }

}
