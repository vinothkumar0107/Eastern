import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/string_format_helper.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/data/controller/loan/loan_plan_controller.dart';
import 'package:eastern_trust/views/components/bottom_sheet/custom_bottom_sheet.dart';
import 'package:eastern_trust/views/components/buttons/rounded_button.dart';
import 'package:eastern_trust/views/components/buttons/rounded_loading_button.dart';
import 'package:eastern_trust/views/components/row_item/bottom_sheet_top_row.dart';
import 'package:eastern_trust/views/components/row_item/warning_row.dart';

import '../../../../components/text-field/custom_amount_text_field.dart';

class ApplyLoanBottomSheet{

  void bottomSheet(BuildContext context, int index){
    try{
      Get.find<LoanPlanController>().amountController.text = '';
    }catch(e){if(kDebugMode){print(e.toString());}}
    CustomBottomSheet(
      child:  GetBuilder<LoanPlanController>(
        builder: (controller) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BottomSheetTopRow(header: MyStrings.applyForLoan),
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAmountTextField(
                      required: true,
                      controller: controller.amountController,
                      currency: controller.currency,
                      labelText: MyStrings.amount,
                      hintText: MyStrings.enterAmount,
                      onChanged: (value){}
                  ),
                  WarningRow(text: '${MyStrings.limit}: ${controller.currencySymbol}${Converter.formatNumber(controller.planList[index].minimumAmount??'0')} - ${controller.currencySymbol}${Converter.formatNumber(controller.planList[index].maximumAmount??'0')}',),
                  const SizedBox(height: Dimensions.space30),
                  controller.submitLoading?const RoundedLoadingBtn():RoundedButton(
                    press: (){
                      String planId = controller.planList[index].id.toString();
                      controller.submitLoanPlan(planId);
                    },
                    text: MyStrings.applyNow,
                  ),
                  const SizedBox(height: Dimensions.space10),
                ],
              ),
            )
          ],
        ),
      )
    ).customBottomSheet(context);

  }
}