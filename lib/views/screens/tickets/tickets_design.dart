import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/views/screens/tickets/ticket_column.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/util.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class TicketDesign extends StatelessWidget {
  final String trxValue, date, status, amount;
  final Color statusBgColor;
  final VoidCallback onPressed;

  const TicketDesign(
      {Key? key,
      required this.trxValue,
      required this.date,
      required this.status,
      required this.statusBgColor,
      required this.amount,
      required this.onPressed
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:  onPressed,
      child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(
              vertical: Dimensions.space15, horizontal: Dimensions.space15),
          decoration: BoxDecoration(
              color: MyColor.colorWhite,
              borderRadius:
                  BorderRadius.circular(Dimensions.defaultBorderRadius),
              boxShadow: MyUtil.getCardShadow()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TicketColumn(
                    header: "[Ticket#9999985]",
                    body: "Customer reply",
                  ),
                  TicketColumn(
                    alignmentEnd: true,
                    header: "High",
                    isDate: true,
                    body: MyStrings.lastReply + ": " + "14 seconds ago",
                  ),
                ],
              ),
              TicketColumn(
                header: "",
                body: MyStrings.statusTicket + ": " + "ok",
              ),
            ],
          )),
    );
  }
}
