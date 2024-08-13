import 'package:flutter/material.dart';
import 'package:eastern_trust/core/helper/date_converter.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/views/components/column/card_column.dart';
import 'package:eastern_trust/views/components/widget-divider/widget_divider.dart';

import '../../../../../../core/utils/util.dart';

class InstallmentLogItem extends StatelessWidget {
  final String serialNumber;
  final String installmentDate;
  final String giveOnDate;
  final String delay;
  final String delayCharge;
  const InstallmentLogItem({
    Key? key,
    required this.serialNumber,
    required this.installmentDate,
    required this.giveOnDate,
    required this.delay,
    required this.delayCharge
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.screenPadding,),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.defaultBorderRadius),
        color: MyColor.getCardBg(),boxShadow: MyUtil.getCardShadow()
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardColumn(
                header: MyStrings.installmentDate,
                body: DateConverter.isoStringToLocalDateOnly(installmentDate),
              ),
              CardColumn(
                alignmentEnd: true,
                header: MyStrings.givenOn,
                body: DateConverter.isoStringToLocalDateOnly(giveOnDate,errorResult: MyStrings.notYet),
              )
            ],
          ),
          const WidgetDivider(space: Dimensions.space15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardColumn(
                header:MyStrings.delay,
                body: delay,
              ),
              CardColumn(
                alignmentEnd: true,
                header:MyStrings.delayCharge,
                body: delayCharge,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
