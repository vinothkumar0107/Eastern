import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/data/controller/transfer/wire_transfer_controller.dart';
import 'package:eastern_trust/views/components/buttons/rounded_button.dart';
import 'package:eastern_trust/views/components/buttons/rounded_loading_button.dart';
import 'package:eastern_trust/views/components/checkbox/custom_check_box.dart';
import 'package:eastern_trust/views/components/custom_radio_button.dart';
import 'package:eastern_trust/views/components/row_item/form_row.dart';
import 'package:eastern_trust/views/components/text-field/custom_amount_text_field.dart';
import 'package:eastern_trust/views/components/text-field/custom_drop_down_button_with_text_field.dart';
import 'package:eastern_trust/views/components/text-field/custom_text_field.dart';
import 'package:eastern_trust/views/components/text/label_text.dart';

import '../../../../../data/model/dynamic_form/form.dart';
import '../../../withdraw/confirm_withdraw_screen/widget/choose_file_list_item.dart';
import 'wire_transfer_limit_bottom_sheet.dart';

class WireTransferForm extends StatefulWidget {
  const WireTransferForm({Key? key}) : super(key: key);

  @override
  State<WireTransferForm> createState() => _WireTransferFormState();
}

class _WireTransferFormState extends State<WireTransferForm> {

  final key = GlobalKey<FormState>();
  

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WireTransferController>(builder: (controller)=>SizedBox(
      width: MediaQuery.of(context).size.width,
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAmountTextField(
              currency: controller.currency,
              controller: controller.amountController,
              labelText: MyStrings.amount,
              hintText: MyStrings.enterAmount,
              onChanged: (value){

              }
          ),
          const SizedBox(height: 5),
          GestureDetector(
            onTap: (){
              WireTransferLimitBottomSheet().showLimitSheet(context);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: MyColor.transparentColor,width: 0))
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.info_outline,
                    size: 13,
                    color: MyColor.redCancelTextColor,
                  ),
                  const SizedBox(width: 5,),
                  Text(
                    MyStrings.transferLimit.tr,
                    style: interLightDefault.copyWith(fontSize:Dimensions.fontSmall12,color: MyColor.redCancelTextColor),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: Dimensions.textToTextSpace+10),
          Visibility(
              visible: controller.authorizationList.length>1,
              child: Column(
                children: [
                  LabelText(text: MyStrings.authorizationMethod.tr,required: true,),
                  const SizedBox(height: 8),
                  CustomDropDownTextField(selectedValue:controller.selectedAuthorizationMode,list: controller.authorizationList,onChanged:(dynamic value) {
                    controller.changeAuthorizationMode(value);
                  },),
                  const SizedBox(height: Dimensions.textToTextSpace+10,),
                ],
              )),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: controller.formList.length,
              itemBuilder: (ctx,index){
                FormModel? model=controller.formList[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    model.type=='text'?Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                            hintText: '${((model.name??'').capitalizeFirst)?.tr}',
                            needLabel: true,
                            needOutlineBorder: true,
                            labelText:( model.name??'').tr,
                            isRequired: model.isRequired=='optional'?false:true,
                            onChanged: (value){
                              controller.changeSelectedValue(value, index);
                            }),
                        const SizedBox(height: 10,),
                      ],
                    ):model.type=='textarea'?Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                            needLabel: true,
                            needOutlineBorder: true,
                            labelText: (model.name??'').tr,
                            isRequired: model.isRequired=='optional'?false:true,
                            hintText: '${((model.name??'').capitalizeFirst)?.tr}',
                            onChanged: (value){
                              controller.changeSelectedValue(value, index);
                            }),
                        const SizedBox(height: 10,),
                      ],
                    ):model.type=='select'?Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormRow(label: model.name??'', isRequired: model.isRequired=='optional'?false:true),
                        CustomDropDownTextField(list: model.options??[],onChanged: (value){
                          controller.changeSelectedValue(value,index);
                        },selectedValue: model.selectedValue,),
                      ],
                    ):model.type=='radio'?Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormRow(label: model.name??'', isRequired: model.isRequired=='optional'?false:true),
                        CustomRadioButton(title:model.name,selectedIndex:controller.formList[index].options?.indexOf(model.selectedValue??'')??0,list: model.options??[],onChanged: (selectedIndex){
                          controller.changeSelectedRadioBtnValue(index,selectedIndex);
                        },),
                      ],
                    ):model.type=='checkbox'?Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormRow(label: model.name??'', isRequired: model.isRequired=='optional'?false:true),
                        CustomCheckBox(selectedValue:controller.formList[index].cbSelected,list: model.options??[],onChanged: (value){
                          controller.changeSelectedCheckBoxValue(index,value);
                        },),
                      ],
                    ):model.type=='file'?Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormRow(label: model.name??'', isRequired: model.isRequired=='optional'?false:true),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                            child: SizedBox(
                              child:InkWell(
                                  onTap: (){
                                    controller.pickFile(index);
                                  }, child: ChooseFileItem(fileName: model.selectedValue??MyStrings.chooseFile.tr,)),
                            )
                        )
                      ],
                    ):const SizedBox(),

                    const SizedBox(height: 5,),

                  ],
                );
              }
          ),
          const SizedBox(height: Dimensions.space25),
          controller.submitLoading ?
          const Center(child:RoundedLoadingBtn()) :
          RoundedButton(
            press: () {
              controller.submitWireTransferRequest();
            },
            text: MyStrings.submit.tr,
          ),
        ],
      ),
    ));
  }
}
