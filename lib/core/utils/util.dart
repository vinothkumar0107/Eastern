

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'my_color.dart';

class MyUtil{

  static changeTheme(){
    /*SystemChrome.setSystemUIOverlayStyle(

        const SystemUiOverlayStyle(

            statusBarColor: MyColor.primaryColor,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: MyColor.navigationBarColor,
            systemNavigationBarIconBrightness: Brightness.dark
        )
    );*/
  }

  static dynamic getShadow(){
    return  [
      BoxShadow(
          blurRadius: 15.0,
          offset: const Offset(0, 25),
          color: Colors.grey.shade500.withOpacity(0.6),
          spreadRadius: -35.0),
    ];
  }

  static dynamic getBottomSheetShadow(){
    return  [
      BoxShadow(
        // color: MyColor.screenBgColor,
        color: Colors.grey.shade400.withOpacity(0.08),
        spreadRadius: 3,
        blurRadius: 4,
        offset: const Offset(0, 3), // changes position of shadow
      ),
    ];
  }

  static dynamic getCardShadow(){
    return  [
      BoxShadow(
        color: Colors.grey.shade400.withOpacity(0.2),
        spreadRadius: 0,
        blurRadius: 5,
        offset: const Offset(0, 3),
      ),
    ];
  }

  static String get _getDeviceType {
  final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  return data.size.width < 550 ? 'phone' : 'tablet';
  }

  static bool get isTablet {
  return _getDeviceType == 'tablet';
  }


}