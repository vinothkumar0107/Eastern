import 'package:eastern_trust/views/screens/auth/registration/widget/bottom_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/data/controller/auth/auth/registration_controller.dart';
import 'package:eastern_trust/data/repo/auth/general_setting_repo.dart';
import 'package:eastern_trust/data/repo/auth/signup_repo.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:eastern_trust/views/components/appbar/custom_appbar.dart';
import 'package:eastern_trust/views/components/custom_loader.dart';
import 'package:eastern_trust/views/components/will_pop_widget.dart';
import 'package:eastern_trust/views/screens/auth/registration/widget/registration_form.dart';

import '../../../../core/utils/my_images.dart';
import '../../../../core/utils/my_strings.dart';


class RegistrationScreen extends StatefulWidget {

  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GeneralSettingRepo(apiClient: Get.find()));
    Get.put(RegistrationRepo(apiClient: Get.find()));
    Get.put(RegistrationController(registrationRepo: Get.find(), generalSettingRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<RegistrationController>().initData();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build2(BuildContext context) {

    return GetBuilder<RegistrationController>(
      builder: (controller) => WillPopWidget(
        nextRoute: RouteHelper.loginScreen,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: MyColor.primaryColor2,
            appBar: const CustomAppBar(title: MyStrings.signUp,fromAuth: true,),
            body: controller.isLoading ? const CustomLoader() : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Image.asset(MyImages.appLogo,width: 300,height: 150)),
                   /* Text(MyStrings.signUpTitle.tr, style: interSemiBoldExtraLarge.copyWith(fontSize:Dimensions.fontHeader2,fontWeight: FontWeight.w500)),
                    const SizedBox(height: 15),
                    Padding(
                      padding: EdgeInsetsDirectional.only(end: MediaQuery.of(context).size.width*.2),
                      child: Text(MyStrings.signUpSologan.tr, textAlign: TextAlign.left,style: interRegularDefault.copyWith(color: MyColor.getGreyText(),fontWeight: FontWeight.w500),)),
                   */ const SizedBox(height: Dimensions.space30),
                    const RegistrationForm(),
                    ],
                  ),
                ),
              ),
            )
          ),
      ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
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
            body: controller.isLoading ? const CustomLoader() : Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 2.8, // Half of the screen height
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
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(15.0, 100.0, 15.0, 0.0),
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
                              child: Column(
                                children: [
                                  Center(
                                    child: SizedBox(
                                      width: 200,
                                      height: 100, // Adjust height as needed
                                      child: Image.asset(
                                        MyImages.appLogo,
                                        fit: BoxFit.fitWidth, // Image covers the entire container
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: Dimensions.space15),
                                  const RegistrationForm(), // Your form goes here
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 5), // Add spacing if needed
                          const BottomSectionRegistration(),
                          const SizedBox(height: Dimensions.space30),
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
