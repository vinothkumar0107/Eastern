import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_images.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/data/controller/auth/auth/sms_verification_controler.dart';
import 'package:eastern_trust/data/repo/auth/sms_email_verification_repo.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:eastern_trust/views/components/appbar/custom_appbar.dart';
import 'package:eastern_trust/views/components/buttons/rounded_button.dart';
import 'package:eastern_trust/views/components/buttons/rounded_loading_button.dart';

import '../../../../core/route/route.dart';
import '../../../components/appbar/appbar_specific_device.dart';
import '../../../components/otp_field_widget/otp_field_widget.dart';
import '../../../components/will_pop_widget.dart';



class SmsVerificationScreen extends StatefulWidget {
  const SmsVerificationScreen({Key? key}) : super(key: key);

  @override
  State<SmsVerificationScreen> createState() => _SmsVerificationScreenState();
}

class _SmsVerificationScreenState extends State<SmsVerificationScreen> {
  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(SmsEmailVerificationRepo(apiClient: Get.find()));
   final controller = Get.put(SmsVerificationController(repo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.isProfileCompleteEnable=Get.arguments[0];
      controller.isTwoFactorEnable = Get.arguments[1];
      controller.loadBefore();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  // need to remove
  @override
  Widget build2(BuildContext context) {
   return  WillPopScope(
     onWillPop: () async {
       return false;
     },
     child: SafeArea(
        child: Scaffold(
          backgroundColor: MyColor.containerBgColor,
          appBar: CustomAppBar(
            fromAuth: true,
            title: MyStrings.smsVerification.tr,
            isShowBackBtn: true,
            isShowActionBtn: false,
          ),
          body: GetBuilder<SmsVerificationController>(
            builder: (controller) => controller.isLoading ? const Center(
                child: CircularProgressIndicator(color: MyColor.primaryColor)
            ) : SingleChildScrollView(
                padding: Dimensions.screenPaddingHV,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: Dimensions.space30),
                      Container(
                        height: 100, width: 100,
                        alignment: Alignment.center,
                        decoration:  BoxDecoration(
                            color: MyColor.primaryColor600,
                            shape: BoxShape.circle
                        ),
                        child: SvgPicture.asset(MyImages.emailVerifyImage, height: 50, width: 50, color: MyColor.primaryColor),
                      ),
                      const SizedBox(height: Dimensions.space50),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.1),
                        child: Text(MyStrings.smsVerificationMsg.tr, maxLines: 2, textAlign: TextAlign.center,style: interRegularDefault.copyWith(color: MyColor.labelTextColor)),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.space30),
                        child: PinCodeTextField(
                          appContext: context,
                          pastedTextStyle: interRegularDefault.copyWith(color: MyColor.primaryColor),
                          length: 6,
                          textStyle: interRegularDefault.copyWith(color: MyColor.primaryColor),
                          obscureText: false,
                          obscuringCharacter: '*',
                          blinkWhenObscuring: false,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderWidth: 1,
                              borderRadius: BorderRadius.circular(5),
                              fieldHeight: 40,
                              fieldWidth: 40,
                              inactiveColor:  MyColor.borderColor,
                              inactiveFillColor: MyColor.transparentColor,
                              activeFillColor: MyColor.transparentColor,
                              activeColor: MyColor.primaryColor,
                              selectedFillColor: MyColor.transparentColor,
                              selectedColor: MyColor.primaryColor
                          ),
                          cursorColor: MyColor.primaryColor,
                          animationDuration:
                          const Duration(milliseconds: 100),
                          enableActiveFill: true,
                          keyboardType: TextInputType.number,
                          beforeTextPaste: (text) {
                            return true;
                          },
                          onChanged: (value) {
                            setState(() {
                              controller.currentText = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: Dimensions.space30),
                      controller.submitLoading ? const RoundedLoadingBtn() : RoundedButton(
                        text: MyStrings.verify.tr,
                        textColor: MyColor.colorWhite,
                        press: (){
                          controller.verifyYourSms(controller.currentText);
                        },
                        color: MyColor.primaryColor,
                      ),
                      const SizedBox(height: Dimensions.space30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(MyStrings.didNotReceiveCode.tr, style: interRegularDefault.copyWith(color: MyColor.labelTextColor)),
                          const SizedBox(width: Dimensions.space10),
                          controller.resendLoading ?
                          Container(margin: const EdgeInsets.all(5),height:20,width:20,child: const CircularProgressIndicator(color: MyColor.primaryColor)):
                          GestureDetector(
                              onTap: () {
                                controller.sendCodeAgain();
                              },
                              child: Text(
                                  MyStrings.resend.tr,
                                  style: interRegularDefault.copyWith(decoration: TextDecoration.underline, color: MyColor.primaryColor)
                              )
                          ),
                        ],
                      )
                    ],
                  ),
                )
            ),
          ),
        ),
      ),
   );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmsVerificationController>(
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
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 1.0),
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
                            MyStrings.smsVerification.tr,
                            textAlign: TextAlign.left,
                            style: interSemiBoldOverLarge.copyWith(color: MyColor.colorWhite,decorationColor:MyColor.primaryColor)
                        ),
                      ),
                      // To keep the title centered, you can add an empty `SizedBox`
                      const SizedBox(width: 48.0),
                    ],
                  ),
                ),
                controller.isLoading ? const Center(
                    child: CircularProgressIndicator(color: MyColor.primaryColor)
                ) : Align(
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
                                        child: Text(MyStrings.smsVerificationMsg.tr, maxLines: 2, textAlign: TextAlign.center,style: interRegularLarge.copyWith(color: MyColor.labelTextColor)),
                                      ),
                                      const SizedBox(height: Dimensions.space30),
                                      OTPFieldWidget(
                                        onChanged: (value) {
                                          controller.currentText = value;
                                        },
                                      ),
                                      const SizedBox(height: Dimensions.space30),
                                      controller.submitLoading ? const RoundedLoadingBtn() : RoundedButton(
                                        text: MyStrings.verify.tr,
                                        textColor: MyColor.colorWhite,
                                        press: (){
                                          controller.verifyYourSms(controller.currentText);
                                        },
                                        color: MyColor.appPrimaryColorSecondary2,
                                      ),
                                      const SizedBox(height: Dimensions.space20),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(MyStrings.didNotReceiveCode.tr, style: interMediumLarge.copyWith(color: MyColor.labelTextColor)),
                                          const SizedBox(width: Dimensions.space5),
                                          controller.resendLoading?
                                          Container(margin:const EdgeInsets.only(left: 5,top: 5),height:20,width:20,child: const CircularProgressIndicator(color: MyColor.primaryColor)):
                                          GestureDetector(
                                            onTap: (){
                                              controller.sendCodeAgain();
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








