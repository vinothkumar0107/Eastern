import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/data/controller/fdr/fdr_plan_controller.dart';
import 'package:eastern_trust/data/repo/fdr/fdr_repo.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:eastern_trust/views/components/custom_loader.dart';
import 'package:eastern_trust/views/components/no_data/no_data_found_screen.dart';
import 'package:eastern_trust/views/screens/fdr/fdr-plan/widget/fdr_card.dart';


class FDRPlanScreen extends StatefulWidget {
  const FDRPlanScreen({Key? key}) : super(key: key);

  @override
  State<FDRPlanScreen> createState() => _FDRPlanScreenState();
}

class _FDRPlanScreenState extends State<FDRPlanScreen> {

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(FDRRepo(apiClient: Get.find()));
    Get.put(FDRPlanController(fdrPlanRepo: Get.find()));
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<FDRPlanController>(
      builder: (controller) =>  controller.isLoading ? const CustomLoader() : controller.planList.isEmpty ? const Center(
          child: NoDataFoundScreen(),
        ) : ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          itemCount: controller.planList.length,
          separatorBuilder: (context, index) => const SizedBox(height: Dimensions.space10),
          itemBuilder: (context, index) => FDRCard(index: index),
        ),
    );
  }
}
