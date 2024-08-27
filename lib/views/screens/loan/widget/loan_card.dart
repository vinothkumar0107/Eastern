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

import '../loan-plan/widget/apply_loan_bottom_sheet.dart';
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
  final bool isFromLoanConfirmation;

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
    required this.index,
    this.isFromLoanConfirmation = false
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return GetBuilder<LoanPlanController>(
      builder: (controller) => GestureDetector(
        onTap: (){
          !isFromLoanConfirmation ?
          ApplyLoanBottomSheet().bottomSheet(context, index) : ();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: MyColor.colorWhite,
              borderRadius: BorderRadius.circular(Dimensions.defaultBorderRadius),
              boxShadow: MyUtil.getBottomSheetShadow()
          ),
          child: isFromLoanConfirmation ? Column(
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
                            (cardStatusTitle ?? "").tr,
                            style: interRegularDefault.copyWith(color: MyColor.appPrimaryColorSecondary2, fontSize: Dimensions.fontSize14, fontWeight: FontWeight.w600)
                        ),
                        const SizedBox(height: Dimensions.space5),
                        Text('${MyStrings.loanUpTo} - ${Converter.formatNumber(takeMax)}',
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
                            Text('$perInstallment%',
                                style: interRegularDefault.copyWith(color: MyColor.appPrimaryColorSecondary2, fontSize: Dimensions.fontSize14, fontWeight: FontWeight.w600)),
                            Text(MyStrings.perInstallment,
                                style: interRegularSmall.copyWith(color: MyColor.appPrimaryColorSecondary2)),
                          ],
                        )
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
                      Text('${MyStrings.totalInstallment} - $totalInstallment',
                          style: interRegularSmall.copyWith(color: MyColor.smallTextColor1)),
                      Text('${MyStrings.installmentInterval} - $installmentInterval ${MyStrings.days.tr}',
                          style: interRegularSmall.copyWith(color: MyColor.smallTextColor1)),
                    ],
                  )
              ),
            ],
          ) :
          Column(
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
                            (controller.planList[index].name ?? "").tr,
                            style: interRegularDefault.copyWith(color: MyColor.appPrimaryColorSecondary2, fontSize: Dimensions.fontSize14, fontWeight: FontWeight.w600)
                        ),
                        const SizedBox(height: Dimensions.space5),
                        Text('${MyStrings.totalInstallment} - ${controller.planList[index].totalInstallment}',
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
                            Text('${controller.planList[index].perInstallment}%',
                                style: interRegularDefault.copyWith(color: MyColor.appPrimaryColorSecondary2, fontSize: Dimensions.fontSize14, fontWeight: FontWeight.w600)),
                            Text(MyStrings.perInstallment,
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
                        Text(MyStrings.takeMinimum,
                            style: interRegularSmall.copyWith(color: MyColor.smallTextColor1, fontSize: Dimensions.fontSmall12, fontWeight: FontWeight.w400)),
                        const SizedBox(height: Dimensions.space5),
                        Text(Converter.formatNumber(takeMin),
                            style: interRegularSmall.copyWith(color: MyColor.colorBlack,fontSize: Dimensions.fontSmall12, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(width: 15,),
                    Container(width: 1, color: MyColor.getBorderColor(),height: 30,),
                    const SizedBox(width: 15,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(MyStrings.takeMaximum,
                            style: interRegularSmall.copyWith(color: MyColor.smallTextColor1, fontSize: Dimensions.fontSmall12, fontWeight: FontWeight.w400)),
                        const SizedBox(height: Dimensions.space5),
                        Text(Converter.formatNumber(takeMax),
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
                      Text('${MyStrings.installmentInterval} - $installmentInterval ${MyStrings.days.tr}',
                          style: interRegularSmall.copyWith(color: MyColor.smallTextColor1)),
                      Icon(Icons.keyboard_arrow_down, color: MyColor.colorBlack.withOpacity(0.6),size: 15)
                    ],
                  )
              ),
            ],
          )
        ),
      ),
    );
  }
}
