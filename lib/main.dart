import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/firebase_options.dart';
import 'push_notification_service.dart';
import 'core/helper/shared_preference_helper.dart';
import 'core/route/route.dart';
import 'core/theme/light.dart';
import 'core/di_service/di_service.dart' as di_service;


Future<void> _messageHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final sharedPreferences=await SharedPreferences.getInstance();
  Get.lazyPut(()=>sharedPreferences);
  sharedPreferences.setBool(SharedPreferenceHelper.hasNewNotificationKey, true);
}

void main()async{

  WidgetsFlutterBinding.ensureInitialized();
  await di_service.init();
  FirebaseMessaging.onBackgroundMessage(
      _messageHandler
  );
  await PushNotificationService().setupInteractedMessage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: MyStrings.appName,
      initialRoute: RouteHelper.splashScreen,
      defaultTransition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 200),
      getPages: RouteHelper.routes,
      navigatorKey: Get.key,
      theme: light ,
      debugShowCheckedModeBanner: false,
    );
  }
}
