import 'package:eastern_trust/views/components/appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/theme/theme_util.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_images.dart';
import 'package:eastern_trust/data/controller/localization/localization_controller.dart';
import 'package:eastern_trust/data/controller/splash/splash_controller.dart';
import 'package:eastern_trust/data/repo/auth/general_setting_repo.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'dart:async';
import 'package:eastern_trust/core/utils/my_strings.dart';


class SplashScreen extends StatefulWidget {

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progress = 0.0;
  Timer? _timer;
  @override
  void initState() {

    ThemeUtil.makeSplashTheme();

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GeneralSettingRepo(apiClient: Get.find()));
    Get.put(LocalizationController(sharedPreferences: Get.find()));
    final controller = Get.put(SplashController(repo: Get.find(), localizationController: Get.find()));

    super.initState();
    _startLoading();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Timer(
         const Duration(milliseconds: 40),
              () => controller.gotoNextPage());
    });
  }
  void _startLoading() {
    _timer = Timer.periodic(const Duration(milliseconds: 50), (Timer timer) {
      setState(() {
        if (_progress < 1.0) {
          _progress += 0.02;
        } else {
          _timer?.cancel();
        }
      });
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
      backgroundColor: controller.noInternet?MyColor.primaryColor2:MyColor.primaryColor2,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [MyColor.colorWhite, MyColor.colorWhite],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Image.asset(
            MyImages.splashAnimationGif,
            height: MediaQuery.sizeOf(context).width,
            width: MediaQuery.sizeOf(context).width,
          ),
          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     Image.asset(MyImages.appIcon, width: 100, height: 140, fit: BoxFit.fill),
          //     const SizedBox(height: 50),
          //     Container(
          //       width: 200, // Set the width of the progress bar
          //       height: 10, // Set the height of the progress bar
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(5), // Set the corner radius
          //         boxShadow: [
          //           BoxShadow(
          //             color: MyColor.primaryColor2.withOpacity(0.5), // Set the shadow color
          //             spreadRadius: 2, // Set the spread radius
          //             blurRadius: 4, // Set the blur radius
          //             offset: const Offset(0, 2), // Set the shadow offset
          //           ),
          //         ],
          //       ),
          //       child: ClipRRect(
          //         borderRadius: BorderRadius.circular(5),
          //         // Set the corner radius
          //         child: LinearProgressIndicator(
          //           value: _progress,
          //           minHeight: 10,
          //           backgroundColor: MyColor.primaryColor2,
          //           valueColor: const AlwaysStoppedAnimation<Color>(MyColor.primaryColor),
          //         ),
          //       ),
          //     ),
          //     const SizedBox(height: 20),
          //     const Text(MyStrings.loadingPleaseWait, style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.normal)),
          //     const SizedBox(height: 200),
          //
          //   ],
          // ),
        ),
      ),
    ));
  }
}

class GifImage {
}

