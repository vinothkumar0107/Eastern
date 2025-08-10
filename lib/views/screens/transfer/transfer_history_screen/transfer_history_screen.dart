import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/string_format_helper.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/data/controller/transfer/transfer_history_controller.dart';
import 'package:eastern_trust/data/repo/transfer_repo/transfer_repo.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:eastern_trust/views/components/appbar/custom_appbar.dart';
import 'package:eastern_trust/views/components/custom_loader.dart';
import 'package:eastern_trust/views/components/no_data/no_data_found.dart';
import 'package:eastern_trust/views/components/will_pop_widget.dart';
import 'package:eastern_trust/views/screens/transfer/transfer_history_screen/widget/transfer_history_bottom_sheet.dart';
import 'package:eastern_trust/views/screens/transfer/transfer_history_screen/widget/transfer_history_card.dart';

class TransferHistoryScreen extends StatefulWidget {
  const TransferHistoryScreen({Key? key}) : super(key: key);

  @override
  State<TransferHistoryScreen> createState() => _TransferHistoryScreenState();
}

class _TransferHistoryScreenState extends State<TransferHistoryScreen> {
  final ScrollController scrollController = ScrollController();

  fetchData() {
    Get.find<TransferHistoryController>().loadPaginationData();
  }

  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if(Get.find<TransferHistoryController>().hasNext()){
        fetchData();
      }
    }
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(TransferRepo(apiClient: Get.find()));
    final controller = Get.put(TransferHistoryController(repo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initialSelectedValue();
      scrollController.addListener(_scrollListener);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransferHistoryController>(builder: (controller)=>WillPopWidget(
      nextRoute: controller.isGoHome()?RouteHelper.homeScreen:'',
      isOnlyBack: controller.isGoHome()?false:true,
      child: Scaffold(
        backgroundColor: MyColor.containerBgColor,
        appBar: CustomAppBar(title: MyStrings.transferHistory,isForceBackHome: controller.isGoHome(),isTitleCenter: false,),
        body: controller.isLoading?const CustomLoader():
        controller.historyList.isEmpty? const NoDataWidget():
        Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimensions.screenPaddingV,horizontal: Dimensions.screenPaddingH),
          child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              controller: scrollController,
              itemCount: controller.historyList.length+1,
              separatorBuilder: (context, index) => const SizedBox(height: Dimensions.space10),
              itemBuilder: (context, index){
                if(controller.historyList.length == index){
                  return controller.hasNext() ? SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: CustomLoader(),
                    ),
                  ) : const SizedBox();
                }
                return TransferHistoryCard(
                    onPressed: (){
                      TransferHistoryBottomSheet().transferHistoryBottomSheet(context,index);
                    },
                    trxValue: controller.historyList[index].trx??'',
                    status: controller.getStatusAndColor(index),
                    statusBgColor: controller.getStatusAndColor(index,isStatus: false),
                    accountName:  controller.getAccountName(index),
                    amount: '${controller.currencySymbol}${Converter.formatNumber(controller.historyList[index].amount??'0').makeCurrencyComma()}'
                );}
          ),
        ),
      ),
    ));
  }
}
