import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/data/controller/dps/dps_controller.dart';
import 'package:eastern_trust/data/controller/dps/dps_list_controller.dart';
import 'package:eastern_trust/data/controller/dps/dps_plan_controller.dart';
import 'package:eastern_trust/data/repo/dps/dps_repo.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:eastern_trust/views/components/appbar/custom_appbar.dart';
import 'package:eastern_trust/views/components/tab/tab_container.dart';
import 'package:eastern_trust/views/components/will_pop_widget.dart';
import 'package:eastern_trust/views/screens/dps/dps-plan/dps_plan_screen.dart';
import 'package:eastern_trust/views/screens/dps/my-dps-list-screen/dps_list_screen.dart';

import '../../../../core/utils/my_strings.dart';

class DPSScreen extends StatefulWidget {
  const DPSScreen({Key? key}) : super(key: key);

  @override
  State<DPSScreen> createState() => _DPSScreenState();
}

class _DPSScreenState extends State<DPSScreen> {



  @override
  void initState() {
   final arg = Get.arguments??'';
    Get.put(ApiClient(sharedPreferences: Get.find()));
    final controller = Get.put(DPSController());

    if(arg.toString().isNotEmpty){
      controller.isPlan = false;
    }

    Get.put(DPSRepo(apiClient: Get.find()));
    final dpsPlanController = Get.put(DPSPlanController(dpsRepo: Get.find()));
    final dpsListController = Get.put(DPSListController(dpsRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      dpsPlanController.loadDPSPlanData();
      dpsListController.initialSelectedValue();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DPSController>(builder: (controller)=>WillPopWidget(
      nextRoute: controller.getPreviousRoute(),
      child: Scaffold(
        backgroundColor: MyColor.liteGreyColor,
        appBar: CustomAppBar(title: MyStrings.dps, isTitleCenter: false, isForceBackHome: controller.getPreviousRoute()!=RouteHelper.notificationScreen,),
        body: Padding(
          padding: Dimensions.screenPaddingHV,
          child: Column(
            children: [
              TabContainer(
                firstText:  MyStrings.dpsPlan.tr,
                firstTabPress:(){
                  controller.changeTab(true);
                },
                isFirstSelected: controller.isPlan,
                secondText:  MyStrings.myDpsLists,
                secondTabPress: (){
                  controller.changeTab(false);
                },
              ),
              const SizedBox(height: Dimensions.space15),
              Expanded(
                child: controller.isPlan? const DPSPlanScreen() : const DPSListScreen(),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
