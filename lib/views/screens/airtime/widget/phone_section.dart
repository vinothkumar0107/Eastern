import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/data/controller/airtime/airtime_controller.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../../core/utils/style.dart';
import '../../../components/row_item/form_row.dart';
import '../../../components/text-field/custom_text_field.dart';
class PhoneSection extends StatelessWidget {
  const PhoneSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AirtimeController>(
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormRow(label: MyStrings.phoneNumber.tr, isRequired: true),
          const SizedBox(height: Dimensions.space8,),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 13),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: MyColor.naturalLight, width: .5)
                ),
                child: Text(controller.selectedCountry.callingCodes?[0] ?? MyStrings.code.tr,style: interMediumDefault,),
              ),
              const SizedBox(width: 8),
              Expanded(
                  flex: 6,
                  child: CustomTextField(
                    needLabel: false,
                    needOutlineBorder: true,
                    labelText: '',
                    hintText: MyStrings.enterYourPhoneNo.tr,
                    controller: controller.mobileController,
                    focusNode: controller.mobileFocusNode,
                    textInputType: TextInputType.phone,
                    inputAction: TextInputAction.next,
                    disableColor: MyColor.naturalLight,
                    onChanged: (value) {
                      return;
                    },
                    validator: (value){
                      if(value.toString().isEmpty){
                        return MyStrings.enterYourPhoneNumber.tr;
                      }
                      return null;
                    },
                  )
              ),
            ],
          ),
          const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
        ],
      ),
    );
  }
}
