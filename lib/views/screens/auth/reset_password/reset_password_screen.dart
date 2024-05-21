import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/data/controller/auth/forget_password/reset_password_controller.dart';
import 'package:eastern_trust/data/repo/auth/login_repo.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:eastern_trust/views/components/appbar/custom_appbar.dart';
import 'package:eastern_trust/views/components/buttons/rounded_button.dart';
import 'package:eastern_trust/views/components/buttons/rounded_loading_button.dart';
import 'package:eastern_trust/views/components/text-field/custom_text_field.dart';
import 'package:eastern_trust/views/components/text/default_text.dart';
import 'package:eastern_trust/views/components/text/header_text.dart';

import 'widget/validation_widget.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient:Get.find()));
    final controller =Get.put(ResetPasswordController(loginRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.email = Get.arguments[0];
      controller.code = Get.arguments[1];
    });

  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
              backgroundColor: MyColor.colorWhite,
              appBar: CustomAppBar(title:MyStrings.resetPassword.tr, fromAuth: true),
              body: GetBuilder<ResetPasswordController>(
                builder: (controller) => SingleChildScrollView(
                  padding: Dimensions.screenPaddingHV,
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: Dimensions.space30),
                        HeaderText(text: MyStrings.resetYourPassword.tr),
                        const SizedBox(height: Dimensions.space15),
                        Padding(padding: EdgeInsetsDirectional.only(end: MediaQuery.of(context).size.width*.2),
                        child: DefaultText(maxLines:3,text: MyStrings.resetPassContent.tr, textStyle: interRegularDefault.copyWith(color: MyColor.getGreyText())),),
                        const SizedBox(height: Dimensions.space20),
                        Visibility(
                            visible: controller.hasPasswordFocus && controller.checkPasswordStrength,
                            child: ValidationWidget(list: controller.passwordValidationRulse,fromReset: true,)),

                        Focus(
                          onFocusChange: (hasFocus){
                            controller.changePasswordFocus(hasFocus);
                          },
                          child: CustomTextField(
                              focusNode: controller.passwordFocusNode,
                              nextFocus: controller.confirmPasswordFocusNode,
                              labelText: MyStrings.password,
                              hintText: MyStrings.enterYourPassword.tr,
                              isShowSuffixIcon: true,
                              isPassword: true,
                              textInputType: TextInputType.text,
                              controller: controller.passController,
                              validator: (value) {
                                return controller.validatPassword(value ?? '');
                              },
                              onChanged: (value) {
                                if(controller.checkPasswordStrength){
                                  controller.updateValidationList(value);
                                }
                               return;
                              }
                          ),
                        ),
                        const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
                        CustomTextField(
                            inputAction: TextInputAction.done,
                            isPassword: true,
                            labelText: MyStrings.confirmPassword,
                            hintText: MyStrings.confirmYourPassword.tr,
                            isShowSuffixIcon: true,
                            controller: controller.confirmPassController,
                            onChanged: (value){
                              return;
                            },
                            validator: (value) {
                            if (controller.passController.text.toLowerCase() != controller.confirmPassController.text.toLowerCase()) {
                              return MyStrings.kMatchPassError.tr;
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: Dimensions.space35),
                        controller.submitLoading ? const RoundedLoadingBtn() : RoundedButton(
                          color: MyColor.primaryColor,
                          textColor: MyColor.colorWhite,
                          width: 1,
                          text: MyStrings.submit.tr,
                          press: () {
                            if (formKey.currentState!.validate()) {
                              controller.resetPassword();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ),
        ),
    );
  }
}

