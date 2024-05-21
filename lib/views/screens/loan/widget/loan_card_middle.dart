import 'package:flutter/material.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/views/screens/dps/dps-plan/widget/plan_row_item.dart';

class LoanCardMiddle extends StatelessWidget {

  final String minimum;
  final String maximum;
  final String perInstallment;
  final String installmentInterval;
  final String totalInstallment;

  const LoanCardMiddle({
    Key? key,
    required this.minimum,
    required this.maximum,
    required this.perInstallment,
    required this.installmentInterval,
    required this.totalInstallment
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: Dimensions.space15, right: Dimensions.space15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PlanRow(firstText: MyStrings.takeMinimum,secondText: minimum),
          PlanRow(firstText: MyStrings.takeMaximum,secondText: maximum),
          PlanRow(firstText: MyStrings.perInstallment,secondText: perInstallment ),
          PlanRow(firstText: MyStrings.installmentInterval,secondText:installmentInterval),
          PlanRow(firstText: MyStrings.totalInstallment,secondText: totalInstallment,space: 0,)
        ],
      ),
    );
  }
}
