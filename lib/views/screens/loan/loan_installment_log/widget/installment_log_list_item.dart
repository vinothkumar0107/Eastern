import 'package:flutter/material.dart';
import 'package:eastern_trust/core/helper/date_converter.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/views/components/column/label_column.dart';

import '../../../../../core/utils/util.dart';

class InstallmentLogItem extends StatelessWidget {

  final String serialNumber;
  final String installmentDate;
  final String giveOnDate;
  final String delay;

  const InstallmentLogItem({
    Key? key,
    required this.serialNumber,
    required this.installmentDate,
    required this.giveOnDate,
    required this.delay
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal:Dimensions.space12,vertical: Dimensions.space15),
      decoration: BoxDecoration(
          color: MyColor.colorWhite,
          borderRadius: BorderRadius.circular(Dimensions.defaultBorderRadius),
          boxShadow: MyUtil.getBottomSheetShadow()
      ),
      child: Row(
        children: [
          Container(
            height: 35,
            width: 35,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(Dimensions.space5),
            decoration: const BoxDecoration(
                color: MyColor.containerBgColor,
                shape: BoxShape.circle
            ),
            child: Text(serialNumber, textAlign: TextAlign.center, style: interRegularSmall),
          ),
          const SizedBox(width: Dimensions.space12),
          Expanded(
            flex: 5,
            child: LabelColumn(isSmallFont:true,header:MyStrings.installmentDate,body:  DateConverter.isoStringToLocalDateOnly(installmentDate),)
          ),
          Expanded(
            flex: 3,
            child: LabelColumn(isSmallFont:true,header:MyStrings.givenOn,body: DateConverter.isoStringToLocalDateOnly(giveOnDate,errorResult: MyStrings.notYet),)
          ),
          Expanded(
            flex: 2,
            child: LabelColumn(isSmallFont:true,alignmentEnd:true,header:MyStrings.delay,body: delay,)
          ),
        ],
      ),
    );
  }
}
