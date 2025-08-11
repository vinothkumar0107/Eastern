import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/string_format_helper.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/views/components/bottom_sheet/custom_bottom_sheet.dart';
import 'package:eastern_trust/views/components/row_item/bottom_sheet_top_row.dart';
import '../../../../../data/controller/fdr/fdr_installment_log_controller.dart';
import '../../../../components/column/bottom_sheet_column.dart';

class FDRInstallmentBottomSheet{

   void bottomSheet(BuildContext context){
    CustomBottomSheet(child: GetBuilder<FDRInstallmentLogController>(
      builder: (controller) => Column(
        children: [
          const BottomSheetTopRow(header: MyStrings.fdrInformation),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: BottomSheetColumn(header:MyStrings.plan, body: controller.fdr?.plan?.name??'')),
                  const SizedBox(width: 10,),
                  Expanded(child: BottomSheetColumn(alignmentEnd: true,header:MyStrings.fdrNumber, body: controller.fdr?.fdrNumber??'')),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: BottomSheetColumn(header:MyStrings.interestRate, body: '${controller.interestRate}%')),
                  Expanded(child: Align(
                    alignment: Alignment.bottomRight,
                    child: BottomSheetColumn(
                        alignmentEnd: true,
                        header: MyStrings.deposited, body: '${Converter.formatNumber(controller.depositAmount,precision: 2).makeCurrencyComma()} ${controller.currency}'),)),
                ],
              ),
              const SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: BottomSheetColumn(header: MyStrings.perInstallment, body: '${Converter.formatNumber(controller.fdr?.perInstallment ?? '0').makeCurrencyComma()} ${controller.currency}',)),
                  const SizedBox(width: 10),
                  Expanded(child: BottomSheetColumn(alignmentEnd:true,header: MyStrings.receivedInstallment, body:  controller.receivedInstallment.padLeft(2,'0'),)),
                ],
              ),
              const SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: BottomSheetColumn(header: MyStrings.profitReceived, body: '${Converter.formatNumber(controller.profitAmount).makeCurrencyComma()} ${controller.currency}',)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15,)
        ],
      )
    )).customBottomSheet(context);
  }
}