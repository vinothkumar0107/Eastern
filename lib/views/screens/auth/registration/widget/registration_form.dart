import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/data/controller/auth/auth/registration_controller.dart';
import 'package:eastern_trust/views/components/buttons/rounded_button.dart';
import 'package:eastern_trust/views/components/buttons/rounded_loading_button.dart';
import 'package:eastern_trust/views/components/text-field/custom_text_field.dart';
import 'package:eastern_trust/views/screens/auth/registration/widget/country_bottom_sheet.dart';
import 'package:eastern_trust/views/screens/auth/registration/widget/country_text_field.dart';
import 'package:eastern_trust/views/screens/auth/reset_password/widget/validation_widget.dart';

class RegistrationForm extends StatefulWidget {

  const RegistrationForm({Key? key}) : super(key: key);

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
      builder: (controller) => Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: MyStrings.signUp.tr,
                style: interBoldHeader1.copyWith(color: MyColor.colorBlack,decorationColor:MyColor.primaryColor),
              ),
            ),
            const SizedBox(height:Dimensions.space30),
            CustomTextField(
              needLabel: false,
              needOutlineBorder: true,
              labelText: MyStrings.username.tr,
              hintText: MyStrings.enterYourUsername.tr,
              controller: controller.userNameController,
              focusNode: controller.userNameFocusNode,
              textInputType: TextInputType.text,
              nextFocus: controller.emailFocusNode,
              validator: (value) {
                if (value!.isEmpty) {
                  return MyStrings.enterYourUsername.tr;
                } else if(value.length<6){
                  return MyStrings.kShortUserNameError.tr;
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                formKey.currentState!.validate();
                return;
              },
            ),
            const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
            CustomTextField(
              needLabel: false,
              needOutlineBorder: true,
              labelText: MyStrings.email.tr,
              hintText: MyStrings.enterYourEmail.tr,
              controller: controller.emailController,
              focusNode: controller.emailFocusNode,
              textInputType: TextInputType.emailAddress,
              inputAction: TextInputAction.next,
              validator: (value) {
                if (value!=null && value.isEmpty) {
                  return MyStrings.enterYourEmail.tr;
                } else if(!MyStrings.emailValidatorRegExp.hasMatch(value??'')) {
                  return MyStrings.invalidEmailMsg.tr;
                }else{
                  return null;
                }
              },
              onChanged: (value) {
                formKey.currentState!.validate();
                return;
              },
            ),
            const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
            CountryTextField(
              press: (){
                CountryBottomSheet.bottomSheet(context, controller);
              },
              text:controller.countryName == null?MyStrings.selectACountry.tr:(controller.countryName)!.tr,
            ),
            const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: MyColor.borderColor), // Add border color
                borderRadius: BorderRadius.circular(Dimensions.paddingSize25),
                color: MyColor.liteGreyColor// Add corner radius
              ),
              child: Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: FractionallySizedBox(
                      widthFactor: 1, // This will give you the desired effect
                      child:CustomTextField(
                        labelText: MyStrings.phone,
                        hintText: MyStrings.code.tr,
                        needOutlineBorder: true,
                        needLabel: false,
                        controller: TextEditingController(text: controller.mobileCode??''),
                        textInputType: TextInputType.phone,
                        disableColor: controller.hasMobileFocus?MyColor.colorWhite:MyColor.colorWhite,
                        isEnable: false,
                        backgroundColor: MyColor.transparentColor,
                        borderWidth: 0,
                        onChanged: (value) {
                          return;
                        },
                      ),),
                  ),
                  const SizedBox(width: 8,),
                  Flexible(
                      flex: 10,
                      child: Focus(
                        onFocusChange: (hasFocus){
                          controller.changeMobileFocus(hasFocus);
                        },
                        child:  CustomTextField(
                          needOutlineBorder: true,
                          needLabel: false,
                          labelText: '',
                          hintText: MyStrings.enterYourPhoneNo.tr,
                          controller: controller.mobileController,
                          focusNode: controller.mobileFocusNode,
                          textInputType: TextInputType.phone,
                          inputAction: TextInputAction.next,
                          backgroundColor: MyColor.transparentColor,
                          disableColor: controller.hasMobileFocus?MyColor.colorWhite:MyColor.colorWhite,
                          borderWidth: 0,
                          onChanged: (value) {
                            formKey.currentState!.validate();
                            return;
                          },
                          validator: (value){
                            if(value.toString().isEmpty){
                              return MyStrings.enterYourPhoneNumber.tr;
                            }
                            return null;
                          },
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
            Visibility(
                visible: controller.hasPasswordFocus && controller.checkPasswordStrength,
                child: ValidationWidget(fromReset: true,list: controller.passwordValidationRulse,)),
            Focus(
                onFocusChange: (hasFocus){
                  controller.changePasswordFocus(hasFocus);
                },
                child: CustomTextField(
                  needOutlineBorder: true,
                  needLabel: false,
                  isShowSuffixIcon: true,
                  isPassword: true,
                  labelText: MyStrings.password,
                  controller: controller.passwordController,
                  focusNode: controller.passwordFocusNode,
                  nextFocus: controller.confirmPasswordFocusNode,
                  hintText: MyStrings.enterYourPassword.tr,
                  textInputType: TextInputType.text,
                  onChanged: (value) {
                    if(controller.checkPasswordStrength){
                      controller.updateValidationList(value);
                    }
                    formKey.currentState!.validate();
                  },
                  validator: (value) {
                    return controller.validatPassword(value ?? '');
                  },
                )),
            const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
            CustomTextField(
              needOutlineBorder: true,
              needLabel: false,
              labelText: MyStrings.confirmPassword.tr,
              hintText: controller.isPasswordMatched
                  ? MyStrings.confirmYourPassword.tr
                  : "",
              controller: controller.cPasswordController,
              focusNode: controller.confirmPasswordFocusNode,
              inputAction: TextInputAction.done,
              isShowSuffixIcon: true,
              isPassword: true,
              onChanged: (value) {
                final password = controller.passwordController.text.trim();
                final confirm = controller.cPasswordController.text.trim();

                final isMatch =
                    password.toLowerCase() == confirm.toLowerCase();

                if (controller.isPasswordMatched != isMatch) {
                  controller.isPasswordMatched = isMatch;
                  controller.update(); // rebuild GetBuilder
                }

                formKey.currentState?.validate();
              },
              validator: (value) {
                if (controller.passwordController.text.toLowerCase() !=
                    controller.cPasswordController.text.toLowerCase()) {
                  return MyStrings.kMatchPassError.tr;
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
            Visibility(
                visible: controller.needAgree,
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: Checkbox(
                          fillColor: MaterialStatePropertyAll<Color>(controller.agreeTC ?MyColor.primaryColor:Colors.transparent,),
                          activeColor:  controller.agreeTC ?MyColor.colorGrey:Colors.transparent,
                          value: controller.agreeTC,
                          side: MaterialStateBorderSide.resolveWith((states) => BorderSide(
                              width: 1.0,
                              color: controller.agreeTC ? MyColor.transparentColor : MyColor.primaryColor),
                          ),
                          onChanged: (value) {
                            controller.updateAgreeTC();
                          }
                      ),
                    ),
                    const SizedBox(width: 8,),
                    Row(
                      children: [
                        Text(MyStrings.iAgreeWith.tr, style: interSemiBoldDefault.copyWith(color: MyColor.colorBlack, fontWeight: FontWeight.w400)),
                        const SizedBox(width: 3),
                        GestureDetector(
                          onTap: (){
                            Get.toNamed(RouteHelper.privacyScreen);
                          },
                          child: Text(MyStrings.privacyPolicies.tr.toLowerCase(), style: interSemiBoldDefault.copyWith(
                              color: MyColor.primaryColor,
                              decoration: TextDecoration.none,
                              decorationColor: MyColor.primaryColor
                          )),
                        ),
                        const SizedBox(width: 3),
                      ],
                    ),
                  ],
                )),
            const SizedBox(height: Dimensions.space30),
            controller.submitLoading ? const RoundedLoadingBtn() : RoundedButton(
                text: MyStrings.signUp,
                textColor: MyColor.colorWhite,
                color: MyColor.appPrimaryColorSecondary2,
                press: (){
                  if (formKey.currentState!.validate()) {
                    controller.signUpUser();
                  }
                }
            ),
            const SizedBox(height: Dimensions.space20),
          ],
        ),
      ),
    );
  }
}

