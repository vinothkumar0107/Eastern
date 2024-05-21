import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_images.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/data/controller/auth/two_factor_controller.dart';
import 'package:eastern_trust/data/repo/auth/two_factor_repo.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:eastern_trust/views/components/appbar/custom_appbar.dart';
import 'package:eastern_trust/views/components/buttons/rounded_button.dart';
import 'package:eastern_trust/views/components/buttons/rounded_loading_button.dart';

class TwoFactorVerificationScreen extends StatefulWidget {

  final bool isProfileCompleteEnable;
  const TwoFactorVerificationScreen({
    Key? key,
    required this.isProfileCompleteEnable
  }) : super(key: key);

  @override
  State<TwoFactorVerificationScreen> createState() => _TwoFactorVerificationScreenState();
}

class _TwoFactorVerificationScreenState extends State<TwoFactorVerificationScreen> {

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(TwoFactorRepo(apiClient: Get.find()));
    final controller = Get.put(TwoFactorController(repo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.isProfileCompleteEnable=widget.isProfileCompleteEnable;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColor.containerBgColor,
        appBar: CustomAppBar(title: MyStrings.twoFactorAuth.tr,fromAuth: true),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space20),
          child: GetBuilder<TwoFactorController>(
              builder: (controller) =>  Center(
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
                      child: Text(MyStrings.twoFactorMsg.tr, maxLines: 2, textAlign: TextAlign.center,style: interRegularDefault.copyWith(color: MyColor.labelTextColor)),
                    ),
                    const SizedBox(height: Dimensions.space30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.space30),
                      child: PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: interRegularDefault.copyWith(color: MyColor.colorBlack),
                        length: 6,
                        textStyle: interRegularDefault.copyWith(color: MyColor.colorBlack),
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
                            inactiveFillColor: MyColor.containerBgColor,
                            activeFillColor: MyColor.containerBgColor,
                            activeColor: MyColor.primaryColor,
                            selectedFillColor: MyColor.containerBgColor,
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
                    controller.submitLoading?const RoundedLoadingBtn() : RoundedButton(
                      press: (){
                        controller.verifyYourSms(controller.currentText);
                      },
                      text: MyStrings.verify,
                    ),
                    const SizedBox(height: Dimensions.space30),
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }
}
