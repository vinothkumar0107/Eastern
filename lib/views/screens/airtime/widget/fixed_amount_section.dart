import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/data/controller/airtime/airtime_controller.dart';
import 'package:eastern_trust/views/components/row_item/form_row.dart';

import 'amount_widget.dart';
class FixedAmountSection extends StatelessWidget {
  const FixedAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
      return GetBuilder<AirtimeController>(
        builder: (controller) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            FormRow(
              label: MyStrings.amount.tr,
              isRequired: false
            ),
            const SizedBox(height: Dimensions.space8,),


           GridView.builder(
             itemCount: controller.fixAmountDescriptionList.isNotEmpty ? controller.fixAmountDescriptionList.length :
                 controller.fixedAmountList.isNotEmpty ? controller.fixedAmountList.length : controller.suggestedAmountList.length,
               physics: const NeverScrollableScrollPhysics(),
               shrinkWrap: true,
               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                 crossAxisCount: 3,
                 mainAxisSpacing: Dimensions.space10,
                 mainAxisExtent: controller.fixAmountDescriptionList.isEmpty? 100 : 120,
                 childAspectRatio:  controller.fixAmountDescriptionList.isEmpty? 2.1 : 1
               ),
               itemBuilder: (context, index) {
                 return controller.fixAmountDescriptionList.isNotEmpty ? AmountWidget(

                   onTap: () {
                     controller.onSelectedAmount(index, "${controller.fixAmountDescriptionList[index].amount}");
                   },
                   currency: controller.currency,
                   amount: "${controller.fixAmountDescriptionList[index].amount}",
                   description: "${controller.fixAmountDescriptionList[index].description}",
                   selectedAmount: controller.selectedAmountIndex == index,
                 ) : controller.fixedAmountList.isNotEmpty ? AmountWidget(
                   onTap: () {
                     controller.onSelectedAmount(index, controller.fixedAmountList[index]);
                   },
                   currency: controller.currency,
                   amount: controller.fixedAmountList[index],
                   selectedAmount: controller.selectedAmountIndex == index,
                 ) : AmountWidget(
                   onTap: () {
                     controller.onSelectedAmount(index, controller.suggestedAmountList[index]);
                   },
                   currency: controller.currency,
                   amount: controller.suggestedAmountList[index],
                   selectedAmount: controller.selectedAmountIndex == index,
                 );
               },

           )

           /* Wrap(
              direction: Axis.horizontal,
              spacing: 8,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: List.generate(controller.fixAmountDescriptionList.length, (index) {
                return ;
              }),
            )*/
          ],
        ),
      );
  }
}

