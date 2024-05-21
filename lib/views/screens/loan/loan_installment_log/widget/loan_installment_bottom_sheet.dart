import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/string_format_helper.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/data/controller/loan/loan_installment_log_controller.dart';
import 'package:eastern_trust/views/components/bottom_sheet/custom_bottom_sheet.dart';
import 'package:eastern_trust/views/components/column/bottom_sheet_column.dart';
import 'package:eastern_trust/views/components/row_item/bottom_sheet_top_row.dart';

class LoanInstallmentPreviewBottomSheet{
   void bottomSheet(BuildContext context){
    CustomBottomSheet(child: GetBuilder<LoanInstallmentLogController>(
      builder: (controller) => Column(
        children: [
          const BottomSheetTopRow(header: MyStrings.loanInformation),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: BottomSheetColumn(header:MyStrings.plan, body: controller.loan?.plan?.name??'')),
                  const SizedBox(width: 10,),
                  Expanded(child: BottomSheetColumn(alignmentEnd: true,header:MyStrings.loanNumber, body: controller.loan?.loanNumber??'')),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: BottomSheetColumn(header: MyStrings.loanAmount, body: '${Converter.formatNumber(controller.loan?.amount??'0',precision: 2)} ${controller.currency}'),),
                  Expanded(child: BottomSheetColumn(
                      alignmentEnd: true,
                      header: MyStrings.perInstallment, body: '${Converter.formatNumber(controller.loan?.perInstallment??'0',precision: 2)} ${controller.currency}')),
                ],
              ),
              const SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: BottomSheetColumn(header: MyStrings.totalInstallment, body: (controller.loan?.totalInstallment ?? '0').padLeft(2,'0'))),
                  const SizedBox(width: 10),
                  Expanded(child: BottomSheetColumn(alignmentEnd:true,header: MyStrings.givenInstallment, body:  (controller.loan?.givenInstallment??'0').padLeft(2,'0'))),
                ],
              ),
              const SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: BottomSheetColumn(header: MyStrings.needToPay, body: '${Converter.mul(controller.loan?.perInstallment??'0', controller.loan?.totalInstallment??'0')} ${controller.currency}',)),
                  Expanded(child: BottomSheetColumn(alignmentEnd:true,header: MyStrings.delayCharge, body: '${Converter.formatNumber(controller.loan?.chargePerInstallment??'0')} ${controller.currency} /${MyStrings.day.tr}',)),
                ],
              ),
              const SizedBox(height: 15,),
              Text('*${MyStrings.chargeWillBeApplyMsg.tr} ${controller.loan?.delayValue??'1'} ${MyStrings.orMoreDays.tr}'.tr,style: interRegularDefault.copyWith(color: MyColor.colorRed),)
            ],
          ),
          const SizedBox(height: 15,)
        ],
      )
    )).customBottomSheet(context);
  }
}