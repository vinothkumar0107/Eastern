import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/data/controller/airtime/airtime_controller.dart';
import 'package:eastern_trust/data/repo/airtime/airtime_repo.dart';
import 'package:eastern_trust/views/components/appbar/custom_appbar.dart';
import 'package:eastern_trust/views/components/custom_loader.dart';
import 'package:eastern_trust/views/screens/airtime/widget/airtime_country_bottomsheet.dart';
import 'package:eastern_trust/views/screens/airtime/widget/amount_section.dart';
import 'package:eastern_trust/views/screens/airtime/widget/fixed_amount_section.dart';
import 'package:eastern_trust/views/screens/airtime/widget/operator_section.dart';
import 'package:eastern_trust/views/screens/airtime/widget/phone_section.dart';

import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
import '../../../data/services/api_service.dart';
import '../../components/buttons/custom_rounded_button.dart';
import '../../components/text-field/custom_drop_down_button_with_text_field.dart';
import '../../components/text/label_text.dart';
class AirtimeScreen extends StatefulWidget {
  const AirtimeScreen({super.key});

  @override
  State<AirtimeScreen> createState() => _AirtimeScreenState();
}

class _AirtimeScreenState extends State<AirtimeScreen> {

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(AirtimeRepo(apiClient: Get.find()));
    var controller =  Get.put(AirtimeController(airtimeRepo: Get.find()));

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initialSelectedValue();
      controller.loadCountryData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AirtimeController>(
      builder: (controller) => Scaffold(
        backgroundColor: MyColor.containerBgColor,
        appBar: CustomAppBar(
          title: MyStrings.airtime.tr,
          isTitleCenter: false,
        ),
        body: controller.isLoading ? const CustomLoader() :  SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.space10),
          child: Column(
            children: [
              const SizedBox(height: Dimensions.textFieldToTextFieldSpace + 10),

              InkWell(
                onTap: () {
                  AirtimeCountryBottomSheet.bottomSheet(context, controller);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical:controller.selectedCountry.id != -1 ? 11 : 13,horizontal:  10),
                  decoration: BoxDecoration(
                      color: MyColor.transparentColor,
                      border:  Border.all(color: MyColor.naturalLight,width: .5),
                    borderRadius: BorderRadius.circular(Dimensions.paddingSize25)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Row(
                        children: [
                          controller.selectedCountry.id != -1 ? ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: SvgPicture.network(
                                width: 25,
                                height:25,
                                fit: BoxFit.cover,
                                controller.selectedCountry.flagUrl ?? ""),
                          ) : const SizedBox.shrink() ,
                          const SizedBox(width: Dimensions.space10,),
                          Text(controller.selectedCountry.id == -1 ? MyStrings.selectACountry : controller.selectedCountry.name ?? "",style: interRegularDefault.copyWith(color: MyColor.colorBlack),),
                        ],
                      ),

                      Icon(Icons.expand_more_rounded,color: MyColor.getGreyText(),size: 20,)
                    ],
                  ),
                ),
              ),

              const OperatorSection(),
              const PhoneSection(),

              Visibility(
                  visible: controller.authorizationList.length>1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      LabelText(text: MyStrings.authorizationMethod.tr,required: true,),
                      const SizedBox(height: 8),
                      CustomDropDownTextField(
                        selectedValue:controller.selectedAuthorizationMode,
                        list: controller.authorizationList,onChanged:(dynamic value) {
                        controller.changeAuthorizationMode(value);
                      },
                      borderWidth: 0.5,
                      borderColor: MyColor.naturalLight,)
                    ],
                  )
              ),

              controller.selectedOperator.denominationType == MyStrings.range ?
              const AmountInputByUserSection() : const SizedBox.shrink(),

              controller.selectedOperator.denominationType == MyStrings.fixed ?
              const FixedAmountSection() : const SizedBox.shrink(),

            ],
          ),
        ),
        bottomNavigationBar: controller.isLoading ? const SizedBox.shrink() : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 12),
            child: SizedBox(
              height: 45,
              child: CustomRoundedButton(
                isLoading: controller.submitLoading,
                labelName: MyStrings.topUp.tr,
                press: () {
                  controller.submitTopUp();
                },
              ),
            )
        ),
      ),

    );
  }
}


