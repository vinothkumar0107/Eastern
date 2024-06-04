import 'package:flutter/material.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/views/screens/dps/dps-plan/widget/plan_row_item.dart';

class FdrCardMiddleSection extends StatefulWidget {

  final String lockPeriod;
  final String profitRate;
  final String minimum;
  final String maximum;
  final String profitEvery;

  const FdrCardMiddleSection({
    Key? key,
    required this.lockPeriod,
    required this.profitRate,
    required this.minimum,
    required this.maximum,
    required this.profitEvery,
  }) : super(key: key);

  @override
  State<FdrCardMiddleSection> createState() => _FdrCardMiddleSectionState();
}

class _FdrCardMiddleSectionState extends State<FdrCardMiddleSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: Dimensions.space15, right: Dimensions.space15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PlanRow(firstText: MyStrings.lockInPeriod,     secondText: widget.lockPeriod),
          PlanRow(firstText: MyStrings.getProfitEvery, secondText: widget.profitEvery),
          PlanRow(firstText: MyStrings.profitRate,     secondText: widget.profitRate),
          PlanRow(firstText: MyStrings.minAmount,      secondText: widget.minimum),
          PlanRow(firstText: MyStrings.maxAmount,      secondText: widget.maximum,space: 0,),
        ],
      ),
    );
  }
}
