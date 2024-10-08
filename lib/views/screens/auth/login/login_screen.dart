import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_images.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/data/controller/auth/login_controller.dart';
import 'package:eastern_trust/data/repo/auth/login_repo.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:eastern_trust/views/components/will_pop_widget.dart';
import 'package:eastern_trust/views/screens/auth/login/widget/login_form.dart';

import 'package:eastern_trust/views/screens/auth/login/widget/bottom_section.dart';

import '../../../components/appbar/appbar_specific_device.dart';
import '../../../components/appbar/custom_appbar.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  bool b = false;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient: Get.find()));
    final controller = Get.put(LoginController(loginRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.remember = false;
    });
  }
  @override
  void dispose() {
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
    return GetBuilder<LoginController>(
      builder: (controller) => WillPopWidget(
        nextRoute: '',
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Scaffold(
            appBar: AppBarSpecificScreen.buildAppBar(),
            backgroundColor: MyColor.getScreenBgColor2(),
            body: Stack(
              children: [
                const GradientView(gradientViewHeight: 3.5),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 0.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Card(
                            color: MyColor.colorWhite,
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Center(
                                    child: SizedBox(
                                      width: 200,
                                      height: 100, // Adjust height as needed
                                      child: Image.asset(
                                        MyImages.appLogo,
                                        fit: BoxFit.fitWidth, // Image covers the entire container
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: Dimensions.space15),
                                  const LoginForm(), // Your form goes here
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10), // Add spacing if needed
                          const BottomSection(), // Your bottom section goes here
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



}





