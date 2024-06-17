import 'package:eastern_trust/views/components/alert-dialog/exit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eastern_trust/core/helper/shared_preference_helper.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_images.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/data/controller/auth/login_controller.dart';
import 'package:eastern_trust/data/controller/common/theme_controller.dart';
import 'package:eastern_trust/data/controller/menu_/menu_controller.dart' as menu;
import 'package:eastern_trust/data/repo/auth/general_setting_repo.dart';
import 'package:eastern_trust/data/repo/auth/login_repo.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:eastern_trust/views/components/appbar/custom_appbar.dart';
import 'package:eastern_trust/views/components/bottom-nav-bar/bottom_nav_bar.dart';
import 'package:eastern_trust/views/components/divider/custom_divider.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';
import 'package:eastern_trust/views/components/will_pop_widget.dart';

import '../../../../data/controller/localization/localization_controller.dart';
import '../../../core/utils/dimensions.dart';
import 'widget/language_dialog.dart';
import 'widget/menu_card.dart';
import 'widget/menu_row_widget.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GeneralSettingRepo(apiClient: Get.find()));
    final controller = Get.put(menu.MenuController(repo: Get.find()));
    Get.put(LocalizationController(sharedPreferences: Get.find()));
    Get.put(LocalizationController(sharedPreferences: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(builder: (localizationController){
      return  GetBuilder<menu.MenuController>(builder: (menuController)=>WillPopWidget(
        nextRoute: RouteHelper.homeScreen,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: MyColor.getScreenBgColor1(),
            appBar: CustomAppBar(title: MyStrings.menu.tr, isShowBackBtn: false, isShowActionBtn: false, bgColor:  MyColor.getAppbarBgColor()),
            body: SingleChildScrollView(
              padding: Dimensions.screenPaddingHV,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MenuCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        MenuRowWidget(
                          image: MyImages.profile,
                          label: MyStrings.profile,
                          onPressed: () => Get.toNamed(RouteHelper.profileScreen),
                        ),

                        const CustomDivider(space: Dimensions.space15),
                        MenuRowWidget(
                          image: MyImages.changePass,
                          label: MyStrings.changePassword.tr,
                          onPressed: () => Get.toNamed(RouteHelper.changePasswordScreen),
                        ),
                        const CustomDivider(space: Dimensions.space15),
                        MenuRowWidget(
                          image: MyImages.referral,
                          label: MyStrings.referral.tr,
                          onPressed: () => Get.toNamed(RouteHelper.referralScreen),
                        ),


                      ],
                    ),
                  ),
                  const SizedBox(height: Dimensions.space12),

                  MenuCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        MenuRowWidget(
                          image: MyImages.notificationIcon,
                          label: MyStrings.notification.tr,
                          onPressed: () => Get.toNamed(RouteHelper.notificationScreen),
                        ),

                        const CustomDivider(space: Dimensions.space15),

                        Visibility(
                          visible: menuController.isDepositEnable,
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MenuRowWidget(
                              image: MyImages.deposit,
                              label: MyStrings.deposit.tr,
                              onPressed: () => Get.toNamed(RouteHelper.depositsScreen),
                            ),

                            const CustomDivider(space: Dimensions.space15),
                          ],
                        )),

                        Visibility(
                          visible: menuController.isWithdrawEnable,
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MenuRowWidget(
                              image: MyImages.withdrawIcon,
                              label: MyStrings.withdraw.tr,
                              onPressed: () => Get.toNamed(RouteHelper.withdrawScreen),
                            ),

                            const CustomDivider(space: Dimensions.space15),
                          ],
                        )),

                        Visibility(
                            visible: menuController.langSwitchEnable,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MenuRowWidget(
                                  image: MyImages.language,
                                  label: MyStrings.language.tr,
                                  onPressed: (){
                                    final apiClient = Get.put(ApiClient(sharedPreferences: Get.find()));
                                    SharedPreferences pref = apiClient.sharedPreferences;
                                    String language = pref.getString(SharedPreferenceHelper.languageListKey)  ??'';
                                    String countryCode = pref.getString(SharedPreferenceHelper.countryCode)   ??'US';
                                    String languageCode = pref.getString(SharedPreferenceHelper.languageCode) ??'en';
                                    Locale local = Locale(languageCode,countryCode);
                                    showLanguageDialog(language, local, context);
                                    //Get.toNamed(RouteHelper.languageScreen);
                                  },
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(height: Dimensions.space12),
                  MenuCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MenuRowWidget(
                          image: MyImages.termsAndCon,
                          label: MyStrings.terms.tr,
                          onPressed: (){
                            Get.toNamed(RouteHelper.privacyScreen);
                          },
                        ),
                        const CustomDivider(space: Dimensions.space15),
                        MenuRowWidget(
                          image: MyImages.faq,
                          label: MyStrings.faq.tr,
                          onPressed: (){
                            Get.toNamed(RouteHelper.faqScreen);
                          },
                        ),
                        const CustomDivider(space: Dimensions.space15),
<<<<<<< HEAD

                        Visibility(
                            visible: menuController.isDepositEnable,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MenuRowWidget(
                                  image: MyImages.deposit,
                                  label: MyStrings.ticket.tr,
                                  onPressed: () => Get.toNamed(RouteHelper.ticketScreen),
                                ),

                                const CustomDivider(space: Dimensions.space15),
                              ],
                            )),
=======
>>>>>>> origin/ios-main
                        MenuRowWidget(
                          isLoading: menuController.logoutLoading,
                          image: MyImages.signOut,
                          label: MyStrings.signOut.tr,
                          onPressed: (){
                           menuController.logout();
                          },
                        ),
                        const CustomDivider(space: Dimensions.space15),
                        MenuRowWidget(
                          isLoading: menuController.deleteLoading,
                          image: MyImages.delete,
                          label: MyStrings.deleteAccount.tr,
                          onPressed: (){
                            deleteAccountDialog(context,menuController);
                           // menuController.deleteAccount();
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            bottomNavigationBar: const CustomBottomNav(currentIndex: 3),
          ),
        ),
      ));
    });
  }
}
