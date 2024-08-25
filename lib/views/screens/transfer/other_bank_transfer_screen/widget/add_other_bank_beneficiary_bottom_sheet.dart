import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/data/controller/transfer/other_bank_transfer_controller.dart';
import 'package:eastern_trust/data/model/transfer/beneficiary/other_bank_beneficiary_response_model.dart';
import 'package:eastern_trust/views/components/bottom_sheet/custom_bottom_sheet.dart';
import 'package:eastern_trust/views/components/buttons/rounded_button.dart';
import 'package:eastern_trust/views/components/buttons/rounded_loading_button.dart';
import 'package:eastern_trust/views/components/checkbox/custom_check_box.dart';
import 'package:eastern_trust/views/components/custom_radio_button.dart';
import 'package:eastern_trust/views/components/row_item/bottom_sheet_top_row.dart';
import 'package:eastern_trust/views/components/row_item/form_row.dart';
import 'package:eastern_trust/views/components/text-field/custom_drop_down_button_with_text_field.dart';
import 'package:eastern_trust/views/components/text-field/custom_drop_down_button_with_text_field2.dart';
import 'package:eastern_trust/views/components/text-field/custom_text_field.dart';
import 'package:eastern_trust/views/screens/withdraw/confirm_withdraw_screen/widget/choose_file_list_item.dart';

import '../../../../../../data/model/dynamic_form/form.dart';



class AddOtherBankBeneficiariesBottomSheet{

   void showBottomSheet(BuildContext context){
   Get.find<OtherBankTransferController>().clearTextField();
   CustomBottomSheet(child: GetBuilder<OtherBankTransferController>(builder: (controller)=>SizedBox(
     child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisSize: MainAxisSize.min,
           children: [
             const BottomSheetTopRow(header: MyStrings.addBeneficiaryToOtherBank),
             CustomDropDownTextField2(
               labelText: MyStrings.selectBank,
               selectedValue: controller.selectedBank,
               radius: Dimensions.paddingSize25,
               onChanged: (newValue) {
                 controller.changeSelectedBank(newValue);
               },
               items: controller.bankList.map((Banks bank) {
                 return DropdownMenuItem<Banks>(
                   value: bank,
                   child: Text((bank.name??'').tr, style: interRegularLarge),
                 );
               }).toList(),
             ),
             const SizedBox(height: Dimensions.textToTextSpace+10),
             CustomTextField(
               backgroundColor: MyColor.colorWhite,
                 controller: controller.shortNameController,
                 needOutlineBorder: true,
                 labelText: MyStrings.shortName,
                 isRequired:true,
                 hintText: MyStrings.enterShortName,
                 validator: (value){
                   if(value.toString().isEmpty){
                     return MyStrings.enterShortName;
                   } else{
                     return null;
                   }
                 },
                 onChanged: (value){}
             ),
             const SizedBox(height: Dimensions.textToTextSpace+10),
             ListView.builder(
               shrinkWrap: true,
               itemCount: controller.bankFormList?.length??0,
               physics: const NeverScrollableScrollPhysics(),
               itemBuilder: (context,index){
                 FormModel? model=controller.bankFormList?[index];
                 return Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisSize: MainAxisSize.min,
                   children: [
                     model?.type=='text'?Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         CustomTextField(
                             backgroundColor: MyColor.colorWhite,
                             hintText: '${((model?.name??'').capitalizeFirst)?.tr}',
                             needLabel: true,
                             needOutlineBorder: true,
                             labelText:( model?.name??'').tr,
                             isRequired: model?.isRequired=='optional'?false:true,
                             onChanged: (value){
                               controller.changeSelectedValue(value, index);
                             }),
                         const SizedBox(height: 10,),
                       ],
                     ):model?.type=='textarea'?Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         CustomTextField(
                           backgroundColor: MyColor.colorWhite,
                             needLabel: true,
                             needOutlineBorder: true,
                             labelText: (model?.name??'').tr,
                             isRequired: model?.isRequired=='optional'?false:true,
                             hintText: '${((model?.name??'').capitalizeFirst)?.tr}',
                             onChanged: (value){
                               controller.changeSelectedValue(value, index);
                             }),
                         const SizedBox(height: 10,),
                       ],
                     ):model?.type=='select'?Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         FormRow(label: model?.name??'', isRequired: model?.isRequired=='optional'?false:true),
                         CustomDropDownTextField(list: model?.options??[],onChanged: (value){
                           controller.changeSelectedValue(value,index);
                         },selectedValue: model?.selectedValue,),
                       ],
                     ):model?.type=='radio'?Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         FormRow(label: model?.name??'', isRequired: model?.isRequired=='optional'?false:true),
                         CustomRadioButton(title:model?.name,selectedIndex:controller.bankFormList?[index].options?.indexOf(model?.selectedValue??'')??0,list: model?.options??[],onChanged: (selectedIndex){
                           controller.changeSelectedRadioBtnValue(index,selectedIndex);
                         },),
                       ],
                     ):model?.type=='checkbox'?Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         FormRow(label: model?.name??'', isRequired: model?.isRequired=='optional'?false:true),
                         CustomCheckBox(selectedValue:controller.bankFormList?[index].cbSelected,list: model?.options??[],onChanged: (value){
                           controller.changeSelectedCheckBoxValue(index,value);
                         },),
                       ],
                     ):model?.type=='file'?Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         FormRow(label: model?.name??'', isRequired: model?.isRequired=='optional'?false:true),
                         Padding(
                             padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                             child: SizedBox(
                               child:InkWell(
                                   onTap: (){
                                     controller.pickFile(index);
                                   }, child: ChooseFileItem(fileName: model?.selectedValue??MyStrings.chooseFile.tr,)),
                             )
                         )
                       ],
                     ):const SizedBox(),
                     const SizedBox(height: 5,),
                   ],
                 );
               }
             ),
             const SizedBox(height: Dimensions.space30,),
             controller.isSubmitLoading?const RoundedLoadingBtn():RoundedButton(text: MyStrings.submit, press: (){
                 controller.addBeneficiary();
             })
           ],
         ),
   ),
   )).customBottomSheet(context);
  }
}