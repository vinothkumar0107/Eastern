import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/data/controller/dps/dps_plan_controller.dart';
import 'package:eastern_trust/views/components/buttons/rounded_button.dart';
import 'package:eastern_trust/views/components/text-field/custom_drop_down_button_with_text_field.dart';
import 'package:eastern_trust/views/components/text/label_text.dart';


class DPSPlanBottomSheet{
  static void bottomSheet(BuildContext context, int index){

    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: MyColor.transparentColor,
        context: context,
        builder: (context) => GetBuilder<DPSPlanController>(
          builder: (controller) => SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
              decoration: const BoxDecoration(color: MyColor.colorWhite, borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(MyStrings.applyToOpenDPS.tr, style: interRegularLarge.copyWith(fontWeight: FontWeight.w600)),
                  GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: MyColor.getDialogBg(),
                        shape: BoxShape.circle
                      ),
                      child: const Icon(Icons.clear, color: MyColor.colorBlack, size: 20),
                    ),
                  )
                ],),
                  Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                            visible: controller.authorizationList.length>1,
                            child: Column(
                              children: [
                                LabelText(text: MyStrings.authorizationMethod.tr,required: true,),
                                const SizedBox(height: 8),
                                CustomDropDownTextField(selectedValue:controller.selectedAuthorizationMode,list: controller.authorizationList,onChanged:(dynamic value) {
                                  controller.changeAuthorizationMode(value);
                                },)
                              ],
                            )),
                        RoundedButton(
                          press: (){
                            String planId = controller.planList[index].id.toString();
                            controller.submitDpsPlan(planId);
                          },
                          text: MyStrings.applyNow,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}

