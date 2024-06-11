import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/util.dart';
import 'package:eastern_trust/views/components/column/card_column.dart';
import 'package:eastern_trust/views/components/status/status_widget.dart';
import 'package:eastern_trust/views/components/widget-divider/widget_divider.dart';

import '../../../core/route/route.dart';
import '../../../core/utils/style.dart';

class TicketDesign extends StatelessWidget {

  final String trxValue, date,status, amount;
  final Color statusBgColor;
  final VoidCallback onPressed;

  const TicketDesign({
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
            Table(
              children: [
                _buildTableRow(trxValue, '[Ticket#955556] Ok', 'Customer Reply',
                    'High', '14 seconds ago', 'View')
              ],
            ),
          ],
        )
      ),
    );
  }

}

TableRow _buildTableRow(String sn, String subject, String status,
    String priority, String lastReply, String action) {
  return TableRow(
    children: [
      TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(sn,
                style: interRegularSmall.copyWith(color: MyColor.colorBlack)),
          )),
      TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(subject,
                style: interRegularSmall.copyWith(color: MyColor.primaryColor)),
          )),
      TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(4.0),
              child: Text(status,
                  style: interRegularSmall.copyWith(color: MyColor.colorBlack)),
            ),
          )),
      TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(4.0),
              child: Text(priority,
                  style: interRegularSmall.copyWith(color: MyColor.red)),
            ),
          )),
      TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(lastReply,
                style: interRegularSmall.copyWith(color: MyColor.colorGrey)),
          )),
      TableCell(
          child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: InkWell(
                onTap: () => Get.toNamed(RouteHelper.editProfileScreen),
                child: Container(
                  margin: const EdgeInsetsDirectional.only(start: 1),
                  height: 30,
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.defaultRadius)
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: Dimensions.space5, horizontal: Dimensions.space10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: MyColor.transparentColor,
                            borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
                            border: Border.all(color: MyColor.primaryColor, width: 0.5)
                        ),
                        child: Text(action.tr, textAlign: TextAlign.center, style: interRegularSmall.copyWith(color: MyColor.primaryColor)),
                      )

                    ],
                  ),
                ),
              )
          )),
    ],
  );
}
