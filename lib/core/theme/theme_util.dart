
import 'package:flutter/services.dart';

import '../utils/my_color.dart';

class ThemeUtil{
   static void makeSplashTheme(){
     SystemChrome.setSystemUIOverlayStyle(
         const SystemUiOverlayStyle(
             statusBarColor: MyColor.primaryColor,
             statusBarIconBrightness: Brightness.light,
             systemNavigationBarColor: MyColor.primaryColor,
             systemNavigationBarIconBrightness: Brightness.light
         )
     );
   }
   static void allScreenTheme(){
     SystemChrome.setSystemUIOverlayStyle(
       const SystemUiOverlayStyle(
         statusBarColor: MyColor.primaryColor,
         statusBarIconBrightness: Brightness.light,
         systemNavigationBarColor: MyColor.containerBgColor,
         systemNavigationBarIconBrightness: Brightness.dark
       )
     );
   }
}