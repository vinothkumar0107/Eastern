import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_images.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/core/utils/url.dart';
import 'package:eastern_trust/core/utils/util.dart';
import 'package:eastern_trust/data/controller/referral/referral_controller.dart';
import 'package:eastern_trust/data/repo/referral/referral_repo.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:eastern_trust/views/components/appbar/custom_appbar.dart';
import 'package:eastern_trust/views/components/column/label_column.dart';
import 'package:eastern_trust/views/components/custom_loader.dart';
import 'package:eastern_trust/views/components/no_data/no_data_found.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';

import '../../../core/helper/string_format_helper.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({Key? key}) : super(key: key);

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  final ScrollController scrollController = ScrollController();

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (Get.find<ReferralController>().hasNext()) {
        Get.find<ReferralController>().loadPaginationData();
      }
    }
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ReferralRepo(apiClient: Get.find()));
    final controller = Get.put(ReferralController(referralRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.page = 0;
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
    return GetBuilder<ReferralController>(
        builder: (controller) => SafeArea(
              child: Scaffold(
                backgroundColor: MyColor.getScreenBgColor(),
                appBar: const CustomAppBar(title: MyStrings.referral),
                body: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.space20,
                      horizontal: Dimensions.space15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        margin:
                            const EdgeInsets.only(bottom: Dimensions.space20),
                        padding: const EdgeInsets.symmetric(
                            vertical: Dimensions.space20,
                            horizontal: Dimensions.space15),
                        decoration: BoxDecoration(
                            color: MyColor.getCardBg(),
                            borderRadius:
                                BorderRadius.circular(Dimensions.cardMargin)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(MyImages.group_referral.tr),
                            const SizedBox(height: Dimensions.space10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 40,
                                    width: MediaQuery.of(context).size.width,
                                    child: DottedBorder(
                                      color: MyColor.getTextColor()
                                          .withOpacity(0.22),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Text(
                                            "${UrlContainer.domainUrl}?reference=${controller.referralRepo.apiClient.getCurrencyOrUsername(isCurrency: false)}",
                                            textAlign: TextAlign.start,
                                            style: interRegularDefault.copyWith(
                                                color: MyColor.getTextColor()),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: Dimensions.space7),
                                GestureDetector(
                                  onTap: () {
                                    Clipboard.setData(ClipboardData(
                                        text:
                                            "${UrlContainer.domainUrl}?reference=${controller.referralRepo.apiClient.getCurrencyOrUsername(isCurrency: false)}"));
                                    CustomSnackBar.success(
                                        successList: [MyStrings.copyLink]);
                                  },
                                  child: SvgPicture.asset(MyImages.referral_copy.tr,),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      controller.isLoading
                          ? const Expanded(child: CustomLoader())
                          : controller.dataList.isEmpty
                              ? const Expanded(child: NoDataWidget())
                              : Expanded(
                                  child: SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    controller: scrollController,
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    itemCount: controller.dataList.length + 1,
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 10),
                                    itemBuilder: (context, index) {
                                      if (controller.dataList.length == index) {
                                        return controller.hasNext()
                                            ? const CustomLoader(
                                                isPagination: true,
                                              )
                                            : const SizedBox();
                                      }

                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: Dimensions.space15,
                                            horizontal: Dimensions.space15),
                                        decoration: BoxDecoration(
                                            color: MyColor.getCardBg(),
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.defaultRadius),
                                            boxShadow: MyUtil.getCardShadow()),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 35,
                                              width: 35,
                                              alignment: Alignment.center,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: MyColor.primaryColor900,
                                              ),
                                              child: Text(
                                                Converter.addLeadingZero(
                                                    "${index + 1}"),
                                                textAlign: TextAlign.center,
                                                style:
                                                    interRegularLarge.copyWith(
                                                        color: MyColor
                                                            .getGreyText1(),
                                                        fontWeight:
                                                            FontWeight.w500),
                                              ),
                                            ),
                                            const SizedBox(
                                                width: Dimensions.space10),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                      flex: 3,
                                                      child: LabelColumn(
                                                        header: MyStrings
                                                            .username.tr,
                                                        body: controller
                                                            .dataList[index]
                                                            .username,
                                                      )),
                                                  Expanded(
                                                    flex: 2,
                                                    child: LabelColumn(
                                                      alignmentEnd: true,
                                                      header:
                                                          MyStrings.level.tr,
                                                      body: Converter
                                                          .getTrailingExtension(
                                                              int.tryParse(controller
                                                                      .dataList[
                                                                          index]
                                                                      .level) ??
                                                                  0),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                )),
                    ],
                  ),
                ),
              ),
            ));
  }
}

/*
* Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(MyStrings.username.tr,
                                          style: interRegularDefault.copyWith(color: MyColor.getPrimaryColor(), fontWeight: FontWeight.w600),
                                        ),
                                        Text(MyStrings.level.tr,
                                          style: interRegularDefault.copyWith(color: MyColor.getPrimaryColor(), fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          controller.dataList[index].username,
                                          style: interRegularDefault.copyWith(color: MyColor.getTextColor(), fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          Converter.getTrailingExtension(int.tryParse(controller.dataList[index].level)??0),
                                          style: interRegularDefault.copyWith(color: MyColor.getTextColor(), fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: Dimensions.space5),
                                  ],
                                )*/
