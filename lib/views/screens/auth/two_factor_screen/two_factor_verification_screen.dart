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
import 'package:eastern_trust/data/controller/auth/two_factor_controller.dart';
import 'package:eastern_trust/data/repo/auth/two_factor_repo.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:eastern_trust/views/components/appbar/custom_appbar.dart';
import 'package:eastern_trust/views/components/buttons/rounded_button.dart';
import 'package:eastern_trust/views/components/buttons/rounded_loading_button.dart';

import '../../../../core/route/route.dart';
import '../../../../data/repo/home/home_repo.dart';
import '../../../components/otp_field_widget/otp_field_widget.dart';
import '../../../components/will_pop_widget.dart';

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
    Get.put(HomeRepo(apiClient: Get.find()));
    final controller = Get.put(TwoFactorController(repo: Get.find(), homeRepo: Get.find()),);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.isProfileCompleteEnable=widget.isProfileCompleteEnable;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  // need to remove
  @override
  Widget build2(BuildContext context) {
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

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TwoFactorController>(
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
            backgroundColor: MyColor.appPrimaryColorSecondary2,
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
                          // Navigator.of(context).pop();
                          Get.offAndToNamed(RouteHelper.loginScreen);
                        },
                      ),
                      Expanded(
                        child: Text(
                            MyStrings.twoFactorAuth.tr,
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
                                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.1),
                                        child: Text(MyStrings.twoFactorMsg.tr, maxLines: 2, textAlign: TextAlign.center,style: interRegularLarge.copyWith(color: MyColor.labelTextColor)),
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
                                          controller.verifyYourSms(controller.currentText);
                                        },
                                        text: MyStrings.verify,
                                        textColor: MyColor.colorWhite,
                                        color: MyColor.appPrimaryColorSecondary2,
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

  // need to remove
  @override
  Widget build3(BuildContext context) {
    return GetBuilder<TwoFactorController>(
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
            appBar: AppBar(
              scrolledUnderElevation: 0,
              elevation: 0,
              toolbarHeight: 0,
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: MyColor.primaryColor2,
                  statusBarIconBrightness: Brightness.light,
                  systemNavigationBarColor: MyColor.navigationBarColor,
                  systemNavigationBarIconBrightness: Brightness.dark),
            ),
            backgroundColor: MyColor.appPrimaryColorSecondary2,
            body: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 3.5, // Half of the screen height
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [MyColor.primaryColor2, MyColor.primaryColor, MyColor.primaryColor],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
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
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
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
                            MyStrings.twoFactorAuth.tr,
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
                    padding: const EdgeInsets.fromLTRB(15.0, 80.0, 15.0, 0.0),
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
                                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.1),
                                        child: Text(MyStrings.twoFactorMsg.tr, maxLines: 2, textAlign: TextAlign.center,style: interRegularLarge.copyWith(color: MyColor.labelTextColor)),
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
                                          controller.verifyYourSms(controller.currentText);
                                        },
                                        text: MyStrings.verify,
                                        textColor: MyColor.colorWhite,
                                        color: MyColor.appPrimaryColorSecondary2,
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
