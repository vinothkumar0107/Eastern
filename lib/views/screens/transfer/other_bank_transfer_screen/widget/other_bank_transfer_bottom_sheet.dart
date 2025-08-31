import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/string_format_helper.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/data/controller/transfer/other_bank_transfer_controller.dart';
import 'package:eastern_trust/data/model/transfer/beneficiary/other_bank_beneficiary_response_model.dart';
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
import 'package:eastern_trust/views/components/text-field/custom_text_field.dart';
import 'package:eastern_trust/views/components/text/label_text.dart';
import 'package:eastern_trust/views/components/widget-divider/widget_divider.dart';

class OtherBankTransferBottomSheet{

    void transferBottomSheet(BuildContext context,int index){

      CustomBottomSheet(child: GetBuilder<OtherBankTransferController>(builder: (controller){
        Data beneficiary = controller.beneficiaryList[index];
        return Column(
          children: [
            BottomSheetTopRow(header: '${MyStrings.transferMoneyTo} ${beneficiary.beneficiaryOf?.name??''}'.tr),
            BottomSheetContainer(
              showBorder: true,
              backgroundColor: MyColor.primaryColor.withOpacity(0.05),
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
                          textColor: MyColor.colorBlack,
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
                      LimitPreviewRow(firstText: MyStrings.limitPerTrx, secondText:  '${controller.currencySymbol}${Converter.formatNumber(beneficiary.beneficiaryOf?.minimumLimit??'0').makeCurrencyComma()} - ${controller.currencySymbol}${Converter.formatNumber(beneficiary.beneficiaryOf?.maximumLimit??'0').makeCurrencyComma()}'),
                      LimitPreviewRow(firstText: MyStrings.charge, secondText: '*${beneficiary.beneficiaryOf?.percentCharge??'0'}%${Converter.showPercent(controller.currencySymbol,controller.beneficiaryList[index].beneficiaryOf?.percentCharge??'0')}'),
                      LimitPreviewRow(firstText: MyStrings.dailyMax,secondText:   '${controller.currencySymbol}${Converter.formatNumber(beneficiary.beneficiaryOf?.dailyMaximumLimit??'0').makeCurrencyComma()}'),
                      LimitPreviewRow(firstText: MyStrings.monthlyMax,secondText: '${controller.currencySymbol}${Converter.formatNumber(beneficiary.beneficiaryOf?.monthlyMaximumLimit??'0').makeCurrencyComma()}'),
                      LimitPreviewRow(firstText: MyStrings.dailyMaxTrx,secondText: '${controller.currencySymbol}${Converter.formatNumber(beneficiary.beneficiaryOf?.dailyMaximumLimit??'0').makeCurrencyComma()}'),
                      LimitPreviewRow(firstText: MyStrings.monthlyMinTrx,secondText: '${controller.currencySymbol}${Converter.formatNumber(beneficiary.beneficiaryOf?.monthlyMaximumLimit??'0').makeCurrencyComma()}'),
                      Text('*${MyStrings.processingTime.tr} ${controller.beneficiaryList[index].beneficiaryOf?.processingTime??'0'}',style: interSemiBoldSmall.copyWith(color: MyColor.primaryColor),),
                    ],
                  ))
                ],
              ),
            ),
            const SizedBox(height: Dimensions.space15),
            BottomSheetContainer(
              showBorder: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                      needOutlineBorder: true,
                      labelText: MyStrings.recipient.capitalizeFirst,
                      isRequired:true,
                      readOnly:true,
                      controller: TextEditingController(text: beneficiary.accountName??''),
                      onChanged: (value){

                      }),
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
                          const SizedBox(height: Dimensions.space10),
                          LabelText(text: MyStrings.authorizationMethod.tr,required: true,),
                          const SizedBox(height: 8),
                          CustomDropDownTextField(selectedValue:controller.selectedAuthorizationMode,
                            list: controller.authorizationList,onChanged:(dynamic value) {
                            controller.changeAuthorizationMode(value);
                          },
                            backgroundColor: MyColor.colorWhite,
                            borderColor: MyColor.borderColor,
                            borderWidth: 1.0,
                          )
                        ],
                      )),
                  const SizedBox(height: Dimensions.space30),
                  controller.submitLoading? const RoundedLoadingBtn() :
                  RoundedButton(
                    press: (){
                      controller.transferMoney(beneficiary.id.toString());
                    },
                    text: MyStrings.applyNow,
                  )
                ],
              ),
            )
          ],
        );
      })).customBottomSheet(context);
    }

  }