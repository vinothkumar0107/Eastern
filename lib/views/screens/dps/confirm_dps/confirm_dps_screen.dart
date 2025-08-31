import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/string_format_helper.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/data/controller/dps/dps_confirm_controller.dart';
import 'package:eastern_trust/data/repo/dps/dps_repo.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:eastern_trust/views/components/appbar/custom_appbar.dart';
import 'package:eastern_trust/views/components/buttons/rounded_button.dart';
import 'package:eastern_trust/views/components/buttons/rounded_loading_button.dart';
import 'package:eastern_trust/views/components/custom_loader.dart';
import 'package:eastern_trust/views/screens/fdr/confirm_fdr/widget/preview_row.dart';

import '../../../../core/route/route.dart';
import '../../../components/appbar/appbar_specific_device.dart';
import '../../../components/will_pop_widget.dart';

class ConfirmDPSScreen extends StatefulWidget {
  const ConfirmDPSScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmDPSScreen> createState() => _ConfirmDPSScreenState();
}

class _ConfirmDPSScreenState extends State<ConfirmDPSScreen> {

  @override
  void initState() {
    String verificationId = Get.arguments;
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(DPSRepo(apiClient: Get.find()));
    final controller = Get.put(DPSConfirmController(dpsRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.verificationId = verificationId;
      controller.loadPreviewData();
    });
  }

  @override
  Widget build2(BuildContext context) {
    return GetBuilder<DPSConfirmController>(builder: (controller)=>Scaffold(
      backgroundColor: MyColor.getScreenBgColor(),
      appBar: const CustomAppBar(title: MyStrings.dpsApplicationPreview, isTitleCenter: false,),
      body: controller.isLoading?const CustomLoader():Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 25),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: MyColor.borderColor,width: 1),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(MyStrings.youHaveRequestToDPSInvestMsg.tr,style: interSemiBold.copyWith(fontSize: Dimensions.fontLarge)),
                Text('(${MyStrings.beSureBeforeConfirm.tr})',style: interRegularDefault.copyWith(color: MyColor.colorRed),),
                const SizedBox(height: 25,),
                PreviewRow(firstText: MyStrings.plan, secondText: controller.plan?.name??''),
                PreviewRow(firstText: MyStrings.installmentInterval, secondText: '${controller.plan?.installmentInterval??''} ${MyStrings.days}'),
                PreviewRow(firstText: MyStrings.totalInstallment, secondText: controller.plan?.totalInstallment??''),
                PreviewRow(firstText: MyStrings.perInstallment, secondText: '${controller.currencySymbol}${Converter.formatNumber(controller.plan?.perInstallment??'')}'),
                PreviewRow(firstText: MyStrings.totalDeposit, secondText: '${controller.currencySymbol}${controller.getDepositAmount()}'),
                PreviewRow(firstText: MyStrings.profitRate, secondText: '${Converter.roundDoubleAndRemoveTrailingZero(controller.plan?.interestRate??'0')}%'),
                PreviewRow(firstText: MyStrings.withdrawableAmount, secondText: '${controller.currencySymbol}${Converter.formatNumber(controller.plan?.finalAmount??'')}',showDivider: false),
                const SizedBox(height: 15,),
                Text('* ${MyStrings.ifAnInstallmentIsDelayedFor.tr} ${controller.plan?.delayValue??'1'} ${MyStrings.orMoreDaysThen.tr} ${controller.currencySymbol}${controller.delayCharge} ${MyStrings.willBeAppliedForEachDay.tr}'.tr,style: interRegularDefault.copyWith(fontSize:Dimensions.fontSmall,color: MyColor.redCancelTextColor),),
                const SizedBox(height: 8),
                Text('* ${MyStrings.totalChargeAmountMsg.tr}',style: interRegularDefault.copyWith(color: MyColor.redCancelTextColor,fontSize: Dimensions.fontSmall),),
                const SizedBox(height: 35,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: RoundedButton(color:MyColor.colorBlack,text: MyStrings.cancel.tr, press:(){
                      controller.cancelDPSRequest();
                    })),
                    const SizedBox(width: 25),
                    Expanded(child: controller.isSubmitLoading?
                    const RoundedLoadingBtn():
                    RoundedButton(
                        color:MyColor.primaryColor,
                        text: MyStrings.confirm.tr,
                        press:(){
                        controller.confirmDPSRequest();
                    }))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DPSConfirmController>(
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
            backgroundColor: MyColor.appPrimaryColorSecondary2,
            body: Stack(
              children: [
                const GradientView(gradientViewHeight: 3.5),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                      Expanded(
                        child: Text(
                            MyStrings.dpsApplicationPreview,
                            textAlign: TextAlign.left,
                            style: interSemiBoldOverLarge.copyWith(color: MyColor.colorWhite,decorationColor:MyColor.primaryColor)
                        ),
                      ),
                      // To keep the title centered, you can add an empty `SizedBox`
                      const SizedBox(width: 48.0),
                    ],
                  ),
                ),
                controller.isLoading ?
                const Center(
                    child: CircularProgressIndicator(color: MyColor.primaryColor)
                ) :
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(15.0, 70.0, 15.0, 0.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Card(
                            color: MyColor.colorWhite,
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: controller.isLoading?const CustomLoader():Center(
                                  child: SingleChildScrollView(
                                    child:  Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(MyStrings.youHaveRequestToDPSInvestMsg.tr,style: interSemiBold.copyWith(fontSize: Dimensions.fontLarge)),
                                        Text('(${MyStrings.beSureBeforeConfirm.tr})',style: interRegularDefault.copyWith(color: MyColor.colorRed),),
                                        const SizedBox(height: 25,),
                                        PreviewRow(firstText: MyStrings.plan, secondText: controller.plan?.name??''),
                                        PreviewRow(firstText: MyStrings.installmentInterval, secondText: '${controller.plan?.installmentInterval??''} ${MyStrings.days}'),
                                        PreviewRow(firstText: MyStrings.totalInstallment, secondText: controller.plan?.totalInstallment??''),
                                        PreviewRow(firstText: MyStrings.perInstallment, secondText: '${controller.currencySymbol}${Converter.formatNumber(controller.plan?.perInstallment??'').makeCurrencyComma()}'),
                                        PreviewRow(firstText: MyStrings.totalDeposit, secondText: '${controller.currencySymbol}${controller.getDepositAmount().makeCurrencyComma()}'),
                                        PreviewRow(firstText: MyStrings.profitRate, secondText: '${Converter.roundDoubleAndRemoveTrailingZero(controller.plan?.interestRate??'0')}%'),
                                        PreviewRow(firstText: MyStrings.withdrawableAmount, secondText: '${controller.currencySymbol}${Converter.formatNumber(controller.plan?.finalAmount??'').makeCurrencyComma()}',showDivider: false),
                                        const SizedBox(height: 15,),
                                        Text('* ${MyStrings.ifAnInstallmentIsDelayedFor.tr} ${controller.plan?.delayValue??'1'} ${MyStrings.orMoreDaysThen.tr} ${controller.currencySymbol}${controller.delayCharge} ${MyStrings.willBeAppliedForEachDay.tr}'.tr,style: interRegularDefault.copyWith(fontSize:Dimensions.fontSmall,color: MyColor.redCancelTextColor),),
                                        const SizedBox(height: 8),
                                        Text('* ${MyStrings.totalChargeAmountMsg.tr}',style: interRegularDefault.copyWith(color: MyColor.redCancelTextColor,fontSize: Dimensions.fontSmall),),
                                        const SizedBox(height: 35,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(child: RoundedButton(color:MyColor.colorBlack,text: MyStrings.cancel.tr, press:(){
                                              controller.cancelDPSRequest();
                                            })),
                                            const SizedBox(width: 25),
                                            Expanded(child: controller.isSubmitLoading?
                                            const RoundedLoadingBtn():
                                            RoundedButton(
                                                color:MyColor.primaryColor,
                                                text: MyStrings.confirm.tr,
                                                press:(){
                                                  controller.confirmDPSRequest();
                                                }))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                            ),
                          ),
                          const SizedBox(height: Dimensions.space20), // Add spacing if needed
                        ],
                      ),
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
