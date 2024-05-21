import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/util.dart';
import 'package:eastern_trust/views/components/column/card_column.dart';
import 'package:eastern_trust/views/components/status/status_widget.dart';
import 'package:eastern_trust/views/components/widget-divider/widget_divider.dart';

class CustomDepositsCard extends StatelessWidget {

  final String trxValue, date,status, amount;
  final Color statusBgColor;
  final VoidCallback onPressed;

  const CustomDepositsCard({
    Key? key,
    required this.trxValue,
    required this.date,
    required this.status,
    required this.statusBgColor,
    required this.amount,
    required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
        decoration: BoxDecoration(
          color: MyColor.colorWhite,
          borderRadius: BorderRadius.circular(Dimensions.defaultBorderRadius),
          boxShadow: MyUtil.getCardShadow()
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CardColumn(
                  header: MyStrings.trxNo,
                  body: trxValue,
                ),
                CardColumn(
                  alignmentEnd: true,
                  header: MyStrings.date,
                  isDate: true,
                  body: date,
                ),
              ],
            ),
            const WidgetDivider(space: Dimensions.space10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                CardColumn(
                  header:MyStrings.amount.tr,
                  body: amount,
                ),
                StatusWidget(
                  needBorder: true,
                  status: status,
                  backgroundColor: statusBgColor,
                  borderColor: statusBgColor,
                )
              ],
            ),
          ],
        )
      ),
    );
  }
}
