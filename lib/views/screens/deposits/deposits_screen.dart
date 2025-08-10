import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/date_converter.dart';
import 'package:eastern_trust/core/helper/string_format_helper.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/data/controller/deposit/deposit_history_controller.dart';
import 'package:eastern_trust/data/repo/deposit/deposit_repo.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:eastern_trust/views/components/custom_loader.dart';
import 'package:eastern_trust/views/components/no_data/no_data_found_screen.dart';
import 'package:eastern_trust/views/components/will_pop_widget.dart';
import 'package:eastern_trust/views/screens/deposits/widget/custom_deposits_card.dart';
import 'package:eastern_trust/views/screens/deposits/widget/deposit_bottom_sheet.dart';
import 'package:eastern_trust/views/screens/deposits/widget/deposit_history_top.dart';

import 'new_deposit/new_deposit_screen.dart';

class DepositsScreen extends StatefulWidget {

  const DepositsScreen({Key? key}) : super(key: key);

  @override
  State<DepositsScreen> createState() => _DepositsScreenState();
}

class _DepositsScreenState extends State<DepositsScreen> {

  final ScrollController scrollController = ScrollController();

  fetchData() {
    Get.find<DepositController>().fetchNewList();
  }

  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if(Get.find<DepositController>().hasNext()){
        fetchData();
      }
    }
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(DepositRepo(apiClient: Get.find()));
    final controller = Get.put(DepositController(depositRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.beforeInitLoadData();
      scrollController.addListener(_scrollListener);
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    return GetBuilder<DepositController>(
      builder: (controller) => WillPopWidget(
        nextRoute: controller.isGoHome()?RouteHelper.homeScreen:'',
        isOnlyBack: controller.isGoHome()?false:true,
        child: Scaffold(
          backgroundColor: MyColor.containerBgColor,
          appBar: AppBar(
            title: Text(MyStrings.deposits, style: interSemiBoldOverLarge.copyWith(color: MyColor.colorWhite)),
            backgroundColor: MyColor.primaryColor,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [MyColor.primaryColor2, MyColor.primaryColor],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
            centerTitle: false,
            elevation: 0,
            leading: IconButton(
              onPressed: (){
                String previousRoute = Get.previousRoute;
                if(previousRoute==RouteHelper.menuScreen||previousRoute==RouteHelper.notificationScreen){
                  Get.back();
                } else{
                  Get.offAndToNamed(RouteHelper.homeScreen);
                }
              },
              icon: const Icon(Icons.arrow_back,
                  color: MyColor.colorWhite, size: 20),
            ),
            actions: [
              // GestureDetector(
              //   onTap: (){
              //     controller.changeIsPress();
              //   },
              //   child: Container(
              //       padding: const EdgeInsets.all(Dimensions.space7),
              //       decoration: const BoxDecoration(color: MyColor.colorWhite, shape: BoxShape.circle),
              //       child:  Icon(controller.isSearch?Icons.clear:Icons.search, color: MyColor.primaryColor, size: 15)
              //   ),
              // ),
              // const SizedBox(width: Dimensions.space7),
              TextButton(
                onPressed: () {
                  Get.toNamed(RouteHelper.newDepositScreenScreen);
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.space7, horizontal: Dimensions.space20),
                  backgroundColor: MyColor.colorWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                    side: const BorderSide(color: MyColor.primaryColor, width: 2), // Border with color and width
                  ),
                ),
                child: Text(
                  MyStrings.depositNow,
                  style: interSemiBoldDefault.copyWith(color: MyColor.primaryColor),
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
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DepositHistoryTop(),
                      SizedBox(height: Dimensions.space15),
                    ],
                  ),
                ),
                Expanded(
                  child: controller.depositList.isEmpty && controller.searchLoading == false ? NoDataFoundScreen(title:MyStrings.noDepositFound,height:controller.isSearch?0.75:0.8) :
                  controller.searchLoading ? const Center(
                    child: CustomLoader(),
                  ) : SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.separated(
                      shrinkWrap: true,
                      controller: scrollController,
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: controller.depositList.length+1,
                      separatorBuilder: (context, index) => const SizedBox(height: Dimensions.space10),
                      itemBuilder: (context, index) {
                        if(controller.depositList.length == index){
                          return controller.hasNext() ? SizedBox(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            child: const Center(
                              child: CustomLoader(),
                            ),
                          ) : const SizedBox();
                        }
                        return CustomDepositsCard(
                          onPressed: (){
                            DepositBottomSheet.depositBottomSheet(context,index);
                          },
                          trxValue: controller.depositList[index].trx ?? "",
                          date: DateConverter.isoToLocalDateAndTime(controller.depositList[index].createdAt ?? ""),
                          status:controller.getStatus(index),
                          statusBgColor:controller.getStatusColor(index),
                          amount: "${Converter.formatNumber(controller.depositList[index].amount ?? " ").makeCurrencyComma(precision: 2)} ${controller.currency}",
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
    );
  }
}
