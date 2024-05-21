import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/data/controller/transfer/my_bank_transfer_controller.dart';
import 'package:eastern_trust/views/components/bottom_sheet/custom_bottom_sheet.dart';
import 'package:eastern_trust/views/components/buttons/rounded_button.dart';
import 'package:eastern_trust/views/components/buttons/rounded_loading_button.dart';
import 'package:eastern_trust/views/components/row_item/bottom_sheet_top_row.dart';
import 'package:eastern_trust/views/components/text-field/custom_text_field.dart';



class AddMyBankBeneficiariesBottomSheet{
  static void showBottomSheet(BuildContext context){
    Get.find<MyBankTransferController>().clearTextField();
    CustomBottomSheet(child: GetBuilder<MyBankTransferController>(builder: (controller)=> Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BottomSheetTopRow(header: MyStrings.addBeneficiaryToVBank),
          const SizedBox(height: Dimensions.space12),
          Focus(
            onFocusChange: (focus){
              if(!focus){
                controller.changeMobileFocus(focus, true);
              }
            },
            child: CustomTextField(
                controller: controller.accountNoController,
                labelText: MyStrings.accountNumber,
                hintText: MyStrings.enterAccountNumber,
                isRequired:true,
                needOutlineBorder: true,
                onChanged: (value){}
            ),
          ),
          const SizedBox(height: Dimensions.space15,),
          Focus(
            onFocusChange: (focus){
                if(!focus){
                  controller.changeMobileFocus(focus, false);
                }
              },
            child: CustomTextField(
                controller: controller.accountNameController,
                labelText: MyStrings.accountName,
                hintText: MyStrings.enterAccountName,
                needOutlineBorder: true,
                isRequired:true,
                onChanged: (value){}
            ),
          ),
          const SizedBox(height: Dimensions.space15,),
          CustomTextField(
              controller: controller.shortNameController,
              needOutlineBorder: true,
              labelText: MyStrings.shortName,
              hintText: MyStrings.enterShortName,
              isRequired:true,
              onChanged: (value){}
          ),
          const SizedBox(height: Dimensions.space30,),
          controller.isSubmitLoading?const RoundedLoadingBtn():RoundedButton(text: MyStrings.submit, press: (){
            controller.addBeneficiary();
          })
        ],
      ))).customBottomSheet(context);
  }
}