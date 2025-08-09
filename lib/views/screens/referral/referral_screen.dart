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
import '../../components/appbar/appbar_specific_device.dart';
import '../../components/will_pop_widget.dart';

class ReferralScreen extends StatefulWidget {

  const ReferralScreen({Key? key}) : super(key: key);

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {

  final ScrollController scrollController = ScrollController();

  void scrollListener(){
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
      if(Get.find<ReferralController>().hasNext()){
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

  // @override
  // Widget build2(BuildContext context) {
  //   return GetBuilder<ReferralController>(builder: (controller)=>Scaffold(
  //     backgroundColor: MyColor.getScreenBgColor(),
  //     appBar: const CustomAppBar(title: MyStrings.referral, isTitleCenter: false,),
  //     body: Padding(
  //       padding: const EdgeInsets.symmetric(vertical: Dimensions.space20, horizontal: Dimensions.space15),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Container(
  //             width: double.infinity,
  //             alignment: Alignment.center,
  //             margin: const EdgeInsets.only(bottom: Dimensions.space20),
  //             padding: const EdgeInsets.symmetric(vertical: Dimensions.space20, horizontal: Dimensions.space15),
  //             decoration: BoxDecoration(
  //                 color: MyColor.getCardBg(),
  //                 borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
  //                 boxShadow: MyUtil.getCardShadow()
  //             ),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Row(
  //                   children: [
  //                     Container(
  //                       height: 30, width: 30,
  //                       alignment: Alignment.center,
  //                       decoration: BoxDecoration(color: MyColor.primaryColor600, shape: BoxShape.circle),
  //                       child: SvgPicture.asset(MyImages.referral.tr, color: MyColor.primaryColor, height: 15, width: 15),
  //                     ),
  //                     const SizedBox(width: Dimensions.space15),
  //
  //                     Text(
  //                       MyStrings.referralLink.tr,
  //                       textAlign: TextAlign.left,
  //                       style: interRegularDefault.copyWith(color: MyColor.getTextColor()),
  //                     ),
  //                   ],
  //                 ),
  //                 const SizedBox(height: Dimensions.space10),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Expanded(
  //                       child: SizedBox(
  //                         height: 40,
  //                         width: MediaQuery.of(context).size.width,
  //                         child: DottedBorder(
  //                           color: MyColor.getTextColor().withOpacity(0.22),
  //                           child: Center(
  //                             child: Padding(
  //                               padding: const EdgeInsets.symmetric(horizontal: 15),
  //                               child: Text(
  //                                 "${UrlContainer.domainUrl}?reference=${controller.referralRepo.apiClient.getCurrencyOrUsername(isCurrency: false)}",
  //                                 textAlign: TextAlign.start,
  //                                 style: interRegularSmall.copyWith(color: MyColor.getTextColor()),
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                     const SizedBox(width: Dimensions.space20),
  //
  //                     GestureDetector(
  //                       onTap: (){
  //                         Clipboard.setData(ClipboardData(text:  "${UrlContainer.domainUrl}?reference=${controller.referralRepo.apiClient.getCurrencyOrUsername(isCurrency: false)}"));
  //                         CustomSnackBar.success(successList: [MyStrings.copyLink]);
  //                       },
  //                       child: Icon(Icons.copy, color: MyColor.getPrimaryColor(), size: 20),
  //                     )
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //
  //           controller.isLoading? const Expanded(child:  CustomLoader()):
  //           controller.dataList.isEmpty?const Expanded(child: NoDataWidget()):Expanded(
  //               child: SizedBox(
  //                 height: MediaQuery.of(context).size.height,
  //                 child: ListView.separated(
  //                   shrinkWrap: true,
  //                   controller: scrollController,
  //                   physics: const AlwaysScrollableScrollPhysics(),
  //                   itemCount: controller.dataList.length+1,
  //                   separatorBuilder: (context, index) => const SizedBox(height: 10),
  //                   itemBuilder: (context, index) {
  //
  //                     if(controller.dataList.length==index){
  //                       return controller.hasNext()?
  //                       const CustomLoader(isPagination: true,) : const SizedBox();
  //                     }
  //
  //                     return Container(
  //                       width: MediaQuery.of(context).size.width,
  //                       padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
  //                       decoration: BoxDecoration(
  //                           color: MyColor.getCardBg(),
  //                           borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
  //                           boxShadow: MyUtil.getCardShadow()
  //                       ),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           Container(
  //                             height: 35, width: 35,
  //                             alignment: Alignment.center,
  //                             decoration: const BoxDecoration(
  //                               shape: BoxShape.circle,
  //                               color: MyColor.primaryColor900,
  //                             ),
  //                             child: Text(
  //                               Converter.addLeadingZero("${index+1}"),
  //                               textAlign: TextAlign.center,
  //                               style: interRegularLarge.copyWith(color: MyColor.getGreyText1(), fontWeight: FontWeight.w500),
  //                             ),
  //                           ),
  //                           const SizedBox(width: Dimensions.space10),
  //                           Expanded(
  //                             child: Row(
  //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                               children: [
  //                                 Expanded(flex:3,child: LabelColumn(header: MyStrings.username.tr, body:  controller.dataList[index].username,)),
  //                                 Expanded(flex:2,child: LabelColumn(alignmentEnd:true,header: MyStrings.level.tr, body:  Converter.getTrailingExtension(int.tryParse(controller.dataList[index].level)??0),),)
  //                               ],
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     );
  //                   },
  //                 ),
  //               )
  //           ),
  //         ],
  //       ),
  //     ),
  //   ),);
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReferralController>(
      builder: (controller) => WillPopWidget(
        nextRoute: '',
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Scaffold(
            appBar: AppBarSpecificScreen.buildAppBar(),
            backgroundColor: MyColor.colorWhite,
            body: Stack(
              children: [
                const GradientView(gradientViewHeight: 6.5,isStaticHeight: true, staticHeightGradient: 150,),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 1.0),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      Expanded(
                        child: Text(
                            MyStrings.referral.tr,
                            textAlign: TextAlign.left,
                            style: interBoldOverLarge.copyWith(color: MyColor.colorWhite,decorationColor:MyColor.primaryColor)
                        ),
                      ),
                      // To keep the title centered, you can add an empty `SizedBox`
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10.0, 70.0, 10.0, 0.0),
                    child: SingleChildScrollView(
                      child: Form(
                        child: Column(
                          children: [
                            Card(
                              color: MyColor.colorWhite,
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 150, width: 200,
                                      alignment: Alignment.center,
                                      child: SvgPicture.asset(MyImages.referralImg.tr, height: MediaQuery.of(context).size.width * 0.4, width: MediaQuery.of(context).size.width * 0.6,),
                                    ),
                                    const SizedBox(height: 10),
                                    DottedBorder(
                                      color: MyColor.getTextColor().withOpacity(0.22), // ✅ correct param
                                      radius: const Radius.circular(Dimensions.paddingSize30),
                                      borderType: BorderType.RRect,
                                      strokeWidth: 1,
                                      dashPattern: const [6, 3],
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: MyColor.borderColor,
                                          borderRadius: BorderRadius.circular(Dimensions.paddingSize30),
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: 15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: SizedBox(
                                                height: 40,
                                                child: Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                                    child: Text(
                                                      "${UrlContainer.domainUrl}?reference=${controller.referralRepo.apiClient.getCurrencyOrUsername(isCurrency: false)}",
                                                      textAlign: TextAlign.start,
                                                      style: interRegularSmall.copyWith(
                                                        color: MyColor.getTextColor(),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: Dimensions.space10),
                                            GestureDetector(
                                              onTap: () {
                                                Clipboard.setData(
                                                  ClipboardData(
                                                    text: "${UrlContainer.domainUrl}?reference=${controller.referralRepo.apiClient.getCurrencyOrUsername(isCurrency: false)}",
                                                  ),
                                                );
                                                CustomSnackBar.success(successList: [MyStrings.copyLink]);
                                              },
                                              child: SvgPicture.asset(
                                                MyImages.copyImg.tr,
                                                height: 30,
                                                width: 30,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10), // Add spacing if needed
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: controller.dataList.isEmpty?360:320, // Adjust the top position based on your layout
                  left: 15,
                  right: 15,
                  child: controller.isLoading? const  CustomLoader():
                  controller.dataList.isEmpty?const NoDataWidget():Expanded(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.separated(
                          shrinkWrap: true,
                          controller: scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: controller.dataList.length+1,
                          separatorBuilder: (context, index) => const SizedBox(height: 10),
                          itemBuilder: (context, index) {

                            if(controller.dataList.length==index){
                              return controller.hasNext()?
                              const CustomLoader(isPagination: true,) : const SizedBox();
                            }

                            return Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
                              decoration: BoxDecoration(
                                  color: MyColor.getCardBg(),
                                  borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
                                  boxShadow: MyUtil.getCardShadow()
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 35, width: 35,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: MyColor.primaryColor900,
                                    ),
                                    child: Text(
                                      Converter.addLeadingZero("${index+1}"),
                                      textAlign: TextAlign.center,
                                      style: interRegularLarge.copyWith(color: MyColor.getGreyText1(), fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  const SizedBox(width: Dimensions.space10),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(flex:3,child: LabelColumn(header: MyStrings.username.tr, body:  controller.dataList[index].username,)),
                                        Expanded(flex:2,child: LabelColumn(alignmentEnd:true,header: MyStrings.level.tr, body:  Converter.getTrailingExtension(int.tryParse(controller.dataList[index].level)??0),),)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )
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
