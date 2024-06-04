

  import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/string_format_helper.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/data/controller/transfer/my_bank_transfer_controller.dart';
import 'package:eastern_trust/views/components/animated_widget/expanded_widget.dart';
import 'package:eastern_trust/views/components/bottom_sheet/custom_bottom_sheet.dart';
import 'package:eastern_trust/views/components/buttons/rounded_button.dart';
import 'package:eastern_trust/views/components/buttons/rounded_loading_button.dart';
import 'package:eastern_trust/views/components/custom_container/bottom_sheet_container.dart';
import 'package:eastern_trust/views/components/row_item/bottom_sheet_top_row.dart';
import 'package:eastern_trust/views/components/row_item/info_row.dart';
import 'package:eastern_trust/views/components/row_item/limit_preview_row.dart';
import 'package:eastern_trust/views/components/text-field/custom_amount_text_field.dart';
import 'package:eastern_trust/views/components/text-field/custom_drop_down_button_with_text_field.dart';
import 'package:eastern_trust/views/components/text/label_text.dart';
import 'package:eastern_trust/views/components/widget-divider/widget_divider.dart';

class MyBankTransferBottomSheet{

    void transferBottomSheet(BuildContext context,int index){
      CustomBottomSheet(
        child: GetBuilder<MyBankTransferController>(builder: (controller)=>Column(
          children: [
            const BottomSheetTopRow(header: MyStrings.transferMoney),
            BottomSheetContainer(
              showBorder: true,
              child: Column(
                children: [
                  InkWell(
                    onTap:(){
                      controller.changeLimitShowStatus();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const InfoRow(
                          text: MyStrings.transferLimit,
                        ),
                        Icon(
                            controller.isLimitShow ? Icons.keyboard_arrow_up:Icons.keyboard_arrow_down,
                            color: MyColor.getGreyText(),
                            size: 20)
                      ],
                    ),
                  ),
                  ExpandedSection(expand:controller.isLimitShow,child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WidgetDivider(space: Dimensions.space12,lineColor: MyColor.transparentColor),
                      LimitPreviewRow(firstText: MyStrings.limitPerTrx,secondText:  '${controller.currencySymbol}${Converter.formatNumber(controller.limitPerTrx)} (${MyStrings.min.tr})'),
                      LimitPreviewRow(firstText: MyStrings.chargePerTrx,secondText: Converter.formatNumber(controller.chargePerTrx)),
                      LimitPreviewRow(firstText: MyStrings.dailyLimit,secondText:   '${controller.currencySymbol}${Converter.formatNumber(controller.dailyMaxLimit)} (${MyStrings.max.tr})'),
                      LimitPreviewRow(firstText: MyStrings.monthlyLimit,secondText: '${controller.currencySymbol}${Converter.formatNumber(controller.monthlyLimit)} (${MyStrings.max})',showDivider: false,),
                    ],
                  ))
                ],
              ),
            ),
            const SizedBox(height: 15,),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: MyColor.colorWhite,
                  border: Border.all(color: MyColor.borderColor)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10,),
                  CustomAmountTextField(
                      controller: controller.amountController,
                      currency: controller.currency,
                      labelText: MyStrings.amount,
                      hintText: MyStrings.enterAmount,
                      onChanged: (value){}
                  ),
                  Visibility(
                      visible: controller.authorizationList.length>1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          LabelText(text: MyStrings.authorizationMethod.tr,required: true,),
                          const SizedBox(height: 8),
                          CustomDropDownTextField(selectedValue:controller.selectedAuthorizationMode,list: controller.authorizationList,onChanged:(dynamic value) {
                            controller.changeAuthorizationMode(value);
                          },)
                        ],
                      )),
                  const SizedBox(height: Dimensions.space30),
                  controller.submitLoading? const RoundedLoadingBtn() : RoundedButton(
                    press: (){
                      controller.transferMoney(controller.beneficiaryList[index].id.toString());
                    },
                    text: MyStrings.applyNow,
                  )
                ],
              ),
            ),
          ],
        ))).customBottomSheet(context);
    }

  }