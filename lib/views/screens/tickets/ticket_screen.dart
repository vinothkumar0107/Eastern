import 'package:eastern_trust/core/utils/util.dart';
import 'package:eastern_trust/data/controller/tickets/ticket_list_controller.dart';
import 'package:eastern_trust/data/repo/tickets/ticket_list_repo.dart';
import 'package:eastern_trust/views/screens/tickets/create_ticket/create_ticket.dart';
import 'package:eastern_trust/views/screens/tickets/reply_ticket.dart';
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

import '../../components/appbar/custom_appbar.dart';
import '../../components/bottom-nav-bar/bottom_nav_bar.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({Key? key}) : super(key: key);

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  final ScrollController scrollController = ScrollController();

  fetchData() {
    Get.find<TicketListController>().loadTicketData();
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (Get.find<TicketListController>().hasNext()) {
        fetchData();
      }
    }
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(TicketListRepo(apiClient: Get.find()));
    final controller = Get.put(TicketListController(ticketListRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadInitialTicketData();
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
    return GetBuilder<TicketListController>(
      builder: (controller) => WillPopWidget(
        child: Scaffold(
          backgroundColor: MyColor.colorWhite,
          appBar:CustomAppBar(title: MyStrings.supportTicket.tr, isShowBackBtn: false, isShowActionBtn: false, bgColor:  MyColor.getAppbarBgColor()),
          body: controller.isLoading
              ? const CustomLoader()
              : Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      top: Dimensions.space20,
                      left: Dimensions.space15,
                      right: Dimensions.space15,
                  bottom: Dimensions.space20),
                  decoration: BoxDecoration(
                    color: MyColor.colorWhite,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1), // Shadow color
                        spreadRadius: 0, // Spread radius
                        blurRadius: 5, // Blur radius
                        offset: const Offset(0, 2), // Shadow offset
                      ),
                    ],
                  ),

                  child: Container(
                    padding: const EdgeInsets.only(top: Dimensions.space15, left: Dimensions.space15, right: Dimensions.space15, bottom: Dimensions.space15),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.paddingSize10),
                      color: MyColor.liteBlueColor,
                      border: Border.all(
                        color: MyColor.liteGreyColorBorder, // Border color
                        width: 1.0, // Border width
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.0), // Shadow color
                          spreadRadius: 0, // Spread radius
                          blurRadius: 10, // Blur radius
                          offset: const Offset(0, 3), // Shadow offset
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(MyStrings.needHelp,style: interMediumDefault.copyWith(color:MyColor.colorBlack,fontSize: 14.0)),
                            Text(MyStrings.provideHelp,style: interRegularSmall.copyWith(color:MyColor.smallTextColor1,fontSize: 12.0))
                          ],
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.createTicketScreen);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 15.0),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [MyColor.appPrimaryColorSecondary2, MyColor.primaryColor2], // Set your gradient colors
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(20.0), // Set the corner radius
                            ),
                            child: Center(
                                child: Text(MyStrings.createTicket,style: interSemiBoldDefault.copyWith(color:MyColor.textColor,fontSize: 14.0))
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: Dimensions.space15),
                Expanded(
                  child: controller.ticketList.isEmpty
                      ? const NoDataFoundScreen(
                      title: MyStrings.noSupportTicketFound,
                      height: 0.8)
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
                      controller.ticketList.length + 1,
                      separatorBuilder: (context, index) =>
                      const SizedBox(
                          height: Dimensions.space10),
                      itemBuilder: (context, index)  {
                        if (controller.ticketList.length ==
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
                            // ReplyTicketScreen();
                            // DepositBottomSheet
                            //     .depositBottomSheet(
                            //         context, index);
                            // Get.toNamed(RouteHelper.replyTicketScreen);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReplyTicketScreen(selectedReply: controller.ticketList[index]),
                              ),
                            );
                          },
                          ticketID: '#${controller.ticketList[index].ticket}',
                          subject: controller.ticketList[index].subject,
                          lastReplyDate: controller.ticketList[index].lastReply,
                          status: controller.getStatusFromCode(controller.ticketList[index].status),
                          statusColor: controller
                              .getStatusColorFromCode(controller.ticketList[index].status),
                          headerRightColor: controller.getPriorityColorFromCode(controller.ticketList[index].priority),
                          priority: controller.getPriorityFromCode(controller.ticketList[index].priority),
                          selectedIndex: index,
                          headerLeftColor: MyColor.primaryColor2,
                          bodyLeftColor: MyColor.colorBlack,
                          bodyRightColor: MyColor.getGreyText(),
                          isNeedLeftHeaderBox: false,
                          isNeedLeftBodyBox: false,
                          isNeedRightHeaderBox: true,
                          isNeedRightBodyBox: false,
                          isNeedStatusBox: false,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: const CustomBottomNav(currentIndex: 1),
        ),
      ),
    );
  }
}
