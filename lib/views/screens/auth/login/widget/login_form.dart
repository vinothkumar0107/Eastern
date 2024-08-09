import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/data/controller/auth/login_controller.dart';
import 'package:eastern_trust/views/components/buttons/rounded_button.dart';
import 'package:eastern_trust/views/components/buttons/rounded_loading_button.dart';
import 'package:eastern_trust/views/components/text-field/custom_text_field.dart';
import 'package:eastern_trust/views/screens/auth/login/widget/bottom_section.dart';

class LoginForm extends StatefulWidget {
  
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final formKey = GlobalKey<FormState>();

  bool obscureText = true;



  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) => Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                  text: MyStrings.welcomeBackAgain.tr,
                  style: interBoldHeader1.copyWith(color: MyColor.colorBlack,decorationColor:MyColor.primaryColor),
                  ),
            ),
            const SizedBox(height:Dimensions.space30),
            SizedBox(
              height: 60,
              child: TextField(
                controller: controller.emailController,
                focusNode: controller.emailFocusNode,
                style: interRegularDefault.copyWith(color: MyColor.colorBlack,decorationColor:MyColor.primaryColor),
                onChanged: (value) {},
                decoration: InputDecoration(
                  hintText: MyStrings.enterUsernameOrEmail,
                  hintStyle: interRegularDefault.copyWith(color: MyColor.colorGrey,decorationColor:MyColor.primaryColor),// Placeholder text
                  filled: true, // Enable background color
                  fillColor: MyColor.liteGreyColor, // Background color
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0), // Rounded corners
                    borderSide: const BorderSide(
                      color: MyColor.liteGreyColorBorder, // Border color
                      width: 1.0, // Border width
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0), // Rounded corners when enabled
                    borderSide: const BorderSide(
                      color: MyColor.liteGreyColorBorder, // Border color when enabled
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0), // Rounded corners when focused
                    borderSide: const BorderSide(
                      color: MyColor.primaryColor, // Border color when focused
                      width: 1.0,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0), // Padding inside the TextField
                ),
              ),
            ),
            const SizedBox(height:Dimensions.space25),
            CustomTextField(
              needOutlineBorder: true,
              needLabel: false,
              isShowSuffixIcon: true,
              isPassword: true,
              labelText: MyStrings.password,
              controller: controller.passwordController,
              focusNode: controller.passwordFocusNode,
              hintText: MyStrings.enterYourPassword.tr,
              textInputType: TextInputType.text,
              onChanged: (value) {},
              validator: (value) {return;},
            ),
            const SizedBox(height:Dimensions.space10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: (){
                    controller.clearData();
                    controller.forgetPassword();
                  },
                  child: Text(MyStrings.loginForgotPassword.tr, style: interBoldMediumLarge.copyWith(color: MyColor.colorGrey2,decorationColor:MyColor.colorGrey,decoration: TextDecoration.none)),
                )
              ],
            ),
            const SizedBox(height: Dimensions.space25,),
            controller.isSubmitLoading ? const RoundedLoadingBtn() : RoundedButton(
              text: MyStrings.login,
              color: MyColor.appPrimaryColorSecondary2,
              textColor: MyColor.colorWhite,
              press: (){
                if(formKey.currentState!.validate()){
                  controller.loginUser();
                }
              }
            ),
            const SizedBox(height: Dimensions.space10),
            // const BottomSection()
          ],
        ),
      ),
    );
  }

  void _toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
// Toggles the password show status
