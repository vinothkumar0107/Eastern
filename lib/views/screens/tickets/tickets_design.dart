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
  final String ticketID, subject, status, priority, lastReplyDate;
  final Color headerLeftColor;
  final Color bodyLeftColor;
  final Color headerRightColor;
  final Color bodyRightColor;
  final Color statusColor;
  final int selectedIndex;
  final bool? isNeedLeftHeaderBox;
  final bool? isNeedLeftBodyBox;
  final bool? isNeedRightHeaderBox;
  final bool? isNeedRightBodyBox;
  final bool? isNeedStatusBox;
  final VoidCallback onPressed;

  const TicketDesign(
      {Key? key,
      required this.ticketID,
      required this.subject,
      required this.status,
      required this.priority,
      required this.lastReplyDate,
      required this.headerLeftColor,
      required this.bodyLeftColor,
      required this.headerRightColor,
      required this.bodyRightColor,
      required this.statusColor,
      required this.selectedIndex,
      this.isNeedLeftHeaderBox,
      this.isNeedLeftBodyBox,
      this.isNeedRightHeaderBox,
      this.isNeedRightBodyBox,
      this.isNeedStatusBox,
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
                    header: ticketID,
                    body: subject,
                    headerColor: headerLeftColor,
                    bodyColor: bodyLeftColor,
                    isNeedHeaderBox: isNeedLeftHeaderBox ?? false,
                    isNeedBodyBox: isNeedLeftBodyBox ?? false,
                  ),
                  TicketColumn(
                    alignmentEnd: true,
                    header: priority,
                    isDate: true,
                    body: '${MyStrings.lastReply}: $lastReplyDate',
                    headerColor: headerRightColor,
                    bodyColor: bodyRightColor,
                    isNeedHeaderBox: isNeedRightHeaderBox ?? false ,
                    isNeedBodyBox: isNeedRightBodyBox ?? false,
                  ),
                ],
              ),
              TicketColumn(
                header: "",
                body: status,
                headerColor: statusColor,
                bodyColor: statusColor,
                isNeedHeaderBox: false,
                isNeedBodyBox: isNeedStatusBox ?? false,
              ),
            ],
          )),
    );
  }
}
