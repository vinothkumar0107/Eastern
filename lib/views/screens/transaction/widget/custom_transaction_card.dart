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
      builder: (controller) => Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 13),
        decoration: BoxDecoration(
            color: MyColor.colorWhite,
            borderRadius: BorderRadius.circular(5),
          boxShadow: MyUtil.getCardShadow()
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: CardColumn(header: MyStrings.trx, body: trxData)),
                Expanded(child: CardColumn(alignmentEnd:true,header: MyStrings.date, body: dateData,isDate: true,),)
              ],
            ),
            const WidgetDivider(space: Dimensions.space15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: CardColumn(header: MyStrings.amount, body: '$amountData ${controller.currency}',textColor: controller.changeTextColor(trxType),)),
                Expanded(child: CardColumn(alignmentEnd:true,header: MyStrings.postBalance, body: '$postBalanceData ${controller.currency}')),
              ],
            ),
            ExpandedSection(
              expand: expandIndex==index,
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const WidgetDivider(space: Dimensions.space15),
                  CardColumn(header: MyStrings.details, body: detailsText)
                ],
            ),)
          ],
        ),
      ),
    );
  }

}
