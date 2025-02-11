import 'dart:convert';

import 'package:eastern_trust/core/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/data/controller/loan/loan_confirm_controller.dart';
import 'package:eastern_trust/data/repo/loan/loan_repo.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:eastern_trust/views/components/appbar/custom_appbar.dart';
import 'package:eastern_trust/views/components/buttons/rounded_button.dart';
import 'package:eastern_trust/views/components/buttons/rounded_loading_button.dart';
import 'package:eastern_trust/views/components/checkbox/custom_check_box.dart';
import 'package:eastern_trust/views/components/custom_loader.dart';
import 'package:eastern_trust/views/components/custom_radio_button.dart';
import 'package:eastern_trust/views/components/divider/custom_divider.dart';
import 'package:eastern_trust/views/components/row_item/form_row.dart';
import 'package:eastern_trust/views/components/text-field/custom_drop_down_button_with_text_field.dart';
import 'package:eastern_trust/views/components/text-field/custom_text_field.dart';
import 'package:eastern_trust/views/screens/fdr/confirm_fdr/widget/preview_row.dart';
import 'package:eastern_trust/views/screens/withdraw/confirm_withdraw_screen/widget/choose_file_list_item.dart';

import '../../../../data/model/dynamic_form/form.dart';
import '../../../../data/model/loan/loan_preview_response_model.dart';
import '../widget/loan_card.dart';
import '../widget/loan_list_card.dart';

class LoanConfirmScreen extends StatefulWidget {
  const LoanConfirmScreen({Key? key}) : super(key: key);

  @override
  State<LoanConfirmScreen> createState() => _LoanConfirmScreenState();
}

class _LoanConfirmScreenState extends State<LoanConfirmScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoanRepo(apiClient: Get.find()));
    final controller = Get.put(LoanConfirmController(repo: Get.find()));
    LoanPreviewResponseModel model = Get.arguments;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData(model);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoanConfirmController>(
        builder: (controller) => Scaffold(
            backgroundColor: MyColor.getScreenBgColor1(),
            appBar: const CustomAppBar(title: MyStrings.applyForLoan, isTitleCenter: false,),
            body: controller.isLoading
                ? const CustomLoader()
                : SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: Dimensions.screenPaddingHV,
                decoration: BoxDecoration(
                    color: MyColor.getScreenBgColor2(),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: MyUtil.getBottomSheetShadow()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LoanCard(
                      isFromLoanConfirmation: true,
                        index: 1,
                        cardStatusTitle: controller.planName ?? '',
                        percentRate: controller.perInstallmentPercentage ?? '0',
                        takeMin: '',
                        takeMax: ' ${controller.currencySymbol}${controller.maximumAmount}',
                        perInstallment: controller.perInstallmentPercentage ?? '0',
                        installmentInterval: controller.installmentInterval ?? '',
                        totalInstallment: controller.totalInstallment ?? '',
                        onPressed: () {

                        }
                    ),
                    const SizedBox(height: 20,),
                    Flexible(
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 25),
                            decoration: BoxDecoration(
                              color: MyColor.getScreenBgColor2(),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: MyColor.borderColor, width: .5),
                                boxShadow: MyUtil.getBottomSheetShadow()),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(MyStrings.youAreApplyingToTakeLoan.tr, style: header),
                                  Text('(${MyStrings.beSureBeforeConfirm.tr})', style: interRegularDefault.copyWith(color: MyColor.primaryColor2, fontSize: Dimensions.fontSmall12),),
                                  const SizedBox(height: 25,),
                                  PreviewRow(firstText: MyStrings.planName, secondText: controller.planName, showDivider: false,),
                                  PreviewRow(firstText: MyStrings.loanAmount, secondText: '${controller.currencySymbol}${controller.amount}',showDivider: false,),
                                  PreviewRow(firstText: MyStrings.totalInstallment, secondText: controller.totalInstallment,showDivider: false,),
                                  PreviewRow(firstText: MyStrings.perInstallment, secondText: '${controller.currencySymbol}${controller.perInstallment}',showDivider: false,),
                                  PreviewRow(firstText: MyStrings.youNeedToPay, secondText: '${controller.currencySymbol}${controller.youNeedToPay}',showDivider: false,),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      '*${controller.chargeText}',
                                      style: interRegularDefault.copyWith(
                                          color: MyColor.primaryColor2, fontSize: Dimensions.fontSmall12),
                                    ),
                                  )
                                ]))),
                    const SizedBox(height: 20,),
                controller.formList.isNotEmpty ?  Flexible(
                      child:  Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 25),
                        decoration: BoxDecoration(
                            color: MyColor.getScreenBgColor2(),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: MyColor.borderColor, width: .5),
                            boxShadow: MyUtil.getBottomSheetShadow()),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(MyStrings.applicationForm.tr,style: header),
                            const CustomDivider(space: 15,),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: controller.formList.length,
                                itemBuilder: (ctx, index) {
                                  FormModel? model = controller.formList[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        model.type == 'text'
                                            ? Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomTextField(
                                                disableColor : MyColor.borderColor,
                                                hintText: '${((model.name ?? '').capitalizeFirst)?.tr}',
                                                needLabel: true,
                                                needOutlineBorder: true,
                                                labelText: (model.name ?? '').tr,
                                                isRequired: model.isRequired == 'optional' ? false : true,
                                                onChanged: (value) {
                                                  controller.changeSelectedValue(value, index);
                                                }),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        )
                                            : model.type == 'textarea'
                                            ? Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomTextField(
                                                needLabel: true,
                                                needOutlineBorder: true,
                                                labelText: (model.name ?? '').tr,
                                                isRequired: model.isRequired == 'optional'? false: true,
                                                hintText: '${((model.name ?? '').capitalizeFirst)?.tr}',
                                                onChanged: (value) {
                                                  controller.changeSelectedValue(value, index);
                                                }),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        )
                                            : model.type == 'select'
                                            ? Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            FormRow(
                                                label: model.name ?? '',
                                                isRequired: model.isRequired == 'optional' ? false : true),
                                            CustomDropDownTextField(
                                              list: model.options ?? [],
                                              onChanged: (value) {
                                                controller.changeSelectedValue(value, index);
                                              },
                                              selectedValue: model.selectedValue,
                                            ),
                                          ],
                                        )
                                            : model.type == 'radio'
                                            ? Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            FormRow(
                                                label: model.name ?? '',
                                                isRequired: model.isRequired == 'optional' ? false : true),
                                            CustomRadioButton(
                                              title: model.name,
                                              selectedIndex: controller.formList[index].options?.indexOf(model.selectedValue ?? '') ?? 0,
                                              list: model.options ?? [],
                                              onChanged: (selectedIndex) {
                                                controller.changeSelectedRadioBtnValue(index, selectedIndex);
                                              },
                                            ),
                                          ],
                                        )
                                            : model.type == 'checkbox'
                                            ? Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            FormRow(
                                                label: model.name ?? '',
                                                isRequired: model.isRequired == 'optional' ? false : true),
                                            CustomCheckBox(
                                              selectedValue: controller.formList[index].cbSelected,
                                              list: model.options ?? [],
                                              onChanged: (value) {
                                                controller.changeSelectedCheckBoxValue(index, value);
                                              },
                                            ),
                                          ],
                                        )
                                            : model.type == 'file'
                                            ? Column(
                                          crossAxisAlignment:CrossAxisAlignment.start,
                                          children: [
                                            FormRow(label: model.name ?? '', isRequired: model.isRequired == 'optional' ? false : true),
                                            Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                                child: SizedBox(
                                                  child: InkWell(
                                                      onTap: () {
                                                        controller.pickFile(index);
                                                      },
                                                      child: ChooseFileItem(
                                                        fileName: model.selectedValue ?? MyStrings.chooseFile.tr,
                                                      )),
                                                ))
                                          ],
                                        )
                                            : const SizedBox(),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                    ) : const SizedBox.shrink(),
                    const SizedBox(height: Dimensions.space25),
                    controller.submitLoading
                        ? const Center(child: RoundedLoadingBtn())
                        : Center(
                      child: RoundedButton(
                        color: MyColor.getButtonColor(),
                        press: () {
                          controller.submitConfirmWithdrawRequest();
                        },
                        text: MyStrings.submit.tr,
                        textColor: MyColor.getButtonTextColor(),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
