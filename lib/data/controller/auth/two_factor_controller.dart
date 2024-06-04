import 'dart:convert';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/data/model/authorization/authorization_response_model.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/repo/auth/two_factor_repo.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';

class TwoFactorController extends GetxController {

  TwoFactorRepo repo;
  TwoFactorController({required this.repo});
  bool isProfileCompleteEnable = false;

  bool submitLoading=false;
  String currentText='';
  verifyYourSms(String currentText) async {

    if (currentText.isEmpty) {
      CustomSnackBar.error(errorList: [MyStrings.otpFieldEmptyMsg]);
      return;
    }

    submitLoading = true;
    update();

    ResponseModel responseModel = await repo.verify(currentText);

    if (responseModel.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModel.responseJson));

      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {

        CustomSnackBar.success(successList:model.message?.success ?? [MyStrings.requestSuccess]);
        Get.offAndToNamed(isProfileCompleteEnable? RouteHelper.profileCompleteScreen : RouteHelper.homeScreen);

      } else {
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.requestFail]);
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }
    submitLoading = false;
    update();

  }


}