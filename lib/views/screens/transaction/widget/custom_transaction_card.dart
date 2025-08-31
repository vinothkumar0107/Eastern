import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/util.dart';
import 'package:eastern_trust/data/controller/transaction/transaction_controller.dart';
import 'package:eastern_trust/views/components/animated_widget/expanded_widget.dart';
import 'package:eastern_trust/views/components/column/card_column.dart';
import 'package:eastern_trust/views/components/widget-divider/widget_divider.dart';

import '../../tickets/ticket_column.dart';

class CustomTransactionCard extends StatelessWidget {

  final String trxData;
  final String dateData;
  final String amountData;
  final String detailsText;
  final String postBalanceData;
  final int index;
  final int expandIndex;
  final String trxType;

  const CustomTransactionCard({
    Key? key,
    required this.index,
    required this.trxData,
    required this.dateData,
    required this.amountData,
    required this.postBalanceData,
    required this.expandIndex,
    required this.detailsText,
    required this.trxType
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetBuilder<TransactionController>(
      builder: (controller) =>  Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: MyColor.colorWhite,
            borderRadius:
            BorderRadius.circular(Dimensions.paddingSize10),
            boxShadow: MyUtil.getCardShadow(),
            border: Border.all(
              color: MyColor.liteGreyColorBorder, // Border color
              width: 1.0, // Border width
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(
                  top: Dimensions.space15,
                  left: Dimensions.space15,
                  right: Dimensions.space15,
                  bottom: Dimensions.space15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  controller.changeImage(trxType),
                  const SizedBox(width: Dimensions.space10),
                  Expanded(child: CardColumn(header: trxData, body: dateData, textColor: MyColor.colorBlack,)),
                  Expanded(child: CardColumn(alignmentEnd:true,header: '${amountData.makeCurrencyComma()} ${controller.currency}', body: '',isDate: false, textColor: controller.changeTextColor(trxType)),),
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
                    Expanded(child: CardColumn(header: '', body: detailsText, textColor: MyColor.colorBlack),),
                    Expanded(child: CardColumn(textAlignment: TextAlign.end, alignmentEnd:true,header: '', body: '${MyStrings.postBalance}\n ${postBalanceData.makeCurrencyComma()} ${controller.currency}')),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }

}
