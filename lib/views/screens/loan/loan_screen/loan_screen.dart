import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/data/controller/loan/loan_controller.dart';
import 'package:eastern_trust/data/controller/loan/loan_list_controller.dart';
import 'package:eastern_trust/data/controller/loan/loan_plan_controller.dart';
import 'package:eastern_trust/data/repo/loan/loan_repo.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:eastern_trust/views/components/appbar/custom_appbar.dart';
import 'package:eastern_trust/views/components/tab/tab_container.dart';
import 'package:eastern_trust/views/components/will_pop_widget.dart';
import 'package:eastern_trust/views/screens/loan/loan-plan/loan_plan_screen.dart';
import 'package:eastern_trust/views/screens/loan/my-loan-list/loan_list_screen.dart';

import '../../../../core/utils/my_color.dart';

class LoanScreen extends StatefulWidget {
  const LoanScreen({Key? key}) : super(key: key);

  @override
  State<LoanScreen> createState() => _LoanScreenState();
}

class _LoanScreenState extends State<LoanScreen> {



  @override
  void initState() {

    final  arg = Get.arguments??'';
    Get.put(ApiClient(sharedPreferences: Get.find()));
    final controller = Get.put(LoanController());
    if(arg.toString().isNotEmpty){
      controller.isPlan = false;
    }
    Get.put(LoanRepo(apiClient: Get.find()));
    final planController = Get.put(LoanPlanController(loanRepo: Get.find()));
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoanRepo(apiClient: Get.find()));
    final planListController = Get.put(LoanListController(loanRepo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      planController.loadLoanPlan();
      planListController.initialSelectedValue();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoanController>(builder: (controller)=>WillPopWidget(
      nextRoute: controller.getPreviousRoute(),
      child: Scaffold(
        backgroundColor: MyColor.getScreenBgColor(),
        appBar: CustomAppBar(title: MyStrings.loan,isTitleCenter:false, isForceBackHome: controller.getPreviousRoute()!=RouteHelper.notificationScreen,),
        body: Padding(
          padding: Dimensions.screenPaddingHV,
          child: Column(
            children: [
             TabContainer(
               firstText:  MyStrings.loanPlan,
               firstTabPress:(){
                 controller.changeTab(true);
               },
               isFirstSelected: controller.isPlan,
               secondText:  MyStrings.myLoanList,
               secondTabPress: (){
                 controller.changeTab(false);
               },
              ),
              const SizedBox(height: Dimensions.space15),
            Expanded(
              child: controller.isPlan? const LoanPlanScreen() : const LoanListScreen(),
            ),
            ],
          ),
        ),
      ),
    ));
  }
}
