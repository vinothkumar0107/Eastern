import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/data/controller/loan/loan_list_controller.dart';
import 'package:eastern_trust/views/components/custom_loader.dart';
import 'package:eastern_trust/views/components/no_data/no_data_found_screen.dart';
import 'package:eastern_trust/views/screens/loan/my-loan-list/widget/bottom_sheet.dart';
import 'package:eastern_trust/views/screens/loan/widget/loan_list_card.dart';

class LoanListScreen extends StatefulWidget {
  const LoanListScreen({Key? key}) : super(key: key);

  @override
  State<LoanListScreen> createState() => _LoanListScreenState();
}

class _LoanListScreenState extends State<LoanListScreen> {

  final ScrollController scrollController = ScrollController();

  void scrollListener(){
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
      if(Get.find<LoanListController>().hasNext()){
        Get.find<LoanListController>().loadPaginationData();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.addListener(scrollListener);
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return GetBuilder<LoanListController>(
      builder: (controller) {
        return controller.isLoading ? const CustomLoader() : controller.loanList.isEmpty ? const NoDataFoundScreen() :ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          controller: scrollController,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          itemCount: controller.loanList.length+1,
          separatorBuilder: (context, index) => const SizedBox(height: Dimensions.space10),
          itemBuilder: (context, index) {
            if(controller.loanList.length==index){
              return controller.hasNext()?const CustomLoader(isPagination:true): const SizedBox();
            }
            return LoanListCard(
              currency: controller.currency,
              planName: controller.loanList[index].plan?.name??'',
              statusColor: controller.getStatusAndColor(index,isStatus: false),
              status: controller.getStatusAndColor(index),
              amount: controller.loanList[index].amount??'',
              loanNumber: controller.loanList[index].loanNumber??'',
              press:(){
                LoanListBottomSheet().bottomSheet(context, index);
              },
            );
          },
        );
    });
  }
}
