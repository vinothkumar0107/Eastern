import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/data/controller/otp/otp_controller.dart';
import 'package:eastern_trust/data/repo/otp/otp_repo.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:eastern_trust/views/components/appbar/custom_appbar.dart';
import 'package:eastern_trust/views/components/timer/timer.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(OtpRepo(apiClient: Get.find()));
    final controller = Get.put(OtpController(repo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      String nextPageRoute = Get.arguments[0]??'';
      String otpId = Get.arguments[1];
      String otpType = Get.arguments[2];
      controller.initData(otpType,otpId,nextPageRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor:MyColor.getScreenBgColor2(),
          appBar: const CustomAppBar(title: MyStrings.otpVerification),
          body: GetBuilder<OtpController>(
            builder: (controller) =>  SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(Dimensions.space7),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: MyColor.primaryColor,
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(22)),
                    ),
                    child: const SizedBox(height: Dimensions.space25,),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.symmetric(vertical: Dimensions.space30, horizontal: Dimensions.space15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(MyStrings.enterYourOTPCode.tr, style: interRegularMediumLarge.copyWith(color: MyColor.colorBlack, fontWeight: FontWeight.w600)),
                        const SizedBox(height: Dimensions.space10),
                        Text(controller.otpType=="sms"?MyStrings.sixDigitSMSOtpMsg:controller.otpType == "email"?MyStrings.sixDigitEmailOtpMsg:controller.otpType=='2fa'?MyStrings.twoFactorMsg.tr:'', maxLines: 2, textAlign: TextAlign.start, style: interRegularLarge.copyWith(color: MyColor.getGreyText())),
                        const SizedBox(height: Dimensions.space30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15),
                          child: PinCodeTextField(
                            appContext: context,
                            pastedTextStyle: interRegularDefault.copyWith(color: MyColor.getPrimaryColor()),
                            length: 6,
                            textStyle: interRegularLarge.copyWith(color: MyColor.getPrimaryColor()),
                            obscuringCharacter: '*',
                            animationType: AnimationType.fade,
                            pinTheme: PinTheme(
                                shape: PinCodeFieldShape.underline,
                                borderWidth: 1,
                                borderRadius: BorderRadius.circular(5),
                                inactiveColor:  MyColor.getTextFieldDisableBorder(),
                                inactiveFillColor: MyColor.transparentColor,
                                activeFillColor: MyColor.transparentColor,
                                activeColor: MyColor.getPrimaryColor(),
                                selectedFillColor: MyColor.transparentColor,
                                selectedColor: MyColor.getPrimaryColor()
                            ),
                            cursorColor: MyColor.getTextColor(),
                            animationDuration: const Duration(milliseconds: 0),
                            enableActiveFill: true,
                            keyboardType: TextInputType.number,
                            beforeTextPaste: (text) {
                              return true;
                            },
                            onChanged: (value) {
                              controller.currentText = value;
                              if(value.length == 6){
                                controller.submitOtp(value);
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: Dimensions.space15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            controller.isOtpExpired ? Row(
                              children: [
                                Text(MyStrings.otpHasBeenExpired.tr, style: interRegularDefault.copyWith(color: MyColor.labelTextColor)),
                                const SizedBox(width: Dimensions.space12),
                                controller.resendLoading? Container(
                                    margin:const EdgeInsets.only(left: 5,top: 5),
                                    height:20,width:20,
                                    child: CircularProgressIndicator(color: MyColor.getPrimaryColor())
                                ) : GestureDetector(
                                  onTap: (){
                                    controller.sendCodeAgain();
                                  },
                                  child: Text(MyStrings.resend.tr, style: interRegularDefault.copyWith(color: MyColor.getPrimaryColor(),decoration: TextDecoration.underline)),
                                )
                              ],
                            ) : OtpTimer(
                                duration: controller.time,
                                onTimeComplete: (){
                                  controller.makeOtpExpired(true);
                                }
                            ),
                            GestureDetector(
                              onTap: () => controller.submitOtp(controller.currentText),
                              child: Container(
                                height: 40, width: 40,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(color: MyColor.primaryColor, shape: BoxShape.circle),
                                child: controller.submitLoading ? const SizedBox(
                                  height: 20, width: 20,
                                  child: CircularProgressIndicator(
                                    color: MyColor.colorWhite,
                                    strokeWidth: 2,
                                  ),
                                ) : const Icon(Icons.arrow_forward, color: MyColor.colorWhite, size: 20),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
}
