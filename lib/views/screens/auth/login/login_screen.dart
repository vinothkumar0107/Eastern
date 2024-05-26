import 'package:flutter/material.dart';
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
          child: SafeArea(
            child: Scaffold(
              backgroundColor: MyColor.primaryColor2,
              body: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 50, horizontal: Dimensions.screenPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: ColorFiltered(colorFilter: ColorFilter.mode(MyColor.transparentColor, BlendMode.screen),
                      child: Image.asset(MyImages.appLogo,width: 200,height: 90,
                        ),

                      ),
                    ),
                     /* Text(MyStrings.loginTitle.tr, style: interRegularDefault.copyWith(fontSize:Dimensions.fontHeader2,fontWeight: FontWeight.w500)),
                      const SizedBox(height: 15),
                      Padding(
                        padding:EdgeInsetsDirectional.only(end: MediaQuery.of(context).size.width*.4),
                        child: Text(MyStrings.loginSologan.tr, textAlign: TextAlign.left,style: interRegularDefault.copyWith(color: MyColor.getGreyText()),)
                      ),*/
                      const SizedBox(height: Dimensions.space30),
                      const LoginForm()
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
