
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eastern_trust/views/components/will_pop_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/route/route.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../../core/utils/style.dart';
import '../../../../data/controller/auth/two_factor_controller.dart';
import '../../../../data/controller/tickets/reply_ticket_controller.dart';
import '../../../../data/repo/auth/two_factor_repo.dart';
import '../../../../data/repo/home/home_repo.dart';
import '../../../../data/services/api_service.dart';
import '../../../components/appbar/custom_appbar.dart';
import '../../../components/buttons/rounded_button.dart';
import '../../../components/buttons/rounded_loading_button.dart';
import '../../../components/custom_loader.dart';
import 'dart:io' as io;

import '../../../components/snackbar/show_custom_snackbar.dart';
import '../../../components/text-field/custom_text_field.dart';




class Setup2FAScreen extends StatefulWidget {
  const Setup2FAScreen({super.key});
  @override
  State<Setup2FAScreen> createState() => _Setup2FAScreenState();
}

class _Setup2FAScreenState extends State<Setup2FAScreen> {
  final String _iosUrl = 'https://apps.apple.com/us/app/google-authenticator/id388497605';
  final String _androidUrl = 'https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2';


  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(TwoFactorRepo(apiClient: Get.find()));
    Get.put(HomeRepo(apiClient: Get.find()));
    final controller = Get.put(TwoFactorController(repo: Get.find(), homeRepo: Get.find()),);
    controller.getTwoFactor();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    });
  }
  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<TwoFactorController>(
        builder: (controller) =>  WillPopWidget(child: SafeArea(
          child: Scaffold(
            backgroundColor: MyColor.getScreenBgColor2(),
            // appBar: CustomAppBar(title: MyStrings.twoFASecurity.tr),
            appBar: AppBar(
              title: Text(MyStrings.twoFASecurity.tr,
                  style: interRegularLarge.copyWith(color: MyColor.colorWhite)),
              backgroundColor: MyColor.primaryColor,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Get.offAndToNamed(RouteHelper.menuScreen);
                },
                icon: const Icon(Icons.arrow_back,
                    color: MyColor.colorWhite, size: 20),
              ),
            ),
            body:  controller.isTwoFactorEnabled.toString() == "1" ? SingleChildScrollView(
              padding: Dimensions.screenPaddingHV1,
              child: Center(
                child: Column(
                  children: [
                    Text(
                      MyStrings.disableTwoFactorSecurity,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: interRegularDefault.copyWith(color:MyColor.colorBlack,fontSize: Dimensions.fontHeader1),
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                        hintText:
                        " ",
                        needLabel: true,
                        needOutlineBorder: true,
                        controller: controller.authenticationCode,
                        textInputType: TextInputType.number,
                        labelText:
                        MyStrings.googleAuthOtp,
                        isRequired: true,
                        disableColor: MyColor.getGreyText(),
                        onChanged: (value) {
                          // controller.changeSelectedValue(value, index);
                        }
                    ),
                    const SizedBox(height: 25),
                    controller.submitLoading?const RoundedLoadingBtn():
                    RoundedButton(
                      text: MyStrings.submit,
                      textColor: MyColor.textColor,
                      width: double.infinity,
                      press: () {
                        controller.disableGoogleAuthenticate();
                      },
                    ),
                  ],
                ),
              ),
            ) : controller.isLoading ? const CustomLoader() :
            SingleChildScrollView(
              padding: Dimensions.screenPaddingHV1,
              child: Center(
                child: Column(
                  children: [
                    Text(
                      MyStrings.addYourAccount,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: interRegularDefault.copyWith(color:MyColor.colorBlack,fontSize: Dimensions.fontHeader1),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      MyStrings.useQRCode,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: interRegularSmall.copyWith(color:MyColor.colorBlack,fontSize: Dimensions.fontDefault),
                    ),
                    const SizedBox(height: 20), // Add some space before the QR code
                    // Image.network(
                    //   '${controller.authenticatorModel?.data.qrCodeUrl}',
                    //   height: 150, // Adjust height as needed
                    //   width: 150, // Adjust width as needed
                    //   fit: BoxFit.contain, // Adjust fit as needed
                    // ),
                    CachedNetworkImage(
                      imageUrl: '${controller.authenticatorModel?.data.qrCodeUrl}',
                      height: 150, // Adjust height as needed
                      width: 150, // Adjust width as needed
                      fit: BoxFit.contain, // Adjust fit as needed
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          Text(
                            MyStrings.setupKey,
                            textAlign: TextAlign.left,
                            style: interRegularDefault.copyWith(
                              color: MyColor.colorBlack,
                              fontSize: Dimensions.fontLarge,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 40,
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: MyColor.colorBlack),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            "${controller.authenticatorModel?.data.secret.toString()}",
                            style: interRegularSmall.copyWith(
                              color: MyColor.colorBlack,
                              fontSize: Dimensions.fontDefault,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: IconButton(
                            icon: Icon(Icons.copy, color: MyColor.colorBlack),
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: "${controller.authenticatorModel?.data.secret.toString()}"));
                              CustomSnackBar.success(successList: [MyStrings.setupKeyCopiedSuccessfully]);
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Icon(Icons.info, color: MyColor.colorGrey2),
                        const SizedBox(width: 2), // Add some space between the icon and the text
                        Text(
                          MyStrings.help,
                          style: interRegularSmall.copyWith(
                            color: MyColor.colorBlack,
                            fontSize: Dimensions.fontDefault,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        text: MyStrings.googleAuthenticateHint,
                        style: interRegularSmall.copyWith(
                          color: MyColor.colorBlack,
                          fontSize: Dimensions.fontDefault,
                        ),
                        children: [
                          TextSpan(
                            text: MyStrings.download,
                            style: interRegularDefault.copyWith(
                              color: MyColor.primaryColor,
                              fontSize: Dimensions.fontDefault,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                String url =  io.Platform.isIOS ? _iosUrl : _androidUrl;
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      MyStrings.enableTwoFactorSecurity,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: interRegularDefault.copyWith(color:MyColor.colorBlack,fontSize: Dimensions.fontHeader1),
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                        hintText:
                        " ",
                        needLabel: true,
                        needOutlineBorder: true,
                        controller: controller.authenticationCode,
                        textInputType: TextInputType.number,
                        labelText:
                        MyStrings.googleAuthOtp,
                        isRequired: true,
                        disableColor: MyColor.getGreyText(),
                        onChanged: (value) {
                          // controller.changeSelectedValue(value, index);
                        }
                    ),
                    const SizedBox(height: 25),
                    controller.submitLoading?const RoundedLoadingBtn():
                    RoundedButton(
                      text: MyStrings.submit,
                      textColor: MyColor.textColor,
                      width: double.infinity,
                      press: () {
                        controller.enableGoogleAuthenticate();
                      },
                    ),
                  ],
                ),
              ),

            ),
          ),

        ),),
    );
  }
}

