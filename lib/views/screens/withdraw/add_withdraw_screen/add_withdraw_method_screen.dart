import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/data/controller/withdraw/add_new_withdraw_controller.dart';
import 'package:eastern_trust/data/model/withdraw/withdraw_method_response_model.dart';
import 'package:eastern_trust/data/repo/withdraw/withdraw_repo.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:eastern_trust/views/components/appbar/custom_appbar.dart';
import 'package:eastern_trust/views/components/buttons/rounded_button.dart';
import 'package:eastern_trust/views/components/buttons/rounded_loading_button.dart';
import 'package:eastern_trust/views/components/custom_loader.dart';
import 'package:eastern_trust/views/components/text-field/custom_amount_text_field.dart';
import 'package:eastern_trust/views/components/text-field/custom_drop_down_button_with_text_field2.dart';

import 'info_widget.dart';

class AddWithdrawMethod extends StatefulWidget {
  const AddWithdrawMethod({Key? key}) : super(key: key);

  @override
  State<AddWithdrawMethod> createState() => _AddWithdrawMethodState();
}

class _AddWithdrawMethodState extends State<AddWithdrawMethod> {

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(WithdrawRepo( apiClient: Get.find()));
    final controller = Get.put(AddNewWithdrawController(repo: Get.find(),));

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadDepositMethod();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddNewWithdrawController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: MyColor.getScreenBgColor2(),
          appBar: CustomAppBar(title: MyStrings.addWithdraw.tr) ,
          body: controller.isLoading?
          const CustomLoader():
          SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: Dimensions.screenPaddingHV1,
              decoration: BoxDecoration(
                color: MyColor.getScreenBgColor2(),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomDropDownTextField2(
                    labelText: MyStrings.paymentMethod.tr,
                    selectedValue: controller.withdrawMethod,
                    onChanged: (value){
                      controller.setWithdrawMethod(value);
                    },
                    items: controller.withdrawMethodList.map((WithdrawMethod method) {
                        return DropdownMenuItem<WithdrawMethod>(
                          value: method,
                          child: Text((method.name??'').tr, style: interRegularDefault.copyWith(color: MyColor.getTextColor())),
                        );
                      }).toList(),),
                  const SizedBox(height: Dimensions.space15),
                  CustomAmountTextField(
                    labelText: MyStrings.amount.tr,
                    hintText: MyStrings.enterAmount.tr,
                    inputAction: TextInputAction.done,
                    currency: controller.currency,
                    controller: controller.amountController,
                    onChanged: (value) {
                      if(value.toString().isEmpty){
                        controller.changeInfoWidgetValue(0);
                      }else{
                        double amount = double.tryParse(value.toString())??0;
                        controller.changeInfoWidgetValue(amount);
                      }
                      return;
                    },
                  ),
                 Visibility(
                   visible: controller.authorizationList.length>1,
                   child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     const SizedBox(height: Dimensions.space15),
                     CustomDropDownTextField2(
                       labelText:  MyStrings.authorizationMethod.tr,
                       selectedValue: controller.selectedAuthorizationMode,
                       onChanged: (value) {
                         controller.changeAuthorizationMode(value);
                       },
                       items: controller.authorizationList.map((String value) {
                         return DropdownMenuItem<String>(
                           value: value,
                           child: Text((value.toString()).tr, style: interRegularDefault.copyWith(color: MyColor.getTextColor())),
                         );
                       }).toList(),),
                   ],
                 )),
                  controller.mainAmount>0?const InfoWidget():const SizedBox(),
                  const SizedBox(height: Dimensions.space30,),
                  controller.submitLoading? const RoundedLoadingBtn():
                  RoundedButton(
                    color: MyColor.getButtonColor(),
                    text: MyStrings.submit.tr,
                    textColor: MyColor.getButtonTextColor(),
                    press: () {
                      controller.submitWithdrawRequest();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      });
  }
}
