import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_images.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/data/controller/transfer/transfer_controller.dart';
import 'package:eastern_trust/data/repo/transfer_repo/transfer_repo.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:eastern_trust/views/components/bottom-nav-bar/bottom_nav_bar.dart';
import 'package:eastern_trust/views/components/buttons/rounded_button.dart';
import 'package:eastern_trust/views/components/will_pop_widget.dart';

import '../../../components/appbar/custom_appbar.dart';
import '../../../components/divider/custom_divider.dart';
import '../../menu/widget/menu_card.dart';
import '../../menu/widget/menu_row_widget.dart';
import 'widget/transfer_card.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({Key? key}) : super(key: key);

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(TransferRepo(apiClient: Get.find()));
    final controller = Get.put(TransferController(repo: Get.find()));

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.checkWireTransferStatus();
    });
  }


  @override
  Widget build(BuildContext context) {

    return WillPopWidget(
      nextRoute: RouteHelper.homeScreen,
      child: Scaffold(
        backgroundColor: MyColor.containerBgColor,
        appBar: CustomAppBar(title: MyStrings.transfer.tr, isShowBackBtn: false, isShowActionBtn: false, bgColor:  MyColor.getAppbarBgColor()),
        body: GetBuilder<TransferController>(builder: (controller)=>SingleChildScrollView(
          padding: Dimensions.screenPaddingHV,
          child: Column(
            children: [
              MenuCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MenuRowWidget(
                      image: MyImages.myBankTransferIcon,
                      label: MyStrings.transferWithinViserBank,
                      onPressed: () => Get.toNamed(RouteHelper.myBankTransferScreen)
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Dimensions.space12),
              MenuCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MenuRowWidget(
                        image: MyImages.otherBankTransferIcon,
                        label: MyStrings.otherBank.tr,
                        onPressed: () => Get.toNamed(RouteHelper.otherBankTransferScreen)
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Dimensions.space12),
              MenuCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MenuRowWidget(
                        image: MyImages.wireTransferIcon,
                        label: MyStrings.wireTransfer.tr,
                        onPressed: () => Get.toNamed(RouteHelper.wireTransferScreen)
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Dimensions.space12),
              MenuCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MenuRowWidget(
                        image: MyImages.transferHistoryIcon,
                        label: MyStrings.transferHistory.tr,
                        onPressed: () => Get.toNamed(RouteHelper.transferHistoryScreen)
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
        bottomNavigationBar: const CustomBottomNav(currentIndex: 2),
      ),
    );
  }

}
