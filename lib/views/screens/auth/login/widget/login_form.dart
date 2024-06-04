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
                  text: MyStrings.usernameOrEmail.tr,
                  style: interRegularDefault.copyWith(color: MyColor.colorWhite,decorationColor:MyColor.primaryColor),
                  children: [
                    TextSpan(
                        text: ' *', style: TextStyle(fontSize: 20,color: Colors.red,fontWeight: FontWeight.bold))
                  ]),
            ),
            // Text(MyStrings.usernameOrEmail.tr, style: interRegularDefault.copyWith(color: MyColor.colorWhite,decorationColor:MyColor.primaryColor)),

            const SizedBox(height:Dimensions.space10),
           TextField(
            decoration: new InputDecoration(
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal)
                ),

            ),
             controller: controller.emailController,
             focusNode: controller.emailFocusNode,
             onChanged: (value){},
          ),
            /*CustomTextField(
              labelText: MyStrings.usernameOrEmail,
              textInputType: TextInputType.name,
              hintText: MyStrings.enterUsernameOrEmail,
              controller: controller.emailController,
              focusNode: controller.emailFocusNode,
              nextFocus: controller.passwordFocusNode,
              inputAction: TextInputAction.next,
              onChanged: (value){},
              validator: (value) {
                if (value!.isEmpty) {
                  return MyStrings.fieldErrorMsg.tr;
                } else {
                  return null;
                }
              },
            ),*/

            const SizedBox(height:Dimensions.space10),
            RichText(
              text: TextSpan(
                  text: MyStrings.password.tr, style: interRegularDefault.copyWith(color: MyColor.colorWhite,decorationColor:MyColor.primaryColor),
                  children: [
                    TextSpan(
                        text: ' *', style: TextStyle(fontSize: 20,color: Colors.red,fontWeight: FontWeight.bold))
                  ]
              ),
            ),

            const SizedBox(height:Dimensions.space10),
            TextField(
              decoration: new InputDecoration(
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.white)
                ),
                  suffixIcon: IconButton(
                      icon:Icon(obscureText ? Icons.visibility_off : Icons.visibility, color: MyColor.colorWhite, size: 16),
                      onPressed: _toggle)
              ),
              obscureText: obscureText,
              controller: controller.passwordController,
              focusNode: controller.passwordFocusNode,
              onChanged: (value){},
            ),

            /*CustomTextField(
              labelText: MyStrings.password,
              isPassword: true,
              hintText: MyStrings.enterYourPassword,
              onChanged: (value){},
              isShowSuffixIcon: true,
              controller: controller.passwordController,
              focusNode: controller.passwordFocusNode,
              inputAction: TextInputAction.go,
              onSubmitted:(value){
                if(formKey.currentState!.validate()){
                  controller.loginUser();
                }
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return MyStrings.fieldErrorMsg.tr;
                } else {
                  return null;
                }
              },
            ),*/
            const SizedBox(height:Dimensions.space10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    controller.changeRememberMe();
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Checkbox(
                            fillColor: MaterialStatePropertyAll<Color>(controller.remember ?MyColor.primaryColor:Colors.white,),
                            activeColor:  controller.remember ?MyColor.colorWhite:Colors.white,
                            value: controller.remember,
                            side: MaterialStateBorderSide.resolveWith((states) => BorderSide(
                                width: 1.0,
                                color: controller.remember ? MyColor.transparentColor : MyColor.colorWhite),
                            ),
                            onChanged: (value) {
                              controller.changeRememberMe();
                            }
                        ),
                      ),
                      const SizedBox(width: Dimensions.space10),
                      Text(MyStrings.rememberMe.tr,
                        style: interRegularDefault.copyWith(color: MyColor.colorWhite),overflow: TextOverflow.ellipsis,)
                    ],
                  ),
                ),
                TextButton(
                  onPressed: (){
                    controller.clearData();
                    controller.forgetPassword();
                  },
                  child: Text(MyStrings.loginForgotPassword.tr, style: interRegularDefault.copyWith(color: MyColor.primaryColor,decorationColor:MyColor.primaryColor,decoration: TextDecoration.underline)),
                )
              ],
            ),
            const SizedBox(height: Dimensions.space35,),
            controller.isSubmitLoading ? const RoundedLoadingBtn() : RoundedButton(
              text: MyStrings.signIn,
              color: MyColor.primaryColor,
              textColor: MyColor.colorWhite,
              press: (){
                if(formKey.currentState!.validate()){
                  controller.loginUser();
                }
              }
            ),
            const SizedBox(height: Dimensions.space40),
            const BottomSection()
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
