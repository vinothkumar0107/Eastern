import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/string_format_helper.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/data/controller/dps/dps_installment_log_controller.dart';
import 'package:eastern_trust/views/components/bottom_sheet/custom_bottom_sheet.dart';
import 'package:eastern_trust/views/components/column/label_column.dart';
import 'package:eastern_trust/views/components/custom_container/bottom_sheet_container.dart';
import 'package:eastern_trust/views/components/row_item/bottom_sheet_top_row.dart';


class DPSInstallmentBottomSheet{

   void show(BuildContext context){
    CustomBottomSheet(child: GetBuilder<DPSInstallmentLogController>(
      builder: (controller) => Column(
        children: [
         const BottomSheetTopRow(header: MyStrings.dpsInformation),
         BottomSheetContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: LabelColumn(header:MyStrings.plan, body: controller.dps?.plan?.name??'')) ,
                    const SizedBox(width: 5,),
                    Expanded(child: LabelColumn(alignmentEnd:true,header:MyStrings.dpsNo, body: '#${controller.dpsId}')) ,
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: LabelColumn(header:MyStrings.interestRate.tr, body: '${Converter.roundDoubleAndRemoveTrailingZero(controller.dps?.interestRate??'0')}%')),
                    const SizedBox(width: 10,),
                    Expanded(child: Align(
                      alignment: Alignment.bottomRight,
                      child: LabelColumn(
                          alignmentEnd: true,
                          header: MyStrings.perInstallment.tr, body: '${Converter.formatNumber(controller.dps?.perInstallment??'0',precision: 2)} ${controller.currency}'),)),
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: LabelColumn(header: MyStrings.givenInstallment.tr, body: (controller.dps?.givenInstallment ?? '0').toString()/*.padLeft(2,'0'),*/)),
                    const SizedBox(width: 10,),
                    Expanded(child: LabelColumn(alignmentEnd:true,header: MyStrings.totalInstallment.tr, body: (controller.dps?.totalInstallment ?? '0').toString()/*padLeft(2,'0'),*/)),
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: LabelColumn(header: MyStrings.totalDeposit.tr, body: '${Converter.formatNumber(controller.depositAmount)} ${controller.currency}',)),
                    const SizedBox(width: 10,),
                    Expanded(child: LabelColumn(alignmentEnd:true,header: MyStrings.profit.tr, body: '${Converter.formatNumber(controller.profitAmount)} ${controller.currency}',)),
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: LabelColumn(header: MyStrings.includingProfit.tr, body: '${controller.getIncludingProfit()} ${controller.currency}',)),
                    const SizedBox(width: 10,),
                    Expanded(child: LabelColumn(alignmentEnd:true,header: MyStrings.delayCharge.tr, body: '${Converter.formatNumber(controller.dps?.chargePerInstallment??'0')} ${controller.currency} /${MyStrings.day}',)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20,),
          BottomSheetContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10,),
                Text('*${MyStrings.chargeWillBeApplyMsg.tr} ${controller.dps?.delayValue??'0'} ${MyStrings.orMoreDays.tr}'.tr,
                  style:interLightDefault.copyWith(color: MyColor.redCancelTextColor),
                ),
                const SizedBox(height: 10,),
              ],
            ),
          )
        ],
      )
    )).customBottomSheet(context);
  }
}