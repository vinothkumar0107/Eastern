import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/views/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:eastern_trust/core/utils/my_images.dart';
import 'dart:async';

import 'package:get/get_state_manager/src/simple/get_state.dart';

class LauncherScreen extends StatefulWidget {

  const LauncherScreen({Key? key}) : super(key: key);

  @override
  State<LauncherScreen> createState() => _LauncherScreenState();
}

class _LauncherScreenState extends State<LauncherScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SplashScreen()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.appPrimaryColorSecondary2,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [MyColor.appPrimaryColorSecondary2, MyColor.primaryColor2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Center(
          child: Image(
            image: AssetImage(MyImages.launcherImg),
            alignment: Alignment.center,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

