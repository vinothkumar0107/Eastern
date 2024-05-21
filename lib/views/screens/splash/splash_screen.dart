import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/theme/theme_util.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_images.dart';
import 'package:eastern_trust/data/controller/localization/localization_controller.dart';
import 'package:eastern_trust/data/controller/splash/splash_controller.dart';
import 'package:eastern_trust/data/repo/auth/general_setting_repo.dart';
import 'package:eastern_trust/data/services/api_service.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {

    ThemeUtil.makeSplashTheme();

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GeneralSettingRepo(apiClient: Get.find()));
    Get.put(LocalizationController(sharedPreferences: Get.find()));
    final controller = Get.put(SplashController(repo: Get.find(), localizationController: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.gotoNextPage();
    });
  }

  @override
  void dispose() {
    ThemeUtil.allScreenTheme();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(builder: (controller) => Scaffold(
      backgroundColor: controller.noInternet?MyColor.colorWhite:MyColor.colorWhite,
      body: Center(
        child: Image.asset(MyImages.splashImg, height: Dimensions.appLogoHeight, width: Dimensions.appLogoWidth),
      ),
    ));
  }
}
