import 'package:flutter/material.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/views/screens/dps/dps-plan/widget/plan_row_item.dart';

class DPSCardMiddleSection extends StatefulWidget {
  final String interestRate;
  final String perInstallment;
  final String installmentInterval;
  final String totalInstallment;
  final String depositAmount;
  final String youWillGet;

  const DPSCardMiddleSection({
    Key? key,
    required this.interestRate,
    required this.perInstallment,
    required this.installmentInterval,
    required this.totalInstallment,
    required this.depositAmount,
    required this.youWillGet
  }) : super(key: key);

  @override
  State<DPSCardMiddleSection> createState() => _DPSCardMiddleSectionState();
}

class _DPSCardMiddleSectionState extends State<DPSCardMiddleSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: Dimensions.space15, right: Dimensions.space15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PlanRow(firstText: MyStrings.interestRate,secondText: widget.interestRate),
          PlanRow(firstText: MyStrings.perInstallment,secondText: widget.perInstallment),
          PlanRow(firstText: MyStrings.installmentInterval,secondText: widget.installmentInterval),
          PlanRow(firstText: MyStrings.totalInstallment,secondText: widget.totalInstallment),
          PlanRow(firstText: MyStrings.deposit,secondText: widget.depositAmount),
          PlanRow(firstText: MyStrings.youWillGet,secondText: widget.youWillGet,space: 0),
        ],
      ),
    );
  }
}
