import 'package:flutter/material.dart';
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColor.primaryColor2,
        appBar: const CustomAppBar(title: MyStrings.forgotPassword,),
        body: GetBuilder<ForgetPasswordController>(
          builder: (controller) => SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
              height: MediaQuery.of(context).size.height*.82,
              child:  Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const HeadingTextWidget(header:MyStrings.recoverAccount,body: MyStrings.resetPassMsg,),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    CustomTextField(
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
                    const SizedBox(height: Dimensions.space25),
                    const Spacer(),
                    controller.submitLoading ? const RoundedLoadingBtn() : RoundedButton(
                      press: () {
                        if(formKey.currentState!.validate()){
                          controller.submitForgetPassCode();
                        }
                      },
                      text: MyStrings.submit.tr,
                      textColor: MyColor.colorWhite,
                      color: MyColor.primaryColor,
                    )
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
