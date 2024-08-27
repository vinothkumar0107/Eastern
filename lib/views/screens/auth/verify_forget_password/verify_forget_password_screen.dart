import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_images.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/data/controller/auth/forget_password/verify_password_controller.dart';
import 'package:eastern_trust/data/repo/auth/login_repo.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:eastern_trust/views/components/appbar/custom_appbar.dart';
import 'package:eastern_trust/views/components/buttons/rounded_button.dart';
import 'package:eastern_trust/views/components/buttons/rounded_loading_button.dart';
import 'package:eastern_trust/views/components/text/default_text.dart';

import '../../../../core/route/route.dart';
import '../../../components/appbar/appbar_specific_device.dart';
import '../../../components/otp_field_widget/otp_field_widget.dart';
import '../../../components/will_pop_widget.dart';

class VerifyForgetPassScreen extends StatefulWidget {
  const VerifyForgetPassScreen({Key? key}) : super(key: key);

  @override
  State<VerifyForgetPassScreen> createState() => _VerifyForgetPassScreenState();
}

class _VerifyForgetPassScreenState extends State<VerifyForgetPassScreen> {

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient:Get.find()));
    final controller=Get.put(VerifyPasswordController(loginRepo: Get.find()));
    controller.email=Get.arguments;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerifyPasswordController>(
      builder: (controller) => WillPopWidget(
        nextRoute: '',
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Scaffold(
            appBar: AppBarSpecificScreen.buildAppBar(),
            backgroundColor: MyColor.appPrimaryColorSecondary2,
            body: Stack(
              children: [
                const GradientView(gradientViewHeight: 3.5),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          // Navigator.of(context).pop();
                          Get.offAndToNamed(RouteHelper.loginScreen);
                        },
                      ),
                      Expanded(
                        child: Text(
                            MyStrings.passVerification,
                            textAlign: TextAlign.left,
                            style: interSemiBoldOverLarge.copyWith(color: MyColor.colorWhite,decorationColor:MyColor.primaryColor)
                        ),
                      ),
                      // To keep the title centered, you can add an empty `SizedBox`
                      const SizedBox(width: 48.0),
                    ],
                  ),
                ),
                controller.isLoading ?
                const Center(
                    child: CircularProgressIndicator(color: MyColor.primaryColor)
                ) :
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(15.0, 70.0, 15.0, 0.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Card(
                            color: MyColor.colorWhite,
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: Dimensions.space30),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Text('${MyStrings.verifyPasswordSubText.tr} : ${controller.getFormatedMail().tr}', maxLines: 3, textAlign: TextAlign.center,style: interRegularLarge.copyWith(color: MyColor.labelTextColor)),
                                      ),
                                      const SizedBox(height: Dimensions.space30),
                                      OTPFieldWidget(
                                        onChanged: (value) {
                                          controller.currentText = value;
                                        },
                                      ),
                                      const SizedBox(height: Dimensions.space30),
                                      controller.verifyLoading ? const RoundedLoadingBtn() : RoundedButton(
                                        text: MyStrings.verify.tr,
                                        textColor: MyColor.colorWhite,
                                        press: (){
                                          if (controller.currentText.length != 6) {
                                            controller.hasError=true;
                                          }
                                          else {
                                            controller.verifyForgetPasswordCode(controller.currentText);
                                          }
                                        },
                                        color: MyColor.appPrimaryColorSecondary2,
                                      ),
                                      const SizedBox(height: Dimensions.space20),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(MyStrings.didNotReceiveCode.tr, style: interMediumLarge.copyWith(color: MyColor.labelTextColor)),
                                          const SizedBox(width: Dimensions.space5),
                                          controller.isResendLoading?
                                          Container(margin:const EdgeInsets.only(left: 5,top: 5),height:20,width:20,child: const CircularProgressIndicator(color: MyColor.primaryColor)):
                                          GestureDetector(
                                            onTap: (){
                                              controller.resendForgetPassCode();
                                            },
                                            child: Text(MyStrings.resend.tr, style: interBoldLarge.copyWith(color: MyColor.appPrimaryColorSecondary2,decoration: TextDecoration.underline)),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: Dimensions.space20),
                                    ],
                                  ),
                                )
                            ),
                          ),
                          const SizedBox(height: Dimensions.space20), // Add spacing if needed
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

