import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/core/utils/style.dart';
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
        padding: const EdgeInsets.only(
            top: 0,
            left: Dimensions.space15,
            right: Dimensions.space15,
            bottom: Dimensions.space5),
        color: MyColor.colorWhite,
        child: Container(
            width: MediaQuery.of(context).size.width,

            decoration: BoxDecoration(
                color: MyColor.colorWhite,
                borderRadius:
                BorderRadius.circular(Dimensions.paddingSize10),
                boxShadow: MyUtil.getCardShadow(),
            border: Border.all(
              color: MyColor.liteGreyColorBorder, // Border color
              width: 1.0, // Border width
            )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Container(
                 padding: const EdgeInsets.symmetric(
                     vertical: Dimensions.space15, horizontal: Dimensions.space15),
                 child:  Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,

                   children: [
                     TicketColumn(
                       header: ticketID,
                       body: subject,
                       headerColor: headerLeftColor,
                       bodyColor: bodyLeftColor,
                       isNeedHeaderBox: isNeedLeftHeaderBox ?? false,
                       isNeedBodyBox: isNeedLeftBodyBox ?? false,
                       headerTextStyle: interMediumDefault.copyWith(color: MyColor.colorBlack, fontSize: Dimensions.fontSize14),
                       bodyTextStyle: interRegularSmall.copyWith(color: MyColor.colorGrey, fontSize: Dimensions.fontSmall12),
                     ),
                     TicketColumn(
                       alignmentEnd: true,
                       header: priority,
                       isDate: true,
                       body: '',
                       headerColor: headerRightColor,
                       bodyColor: bodyRightColor,
                       isNeedHeaderBox: isNeedRightHeaderBox ?? false ,
                       isNeedBodyBox: isNeedRightBodyBox ?? false,
                       headerTextStyle: interMediumDefault.copyWith(color: headerRightColor, fontSize: Dimensions.fontSmall),
                       bodyTextStyle: interRegularSmall.copyWith(color: bodyRightColor, fontSize: Dimensions.fontSmall12),
                     ),
                   ],
                 ),
               ),
               Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.space5, horizontal: Dimensions.space15),
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
                      TicketColumn(
                        header: "",
                        body: status,
                        headerColor: statusColor,
                        bodyColor: statusColor,
                        isNeedHeaderBox: false,
                        isNeedBodyBox: isNeedStatusBox ?? false,
                        headerTextStyle: interMediumDefault.copyWith(color: headerRightColor, fontSize: Dimensions.fontSmall),
                        bodyTextStyle: interMediumDefault.copyWith(color: MyColor.colorBlack, fontSize: Dimensions.fontSmall12),
                      ),
                      TicketColumn(
                        alignmentEnd: true,
                        header: '',
                        isDate: true,
                        body: '${MyStrings.lastReply}: $lastReplyDate',
                        headerColor: headerRightColor,
                        bodyColor: bodyRightColor,
                        isNeedHeaderBox: false ,
                        isNeedBodyBox: false,
                        headerTextStyle: interMediumDefault.copyWith(color: headerRightColor, fontSize: Dimensions.fontSmall),
                        bodyTextStyle: interMediumDefault.copyWith(color: MyColor.colorBlack, fontSize: Dimensions.fontSmall12),
                      ),
                    ],
                  )
                ),
              ],
            )),
      )
    );
  }
}
