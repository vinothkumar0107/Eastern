import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/data/controller/fdr/fdr_plan_controller.dart';
import 'package:eastern_trust/views/components/custom_loader.dart';
import 'package:eastern_trust/views/components/no_data/no_data_found_screen.dart';
import 'package:eastern_trust/views/screens/fdr/fdr-plan/widget/fdr_card.dart';

class FDRPlanBody extends StatelessWidget {
  const FDRPlanBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FDRPlanController>(builder: (controller)=> controller.isLoading ? const CustomLoader() : controller.planList.isEmpty ? const Center(
      child: NoDataFoundScreen(),
    ) : ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      itemCount: controller.planList.length,
      separatorBuilder: (context, index) => const SizedBox(height: Dimensions.space10),
      itemBuilder: (context, index) => FDRCard(index: index),
    ),);
  }
}
