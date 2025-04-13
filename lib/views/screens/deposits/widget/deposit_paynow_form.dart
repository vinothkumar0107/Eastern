import 'dart:ffi';

import 'package:eastern_trust/data/controller/deposit/deposit_history_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../../core/utils/style.dart';
import '../../../../data/controller/deposit/deposite_paynow_controller.dart';
import '../../../../data/model/authorized/deposit/deposit_insert_response_model.dart';
import '../../../components/bottom_sheet/custom_bottom_notification.dart';
import '../../../components/buttons/rounded_button.dart';
import '../../../components/buttons/rounded_loading_button.dart';
import '../../../components/checkbox/custom_check_box.dart';
import '../../../components/custom_radio_button.dart';
import '../../../components/row_item/form_row.dart';
import '../../../components/text-field/custom_drop_down_button_with_text_field.dart';
import '../../../components/text-field/custom_text_field.dart';
import '../../withdraw/confirm_withdraw_screen/widget/choose_file_list_item.dart';

class DepositPayNowForm extends StatefulWidget {
  final DepositInsertResponseModel depositInsertModel;
  const DepositPayNowForm({Key? key, required this.depositInsertModel}) : super(key: key);

  @override
  State<DepositPayNowForm> createState() => _DepositPayNowFormState();
}

class _DepositPayNowFormState extends State<DepositPayNowForm> {

  final formKey = GlobalKey<FormState>();
  String? _selectedValue = "";
  Map<String, bool> selectedCheckBoxOptions = {};
  final List<String> _dropdownItems = [
    "Select",
    "USD",
    "EUR",
    "SGD",
    "IDR",
    "AUD",
    "AED"
  ];
  final ScrollController scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    return GetBuilder<DepositPayNowController>(
      builder: (controller) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          shrinkWrap: true,
          controller: scrollController,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: (controller.formList?.length ?? 0),
          separatorBuilder: (context, index) => const SizedBox(height: 0),
          itemBuilder: (context, index) {
            final field = controller.formList?[index];
            return _buildField(field!, controller, index);
          },
        ),
      ),
    );
  }

  Widget _buildField(Field field, DepositPayNowController payController, int index) {
    switch (field.type) {
      case 'text':
        return _buildTextField(field, payController, index);
      case 'textarea':
        return _buildTextArea(field, payController, index);
      case 'checkbox':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: Dimensions.space10),
            FormRow(label: (field.name??'').toLowerCase().capitalizeFirst, isRequired: field.isRequired=='optional'?false:true),
            CustomCheckBox(selectedValue:payController.formList?[index].cbSelected,
              list: field.options??[],
              fontSize: Dimensions.fontDefault,
              onChanged: (value){
              payController.changeSelectedCheckBoxValue(index,value);
            },
            ),
          ],
        );
      case 'radio':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: Dimensions.space10,),
            FormRow(label: (field.name??'').toLowerCase().capitalizeFirst, isRequired: field.isRequired=='optional'?false:true),
            CustomRadioButton(title:field.name,selectedIndex:payController.formList?[index].options?.indexOf(field.selectedValue??'')??0,list: field.options??[],fontSize: Dimensions.fontDefault,onChanged: (selectedIndex){
              payController.changeSelectedRadioBtnValue(index,selectedIndex);
            },),
          ],
        );
      case 'select':
        return _buildDropdown(field, field.options ?? [], payController, index);
      case 'file':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: Dimensions.space10),
            FormRow(label: (field.name??'').toLowerCase().capitalizeFirst, isRequired: field.isRequired=='optional'?false:true),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                child: SizedBox(
                  child:InkWell(
                      onTap: (){
                        payController.pickFile(index);
                      }, child: ChooseFileItem(fileName: field.selectedValue??MyStrings.chooseFile.tr,)),
                )
            )
          ],
        );
        // return _buildFileInput(field);
      default:
        return const SizedBox.shrink(); // Placeholder for unhandled types
    }
  }

  Widget _buildTextField(Field field, DepositPayNowController payController, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CustomTextField(
        needLabel: false,
        needOutlineBorder: true,
        labelText: field.label,
        hintText: field.name,
        textInputType: TextInputType.text,
        borderWidth: 1.0,
        isRequired: true,
        disableColor: MyColor.liteGreyColorBorder,
        // validator: (value) {
        //   if (value!.isEmpty) {
        //     return "Please enter ${field.name}";
        //   } else {
        //     return null;
        //   }
        // },
        onChanged: (value) {
          // formKey.currentState!.validate();
          payController.changeSelectedValue(value, index);
        },
      ),
    );
  }

  Widget _buildTextArea(Field field, DepositPayNowController payController, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CustomTextField(
        needLabel: false,
        needOutlineBorder: true,
        labelText: field.label,
        hintText: field.name,
        textInputType: TextInputType.text,
        borderWidth: 1.0,
        maxiLines: 3,
        isRequired: true,
        disableColor: MyColor.liteGreyColorBorder,
        borderRadius: Dimensions.paddingSize10,
        onChanged: (value) {
          payController.changeSelectedValue(value, index);
        },
      ),
    );
  }

  Widget _buildDropdown(Field field, List<String> dropdownItems, DepositPayNowController payController, int index) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: CustomDropDownTextField(
        selectedValue: field.selectedValue ?? dropdownItems.first,
        list: dropdownItems,
        borderWidth: 0.5,
        borderColor: MyColor.liteGreyColorBorder,
        onChanged: (value) {
          payController.changeSelectedValue(value,index);
        },
      ),
    );
  }


}