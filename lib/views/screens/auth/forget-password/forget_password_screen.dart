import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/data/controller/auth/forget_password/forget_password_controller.dart';
import 'package:eastern_trust/data/repo/auth/login_repo.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:eastern_trust/views/components/appbar/custom_appbar.dart';
import 'package:eastern_trust/views/components/buttons/rounded_button.dart';
import 'package:eastern_trust/views/components/buttons/rounded_loading_button.dart';
import 'package:eastern_trust/views/components/heading_text_widget.dart';
import 'package:eastern_trust/views/components/text-field/custom_text_field.dart';

import '../../../../core/utils/my_images.dart';
import '../../../../core/utils/style.dart';
import '../../../components/appbar/appbar_specific_device.dart';
import '../../../components/will_pop_widget.dart';

class ForgetPasswordScreen extends StatefulWidget {

  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient: Get.find()));
    Get.put(ForgetPasswordController(loginRepo: Get.find()));
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPasswordController>(
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
                          Navigator.of(context).pop();
                        },
                      ),
                      Expanded(
                        child: Text(
                          MyStrings.forgotPassword,
                          textAlign: TextAlign.left,
                          style: interBoldOverLarge.copyWith(color: MyColor.colorWhite,decorationColor:MyColor.primaryColor)
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
                    padding: const EdgeInsets.fromLTRB(15.0, 70.0, 15.0, 0.0),
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
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
                                    const SizedBox(height: Dimensions.space15),
                                    const HeadingTextWidget(header:MyStrings.recoverAccount,body: MyStrings.resetPassMsg,),
                                    const SizedBox(height: Dimensions.space25),
                                    CustomTextField(
                                        needOutlineBorder: true,
                                        needLabel: false,
                                        labelText: MyStrings.usernameOrEmail.toString(),
                                        hintText: MyStrings.enterUsernameOrEmail.toString(),
                                        textInputType: TextInputType.emailAddress,
                                        inputAction: TextInputAction.go,
                                        controller: controller.emailOrUsernameController,
                                        onSuffixTap: () {},
                                        onSubmitted: (value){
                                          if(formKey.currentState!.validate()){
                                            controller.submitForgetPassCode();
                                          }
                                        },
                                        onChanged: (value) {
                                          return;
                                        },
                                        validator: (value) {
                                          if (controller.emailOrUsernameController.text.isEmpty) {
                                            return MyStrings.enterUsernameOrEmail.tr;
                                          } else {
                                            return null;
                                          }
                                        }),
                                    const SizedBox(height: Dimensions.space30),
                                    controller.submitLoading ? const RoundedLoadingBtn() : RoundedButton(
                                      press: () {
                                        if(formKey.currentState!.validate()){
                                          controller.submitForgetPassCode();
                                        }
                                      },
                                      text: MyStrings.submit.tr,
                                      textColor: MyColor.colorWhite,
                                      color: MyColor.appPrimaryColorSecondary2,
                                    ),
                                    const SizedBox(height: Dimensions.space20),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10), // Add spacing if needed
                          ],
                        ),
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
