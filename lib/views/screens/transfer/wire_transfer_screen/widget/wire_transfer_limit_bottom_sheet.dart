

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/string_format_helper.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/data/controller/transfer/wire_transfer_controller.dart';
import 'package:eastern_trust/views/components/bottom_sheet/custom_bottom_sheet.dart';
import 'package:eastern_trust/views/components/column/bottom_sheet_column.dart';
import 'package:eastern_trust/views/components/custom_container/bottom_sheet_container.dart';
import 'package:eastern_trust/views/components/row_item/bottom_sheet_top_row.dart';

class WireTransferLimitBottomSheet{

    void showLimitSheet(BuildContext context){
      CustomBottomSheet(
        child: GetBuilder<WireTransferController>(builder: (controller)=> Column(
          children: [
           const BottomSheetTopRow(header: MyStrings.transferLimit),
           BottomSheetContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: BottomSheetColumn(header: MyStrings.perTransaction, body: '${Converter.formatNumber(controller.setting?.minimumLimit??'0')}-${Converter.formatNumber(controller.setting?.maximumLimit??'0')} ${controller.currency}')),
                      Expanded(child: BottomSheetColumn(alignmentEnd:true,isCharge:true,header: MyStrings.charge, body: '${controller.setting?.percentCharge??''}%${Converter.showPercent(controller.currencySymbol,controller.setting?.fixedCharge??'0')}')),
                    ],
                  ),
                  const SizedBox(height: Dimensions.space15),
                  Row(
                    children: [
                      Expanded(child: BottomSheetColumn(header: MyStrings.dailyMax, body: '${Converter.formatNumber(controller.setting?.dailyMaximumLimit??'0')} ${controller.currency}')),
                      Expanded(child: BottomSheetColumn(alignmentEnd:true,header: MyStrings.monthlyMax, body: '${Converter.formatNumber(controller.setting?.dailyMaximumLimit??'0')} ${controller.currency}')),
                    ],
                  ),
                  const SizedBox(height: Dimensions.space15),
                  Row(
                    children: [
                      Expanded(child: BottomSheetColumn(header: MyStrings.dailyMaxTrx, body:  controller.setting?.dailyTotalTransaction??'0')),
                      Expanded(child: BottomSheetColumn(alignmentEnd:true,header: MyStrings.monthlyMinTrx, body: controller.setting?.monthlyTotalTransaction??'0')),
                    ],
                  ),
                ],
              ),
            ),
          ],
        )
      )).customBottomSheet(context);
    }

  }