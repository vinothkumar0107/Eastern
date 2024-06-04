import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_images.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/style.dart';
import 'package:eastern_trust/data/controller/account/profile_controller.dart';
import 'package:eastern_trust/data/repo/account/profile_repo.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:eastern_trust/views/components/appbar/custom_appbar.dart';
import 'package:eastern_trust/views/components/circle_widget/circle_button_with_icon.dart';
import 'package:eastern_trust/views/components/custom_loader.dart';
import 'package:eastern_trust/views/components/divider/custom_divider.dart';
import 'package:eastern_trust/views/components/circle_widget/circle_image_button.dart';

import 'widget/user_info_field.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ProfileRepo(apiClient: Get.find(), ));
    Get.put(ProfileController(profileRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ProfileController>().loadProfileInfo();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColor.getScreenBgColor1(),
        appBar: CustomAppBar(
          isShowBackBtn: true,
          title: MyStrings.profile.tr,
          bgColor: MyColor.getAppbarBgColor(),
        ),
        body: GetBuilder<ProfileController>(
          builder: (controller) => controller.isLoading ? const CustomLoader() : SingleChildScrollView(
            padding: Dimensions.screenPaddingHV,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.space20, horizontal: Dimensions.space15),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: MyColor.getCardBg(),
                      borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                          CircleImageWidget(
                          height:60,
                          width:60,
                          isProfile:true,
                          isAsset: false,
                          imagePath: controller.imageUrl,
                          press: (){
                          },),
                            const SizedBox(width: Dimensions.space15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(controller.model.data?.user?.username ?? "", style: interSemiBoldLarge.copyWith(color: MyColor.getTextColor(), fontWeight: FontWeight.w600)),
                                  const SizedBox(height: Dimensions.space5),
                                  Text(controller.model.data?.user?.address?.country ?? "",overflow: TextOverflow.ellipsis, style: interRegularSmall.copyWith(color: MyColor.getGreyText(),fontWeight: FontWeight.w600)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () => Get.toNamed(RouteHelper.editProfileScreen),
                        child: Container(
                          margin: const EdgeInsetsDirectional.only(start: 10),
                          height: 30,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: MyColor.primaryColor,
                              borderRadius: BorderRadius.circular(Dimensions.defaultRadius)
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.edit,color: MyColor.colorWhite,size: 15,),
                              const SizedBox(width: 5,),
                              Text(MyStrings.editProfile.tr, textAlign: TextAlign.center, style: interRegularSmall.copyWith(color: MyColor.colorWhite)),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: Dimensions.cardToCardSpace),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: Dimensions.screenPaddingHV,
                  decoration: BoxDecoration(
                      color: MyColor.getCardBg(),
                      borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UserInfoField(
                        icon: MyImages.bankPNG,
                        label: MyStrings.accountNumber,
                        value: controller.model.data?.user?.accountNumber??'',
                      ),
                      const CustomDivider(space: Dimensions.space20),
                      UserInfoField(
                        icon: MyImages.profile,
                        label: MyStrings.username.tr,
                        value: controller.model.data?.user?.username ?? "",
                      ),
                      const CustomDivider(space: Dimensions.space20),
                      UserInfoField(
                        icon: MyImages.emailIcon,
                        label: MyStrings.email.tr,
                        value: controller.model.data?.user?.email ?? "",
                      ),
                      const CustomDivider(space: Dimensions.space20),
                      UserInfoField(
                        icon: MyImages.mobileIcon,
                        label: MyStrings.phoneNo.tr,
                        value: controller.model.data?.user?.mobile ?? "",
                      ),
                      const CustomDivider(space: Dimensions.space20),
                      UserInfoField(
                        icon: MyImages.countryIcon,
                        label: MyStrings.country.tr,
                        value: controller.model.data?.user?.address?.country ?? "",
                      ),
                      const CustomDivider(space: Dimensions.space20),
                      UserInfoField(
                        icon: MyImages.stateIcon,
                        label: MyStrings.state.tr,
                        value: controller.model.data?.user?.address?.state ?? "",
                      ),
                      const CustomDivider(space: Dimensions.space20),
                      UserInfoField(
                        icon: MyImages.cityIcon,
                        label: MyStrings.city.tr,
                        value: controller.model.data?.user?.address?.city ?? "",
                      ),
                      const CustomDivider(space: Dimensions.space20),
                      UserInfoField(
                        icon: MyImages.zipCodeIcon,
                        label: MyStrings.zipCode.tr,
                        value: controller.model.data?.user?.address?.zip ?? "",
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

