import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/data/repo/auth/login_repo.dart';

class ForgetPasswordController extends GetxController{
  
  LoginRepo loginRepo;

  ForgetPasswordController({required this.loginRepo});

  bool submitLoading = false;
  TextEditingController emailOrUsernameController = TextEditingController();
  
  void submitForgetPassCode() async {
    String input = emailOrUsernameController.text;

    if(input.isEmpty){
      //CustomSnackBar.error(errorList: [MyStrings.enterYourEmail]);
      return;
    }

    submitLoading = true;
    update();
    String type = input.contains('@') ? 'email' : 'username';
    String responseEmail = await loginRepo.forgetPassword(type, input);
    if(responseEmail.isNotEmpty){
      emailOrUsernameController.text = '';
      Get.toNamed(RouteHelper.verifyPassCodeScreen,arguments: responseEmail);
    }

    submitLoading = false;
    update();

  }

}


