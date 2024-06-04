import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/core/utils/my_images.dart';
import 'package:eastern_trust/data/controller/airtime/airtime_controller.dart';
import 'package:eastern_trust/views/components/operator/operator_widget.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../components/row_item/form_row.dart';

class OperatorSection extends StatelessWidget {
  const OperatorSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AirtimeController>(
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: Dimensions.textFieldToTextFieldSpace + 4),
          FormRow(label: MyStrings.operator.tr, isRequired: true),
          const SizedBox(height: Dimensions.space8,),
          OperatorWidget(
            title: controller.selectedOperator.id == -1 ? MyStrings.selectOperator.tr : controller.selectedOperator.name,
            image: controller.selectedOperator.logoUrls?.first ?? "",
            onTap: () {
              if(controller.selectedCountry.id == -1){
                CustomSnackBar.error(errorList: [MyStrings.selectCountryFirst.tr]);
              }else{
                Get.toNamed(RouteHelper.selectOperatorScreen,arguments: controller.selectedCountry.id.toString());
              }
            },
            isShowChangeButton: false,
          ),
          const SizedBox(height: Dimensions.textFieldToTextFieldSpace + 4),
        ],
      ),
    );
  }
}


