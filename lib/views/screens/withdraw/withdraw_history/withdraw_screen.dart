import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/date_converter.dart';
import 'package:eastern_trust/core/helper/string_format_helper.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/data/controller/withdraw/withdraw_history_controller.dart';
import 'package:eastern_trust/data/repo/withdraw/withdraw_history_repo.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:eastern_trust/views/components/custom_loader.dart';
import 'package:eastern_trust/views/components/no_data/no_data_found_screen.dart';
import 'package:eastern_trust/views/components/will_pop_widget.dart';
import 'package:eastern_trust/views/screens/withdraw/widget/custom_withdraw_card.dart';
import 'package:eastern_trust/views/screens/withdraw/widget/withdraw_bottom_sheet.dart';
import 'package:eastern_trust/views/screens/withdraw/widget/withdraw_history_top.dart';

class WithdrawScreen extends StatefulWidget {

  const WithdrawScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {

  final ScrollController scrollController = ScrollController();

  void scrollListener(){
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
      if(Get.find<WithdrawHistoryController>().hasNext()){
        Get.find<WithdrawHistoryController>().loadPaginationData();
      }
    }
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(WithdrawHistoryRepo(apiClient: Get.find()));
    final controller = Get.put(WithdrawHistoryController(withdrawHistoryRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initData();
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
    return GetBuilder<WithdrawHistoryController>(
      builder: (controller) => WillPopWidget(
        nextRoute: controller.isGoHome()?RouteHelper.homeScreen:'',
        isOnlyBack: controller.isGoHome()?false:true,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: MyColor.containerBgColor,
            appBar: AppBar(
              title: Text(MyStrings.withdrawals.tr, style: interRegularLarge.copyWith(color: MyColor.colorWhite)),
              backgroundColor: MyColor.primaryColor,
              elevation: 0,
              leading: IconButton(
                onPressed: (){
                  String previousRoute = Get.previousRoute;
                  if(previousRoute==RouteHelper.menuScreen){
                    Get.back();
                  } else{
                    Get.offAndToNamed(RouteHelper.homeScreen);
                  }
                },
                icon: const Icon(Icons.arrow_back,
                    color: MyColor.colorWhite, size: 20),
              ),
              actions: [

                GestureDetector(
                  onTap: (){
                    controller.changeSearchStatus();
                  },
                  child: Container(
                      padding: const EdgeInsets.all(Dimensions.space7),
                      decoration: const BoxDecoration(color: MyColor.colorWhite, shape: BoxShape.circle),
                      child:  Icon(controller.isSearch?Icons.clear:Icons.search, color: MyColor.primaryColor, size: 15) ,
                  ),
                ),
                const SizedBox(width: Dimensions.space7),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.addWithdrawMethodScreen);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 7,right: 10,bottom: 7,top: 7),
                    padding: const EdgeInsets.all(Dimensions.space7),
                    decoration: const BoxDecoration(color: MyColor.colorWhite, shape: BoxShape.circle),
                    child:  const Icon(Icons.add, color: MyColor.primaryColor, size: 15),
                  ),
                ),
                const SizedBox(width: Dimensions.space15),
              ],
            ),
            body: controller.isLoading ? const CustomLoader() : Padding(
              padding: const EdgeInsets.only(top: Dimensions.space20, left: Dimensions.space15, right: Dimensions.space15),
              child: Column(
                children: [
                  Visibility(
                    visible: controller.isSearch,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        WithdrawHistoryTop(),
                        SizedBox(height: Dimensions.space10),
                      ],
                    ),
                  ),
                  Expanded(
                    child: controller.withdrawList.isEmpty && controller.filterLoading == false ? const Center(
                      child: NoDataFoundScreen(),
                    ) : controller.filterLoading ? const CustomLoader() : SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: controller.withdrawList.length+1,
                        controller: scrollController,
                        separatorBuilder: (context, index) => const SizedBox(height: Dimensions.space10),
                        itemBuilder: (context, index){
                          if (index == controller.withdrawList.length) {
                            return controller.hasNext()
                                ? const CustomLoader(isPagination: true,)
                                : const SizedBox();
                          }
                          return CustomWithdrawCard(
                            onPressed: (){
                              WithdrawBottomSheet().withdrawBottomSheet(index,context,controller.currency);
                            },
                            trxValue: controller.withdrawList[index].trx ?? "",
                            date: DateConverter.isoToLocalDateAndTime(controller.withdrawList[index].createdAt ?? ""),
                            status: controller.getStatus(index),
                            statusBgColor: controller.getColor(index),
                            amount: "${Converter.formatNumber(controller.withdrawList[index].finalAmount ?? " ")} ${controller.currency}",
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
