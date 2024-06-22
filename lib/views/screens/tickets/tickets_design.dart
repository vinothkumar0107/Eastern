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
  final Color statusTextColor;
  final Color priorityTextColor;
  final VoidCallback onPressed;

  const TicketDesign(
      {Key? key,
      required this.ticketID,
      required this.subject,
      required this.status,
      required this.priority,
      required this.lastReplyDate,
      required this.statusTextColor,
      required this.priorityTextColor,
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
                  ),
                  TicketColumn(
                    alignmentEnd: true,
                    header: priority,
                    isDate: true,
                    body: '${MyStrings.lastReply}: $lastReplyDate',
                    textColor: priorityTextColor,
                  ),
                ],
              ),
              TicketColumn(
                header: "",
                body: status,
                textColor: statusTextColor,
              ),
            ],
          )),
    );
  }
}
