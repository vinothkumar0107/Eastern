import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/date_converter.dart';
import 'package:eastern_trust/core/helper/string_format_helper.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/data/controller/transfer/transfer_history_controller.dart';
import 'package:eastern_trust/data/model/transfer/history/transfer_history_response_model.dart';
import 'package:eastern_trust/views/components/bottom_sheet/custom_bottom_sheet.dart';
import 'package:eastern_trust/views/components/column/label_column.dart';
import 'package:eastern_trust/views/components/custom_container/bottom_sheet_container.dart';
import 'package:eastern_trust/views/components/row_item/bottom_sheet_top_row.dart';

class TransferHistoryBottomSheet{

  void transferHistoryBottomSheet(BuildContext context,int index){

    CustomBottomSheet(child: GetBuilder<TransferHistoryController>(builder: (controller){
      String bankName = controller.historyList[index].beneficiary!=null?controller.historyList[index].beneficiary?.beneficiaryOf?.name??'':MyStrings.wireTransfer;
      if(bankName.isEmpty){
        bankName = MyStrings.appName;
      }
      return Column(
        children: [
          const BottomSheetTopRow(header: MyStrings.transferInformation),
          BottomSheetContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: LabelColumn(header: MyStrings.accountNumber.tr, body: controller.getAccountNumber(index)),
                    ),
                    Expanded(
                      child: LabelColumn(alignmentEnd:true,header: MyStrings.date.tr, body: DateConverter.isoStringToLocalDateOnly(controller.historyList[index].createdAt??'')),
                    )
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: LabelColumn(header: MyStrings.bank.tr, body: bankName),
                    ),
                    Expanded(
                      child: LabelColumn(alignmentEnd:true,header: MyStrings.amount.tr, body: "${controller.currencySymbol}${Converter.formatNumber(controller.historyList[index].amount??'0').makeCurrencyComma()}"),
                    )

                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: LabelColumn(header: MyStrings.charge.tr, body: '${controller.currencySymbol}${Converter.formatNumber(controller.historyList[index].charge??'0').makeCurrencyComma()}'),
                    ),
                    Expanded(
                      child: LabelColumn(alignmentEnd:true,header: MyStrings.paidAmount.tr, body: '${controller.currencySymbol}${Converter.sum(controller.historyList[index].amount??'0',controller.historyList[index].charge??'0').makeCurrencyComma()}'),
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 15,),
          Visibility(
            visible: controller.historyList[index].wireTransferData!=null && controller.historyList[index].beneficiary==null,
            child:BottomSheetContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10,),
                  const Divider(color: MyColor.borderColor,),
                  const SizedBox(height: 10,),
                  Text(MyStrings.wireTransferDetails.tr,style: interSemiBoldSmall,),
                  const SizedBox(height: 15,),
                  SizedBox(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:controller.historyList[index].wireTransferData?.length??0,
                      itemBuilder: (BuildContext context, int wireTransferIndex) {
                        Details? details = controller.historyList[index].wireTransferData?[wireTransferIndex];
                        return Container(
                          margin: const EdgeInsets.only(bottom: Dimensions.space10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4)
                          ),
                          child: LabelColumn(header:details?.name??'', body: details?.value.toString()??''),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    })).customBottomSheet(context);
  }
}