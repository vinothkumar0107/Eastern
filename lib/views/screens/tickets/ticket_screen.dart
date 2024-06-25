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
        child: SafeArea(
          child: Scaffold(
            backgroundColor: MyColor.containerBgColor,
            appBar: AppBar(
              title: Text(MyStrings.supportTicket,
                  style: interRegularLarge.copyWith(color: MyColor.colorWhite)),
              backgroundColor: MyColor.primaryColor,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  String previousRoute = Get.previousRoute;
                  if (previousRoute == RouteHelper.replyTicketScreen ||
                      previousRoute == RouteHelper.createTicketScreen) {
                    Get.offAndToNamed(RouteHelper.homeScreen);
                  }
                 else if (previousRoute == RouteHelper.menuScreen ||
                      previousRoute == RouteHelper.notificationScreen
                  ) {
                    // Get.back(); // Need to check
                    Get.offAndToNamed(RouteHelper.homeScreen);
                  } else {
                    Get.offAndToNamed(RouteHelper.homeScreen);
                  }
                },
                icon: const Icon(Icons.arrow_back,
                    color: MyColor.colorWhite, size: 20),
              ),
              actions: [
                GestureDetector(
                  onTap: (){
                    // controller.changeIsPress();
                  },
                  child: Container(
                      padding: const EdgeInsets.all(Dimensions.space7),
                      child:  Text(MyStrings.createTicket,style: interRegularDefault.copyWith(color:MyColor.textColor,fontSize: Dimensions.fontLarge)),

                  ),
                ),
                // const SizedBox(width: Dimensions.space7),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.createTicketScreen);
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
                                            ticketID: 'Ticket ID: #${controller.ticketList[index].ticket}',
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
                                           isNeedStatusBox: true,
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
