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

import '../../components/buttons/rounded_button.dart';
import '../../components/buttons/rounded_loading_button.dart';
import '../../components/otp_field_widget/otp_field_widget.dart';
import '../../components/will_pop_widget.dart';

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
    return GetBuilder<OtpController>(
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
            backgroundColor: MyColor.getScreenBgColor2(),
            body: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 3.0, // Half of the screen height
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [MyColor.primaryColor2, MyColor.primaryColor],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: MyColor.colorWhite, // Use the same color for the bottom half
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 60.0),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      Expanded(
                        child: Text(
                            MyStrings.otpVerification.tr,
                            textAlign: TextAlign.left,
                            style: interSemiBoldOverLarge.copyWith(color: MyColor.colorWhite,decorationColor:MyColor.primaryColor)
                        ),
                      ),
                      // To keep the title centered, you can add an empty `SizedBox`
                      const SizedBox(width: 48.0),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(15.0, 130.0, 15.0, 0.0),
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
                                        padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSize10),
                                        child: Column(
                                          children: [
                                            Text(MyStrings.enterYourOTPCode.tr, style: interRegularMediumLarge.copyWith(color: MyColor.colorBlack, fontWeight: FontWeight.w600)),
                                            const SizedBox(height: Dimensions.space20),
                                            Text(controller.otpType=="sms"?MyStrings.sixDigitSMSOtpMsg:controller.otpType == "email"?MyStrings.sixDigitEmailOtpMsg:controller.otpType=='2fa'?MyStrings.twoFactorMsg.tr:'', maxLines: 2, textAlign: TextAlign.start, style: interRegularLarge.copyWith(color: MyColor.labelTextColor)),
                                          ],
                                        )
                                      ),

                                      const SizedBox(height: Dimensions.space30),
                                      OTPFieldWidget(
                                        onChanged: (value) {
                                          controller.currentText = value;
                                        },
                                      ),

                                      const SizedBox(height: Dimensions.space30),
                                      controller.submitLoading?const RoundedLoadingBtn() : RoundedButton(
                                        press: (){
                                          controller.submitOtp(controller.currentText);
                                        },
                                        text: MyStrings.verify,
                                        textColor: MyColor.colorWhite,
                                        color: MyColor.appPrimaryColorSecondary2,
                                      ),
                                      const SizedBox(height: Dimensions.space15),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          controller.isOtpExpired ? Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
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
                                        ],
                                      ),
                                      const SizedBox(height: Dimensions.space30),
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
