import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/data/controller/airtime/airtime_controller.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../../core/utils/style.dart';
import '../../../../data/services/api_service.dart';
import '../../../components/text-field/custom_text_field.dart';
class AmountInputByUserSection extends StatelessWidget {
  const AmountInputByUserSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AirtimeController>(
      builder: (controller) =>  Column(
        children: [
          Row(
            children: [
              Text(MyStrings.amount.tr,style: interRegularDefault,),
              Expanded(child: Text(" (${MyStrings.minAmount_.tr} ${Get.find<ApiClient>().getCurrencyOrUsername(isSymbol: true)}"
                  "${controller.selectedOperator.minAmount} & ${MyStrings.maxAmount_.tr} "
                  "${Get.find<ApiClient>().getCurrencyOrUsername(isSymbol: true)}${controller.selectedOperator.maxAmount})",
                style: interRegularDefault.copyWith(color: MyColor.primaryColor.withOpacity(.7)),
              )),
            ],
          ),
          const SizedBox(height: Dimensions.space8,),
          CustomTextField(
            needLabel: false,
            needOutlineBorder: true,
            labelText: '',
            hintText: MyStrings.enterYourAmount.tr,
            controller: controller.amountController,
            focusNode: controller.amountFocusNode,
            textInputType: TextInputType.phone,
            inputAction: TextInputAction.next,
            disableColor: MyColor.naturalLight,
            isShowSuffixIcon: true,
            suffixText: Get.find<ApiClient>().getCurrencyOrUsername(),
            onChanged: (value) {
              return;
            },
            validator: (value){
              if(value.toString().isEmpty){
                return MyStrings.enterYourPhoneNumber.tr;
              }
              return null;
            },
          ),
        ],
      )
    );
  }
}
