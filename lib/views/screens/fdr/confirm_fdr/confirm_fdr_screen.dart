import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/string_format_helper.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/data/controller/fdr/fdr_confirm_controller.dart';
import 'package:eastern_trust/data/repo/fdr/fdr_repo.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:eastern_trust/views/components/appbar/custom_appbar.dart';
import 'package:eastern_trust/views/components/buttons/rounded_button.dart';
import 'package:eastern_trust/views/components/buttons/rounded_loading_button.dart';
import 'package:eastern_trust/views/components/custom_loader.dart';
import 'package:eastern_trust/views/screens/fdr/confirm_fdr/widget/preview_row.dart';

class ConfirmFDRScreen extends StatefulWidget {
  const ConfirmFDRScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmFDRScreen> createState() => _ConfirmFDRScreenState();
}

class _ConfirmFDRScreenState extends State<ConfirmFDRScreen> {

  @override
  void initState() {
    String verificationId = Get.arguments;
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(FDRRepo(apiClient: Get.find()));
    final controller = Get.put(FDRConfirmController(fdrPlanRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.verificationId = verificationId;
      controller.loadPreviewData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FDRConfirmController>(builder: (controller)=>Scaffold(
      backgroundColor: MyColor.getScreenBgColor(),
      appBar: const CustomAppBar(title: MyStrings.fdrApplicationPreview),
      body: controller.isLoading?const CustomLoader():SingleChildScrollView(
        padding: Dimensions.previewPaddingHV,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 25),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: MyColor.borderColor,width: 1)
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(MyStrings.youHaveRequestToInvestMsg.tr,style: interSemiBold.copyWith(fontSize: Dimensions.fontLarge)),
              Text('(${MyStrings.beSureBeforeConfirm.tr})',style: interRegularDefault.copyWith(color: MyColor.colorRed),),
              const SizedBox(height: 25,),
              PreviewRow(firstText: MyStrings.plan, secondText: controller.plan?.name??''),
              PreviewRow(firstText: MyStrings.profitRate, secondText: '${Converter.roundDoubleAndRemoveTrailingZero(controller.plan?.interestRate??'0')}%'),
              PreviewRow(firstText: MyStrings.amount, secondText: '${controller.currencySymbol}${controller.amount.makeCurrencyComma()}'),
              PreviewRow(firstText: '${MyStrings.profitInEvery.tr} ${controller.plan?.installmentInterval??'-'} ${MyStrings.days.tr}', secondText: '${controller.currencySymbol}${controller.getProfitAmount().makeCurrencyComma()}'),
              PreviewRow(firstText: MyStrings.cannotBeWithdrawTill, secondText: controller.withdrawAvailableTil,showDivider: false,),
              const SizedBox(height: 35,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: RoundedButton(color:MyColor.colorBlack,text: MyStrings.cancel.tr, press:(){
                    controller.cancelFDRRequest();
                  })),
                  const SizedBox(width: 25),
                  Expanded(child: controller.isSubmitLoading?
                  const RoundedLoadingBtn():
                  RoundedButton(
                      color:MyColor.primaryColor,
                      text: MyStrings.confirm.tr,
                      press:(){
                      controller.confirmFDRRequest();
                  }))
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
