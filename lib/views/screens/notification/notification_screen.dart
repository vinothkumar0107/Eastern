import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/date_converter.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/core/utils/util.dart';
import 'package:eastern_trust/data/controller/notifications/notification_controller.dart';
import 'package:eastern_trust/data/repo/notification_repo/notification_repo.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:eastern_trust/views/components/appbar/custom_appbar.dart';
import 'package:eastern_trust/views/components/custom_loader.dart';
import 'package:eastern_trust/views/components/no_data/no_data_found_screen.dart';

class NotificationScreen extends StatefulWidget {

  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  final ScrollController scrollController = ScrollController();

  void scrollListener(){
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
      if(Get.find<NotificationsController>().hasNext()){
        Get.find<NotificationsController>().initData();
      }
    }
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(NotificationRepo(apiClient: Get.find()));
    final controller = Get.put(NotificationsController(repo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.page = 0;
      controller.clickIndex = -1;
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

    return GetBuilder<NotificationsController>(builder: (controller)=>Scaffold(
      backgroundColor: MyColor.containerBgColor,
      appBar: const CustomAppBar(title: MyStrings.notification, isTitleCenter: false),
      body: controller.isLoading?const CustomLoader():controller.notificationList.isEmpty?const NoDataFoundScreen():Padding(
        padding: Dimensions.screenPaddingHV,
        child: ListView.separated(
          itemCount: controller.notificationList.length+1,
          scrollDirection: Axis.vertical,
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(height: Dimensions.space10),
          itemBuilder: (context, index){

            if(controller.notificationList.length==index){
              return controller.hasNext()?
              const CustomLoader(isPagination: true,) : const SizedBox();
            }

            return  GestureDetector(
              onTap: (){
                controller.markAsReadAndGotoThePage(index);
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
                  decoration: BoxDecoration(
                      color: controller.notificationList[index].view.toString()=='1'?MyColor.colorWhite:MyColor.primaryColor.withOpacity(.1),
                      borderRadius: BorderRadius.circular(Dimensions.defaultBorderRadius),
                      // boxShadow: MyUtil.getCardShadow(),
                      border: Border.all(
                       color: MyColor.liteGreyColorBorder, // Border color
                       width: 1.0, // Border width
                      ),
                  ),
                  child: controller.nextPageLoading && index == controller.clickIndex?const Center(child: CustomLoader(isPagination:true)) : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 35, width: 35,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: controller.getIconColor(controller.notificationList[index].remark.toString()),
                            ),
                            child: SvgPicture.asset(controller.getIcon(controller.notificationList[index].remark??''),color: MyColor.colorWhite,height: 20,width: 20,),
                          ),
                          const SizedBox(width: Dimensions.space10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(controller.notificationList[index].title?.tr??'', style: mulishRegular.copyWith(fontWeight: FontWeight.w500,fontSize: Dimensions.fontLarge)),
                              const SizedBox(height: Dimensions.space7,),
                              Text(DateConverter.isoToLocalDateAndTime(controller.notificationList[index].createdAt??''), style: interRegularSmall.copyWith(color: MyColor.smallTextColor2))
                            ],
                          ),
                        ],
                      ),

                    ],
                  )
              ),
            );
          },
        ),
      ),
    ));
  }
}
