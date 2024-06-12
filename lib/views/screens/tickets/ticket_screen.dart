import 'package:eastern_trust/core/utils/util.dart';
import 'package:eastern_trust/views/screens/tickets/tickets_design.dart';
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

class TicketScreen extends StatefulWidget {
  const TicketScreen({Key? key}) : super(key: key);

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  final ScrollController scrollController = ScrollController();

  fetchData() {
    Get.find<DepositController>().fetchNewList();
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (Get.find<DepositController>().hasNext()) {
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
        nextRoute: controller.isGoHome() ? RouteHelper.homeScreen : '',
        isOnlyBack: controller.isGoHome() ? false : true,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: MyColor.containerBgColor,
            appBar: AppBar(
              title: Text(MyStrings.ticket,
                  style: interRegularLarge.copyWith(color: MyColor.colorWhite)),
              backgroundColor: MyColor.primaryColor,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  String previousRoute = Get.previousRoute;
                  if (previousRoute == RouteHelper.menuScreen ||
                      previousRoute == RouteHelper.notificationScreen) {
                    Get.back();
                  } else {
                    Get.offAndToNamed(RouteHelper.homeScreen);
                  }
                },
                icon: const Icon(Icons.arrow_back,
                    color: MyColor.colorWhite, size: 20),
              ),
              actions: [
                const SizedBox(width: Dimensions.space7),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.newDepositScreenScreen);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                        left: 7, right: 10, bottom: 7, top: 7),
                    padding: const EdgeInsets.all(Dimensions.space7),
                    decoration: const BoxDecoration(
                        color: MyColor.colorWhite, shape: BoxShape.circle),
                    child: const Icon(Icons.add,
                        color: MyColor.primaryColor, size: 15),
                  ),
                ),
              ],
            ),
            body: controller.isLoading
                ? const CustomLoader()
                : Padding(
                    padding: const EdgeInsets.only(
                        top: Dimensions.space5,
                        left: Dimensions.space5,
                        right: Dimensions.space5),
                    child: Column(
                      children: [
                        Visibility(
                          visible: controller.isSearch,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              DepositHistoryTop(),
                              SizedBox(height: Dimensions.space15),
                            ],
                          ),
                        ),
                        Expanded(
                          child: controller.depositList.isEmpty &&
                                  controller.searchLoading == false
                              ? NoDataFoundScreen(
                                  title: MyStrings.noDepositFound,
                                  height: controller.isSearch ? 0.75 : 0.8)
                              : controller.searchLoading
                                  ? const Center(
                                      child: CustomLoader(),
                                    )
                                  : SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: ListView.separated(
                                        shrinkWrap: true,
                                        controller: scrollController,
                                        scrollDirection: Axis.vertical,
                                        physics: const BouncingScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        itemCount:
                                            controller.depositList.length + 1,
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(
                                                height: Dimensions.space10),
                                        itemBuilder: (context, index) {
                                          if (controller.depositList.length ==
                                              index) {
                                            return controller.hasNext()
                                                ? SizedBox(
                                                    height: 40,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: const Center(
                                                      child: CustomLoader(),
                                                    ),
                                                  )
                                                : const SizedBox();
                                          }
                                          return TicketDesign(
                                            onPressed: () {
                                              DepositBottomSheet
                                                  .depositBottomSheet(
                                                      context, index);
                                            },
                                            trxValue: index.toString() ??
                                                "",
                                            date: DateConverter
                                                .isoToLocalDateAndTime(
                                                    controller
                                                        .depositList[index]
                                                            .createdAt ??
                                                        ""),
                                            status: controller.getStatus(index),
                                            statusBgColor: controller
                                                .getStatusColor(index),
                                            amount:
                                                "${Converter.formatNumber(controller.depositList[index].amount ?? " ")} ${controller.currency}",
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

class TicketTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ElevatedButton(
        //   onPressed: () {},
        //   child: Text('+ Create Ticket'),
        // ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(
              vertical: Dimensions.space5, horizontal: Dimensions.space5),
          decoration: BoxDecoration(
              color: MyColor.colorWhite,
              borderRadius:
                  BorderRadius.circular(Dimensions.defaultBorderRadius),
              boxShadow: MyUtil.getCardShadow()),
          child: Table(
            children: [
              TableRow(
                decoration: BoxDecoration(color: MyColor.primaryColor2),
                children: [
                  TableCell(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('S.N.',
                        style: interRegularSmall.copyWith(
                            color: MyColor.colorWhite)),
                  )),
                  TableCell(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('SUBJECT',
                        style: interRegularSmall.copyWith(
                            color: MyColor.colorWhite)),
                  )),
                  TableCell(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('STATUS',
                        style: interRegularSmall.copyWith(
                            color: MyColor.colorWhite)),
                  )),
                  TableCell(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('PRIORITY',
                        style: interRegularSmall.copyWith(
                            color: MyColor.colorWhite)),
                  )),
                  TableCell(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('LAST REPLY',
                        style: interRegularSmall.copyWith(
                            color: MyColor.colorWhite)),
                  )),
                  TableCell(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('ACTION',
                        style: interRegularSmall.copyWith(
                            color: MyColor.colorWhite)),
                  )),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  TableRow _buildTableRow(String sn, String subject, String status,
      String priority, String lastReply, String action) {
    return TableRow(
      children: [
        TableCell(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(sn,
              style: interRegularSmall.copyWith(color: MyColor.colorBlack)),
        )),
        TableCell(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(subject,
              style: interRegularSmall.copyWith(color: MyColor.primaryColor)),
        )),
        TableCell(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(4.0),
            child: Text(status,
                style: interRegularSmall.copyWith(color: MyColor.colorBlack)),
          ),
        )),
        TableCell(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(4.0),
            child: Text(priority,
                style: interRegularSmall.copyWith(color: MyColor.red)),
          ),
        )),
        TableCell(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(lastReply,
              style: interRegularSmall.copyWith(color: MyColor.colorGrey)),
        )),
        TableCell(
            child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: InkWell(
            onTap: () => Get.toNamed(RouteHelper.editProfileScreen),
            child: Container(
              margin: const EdgeInsetsDirectional.only(start: 1),
              height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 1),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.defaultRadius)
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: Dimensions.space5, horizontal: Dimensions.space10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: MyColor.transparentColor,
                        borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
                        border: Border.all(color: MyColor.primaryColor, width: 0.5)
                    ),
                    child: Text(action.tr, textAlign: TextAlign.center, style: interRegularSmall.copyWith(color: MyColor.primaryColor)),
                  )

                ],
              ),
            ),
          )
        )),
      ],
    );
  }
}
