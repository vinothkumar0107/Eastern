import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/data/controller/account/profile_complete_controller.dart';
import 'package:eastern_trust/data/repo/account/profile_repo.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:eastern_trust/views/components/appbar/custom_appbar.dart';
import 'package:eastern_trust/views/components/buttons/rounded_button.dart';
import 'package:eastern_trust/views/components/buttons/rounded_loading_button.dart';
import 'package:eastern_trust/views/components/text-field/custom_text_field.dart';
import 'package:eastern_trust/views/components/will_pop_widget.dart';
import 'package:eastern_trust/views/screens/auth/profile_complete/widget/image_widget.dart';

import '../../../../core/utils/style.dart';
import '../../../components/alert-dialog/exit_dialog.dart';
import '../../../components/appbar/appbar_specific_device.dart';


class ProfileCompleteScreen extends StatefulWidget {
  const ProfileCompleteScreen({Key? key}) : super(key: key);

  @override
  State<ProfileCompleteScreen> createState() => _ProfileCompleteScreenState();
}

class _ProfileCompleteScreenState extends State<ProfileCompleteScreen> {

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ProfileRepo(apiClient: Get.find(), ));
    Get.put(ProfileCompleteController(profileRepo: Get.find()));
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }
  
  final formKey = GlobalKey<FormState>();

  @override
  Widget build2(BuildContext context) {

    return WillPopWidget(
      nextRoute: '',
      child: SafeArea(
          child: Scaffold(
            backgroundColor: MyColor.primaryColor2,
            appBar: CustomAppBar(
              title: MyStrings.profileComplete.tr,
              isShowBackBtn: true,
              fromAuth: false,
              isProfileCompleted: true,
            ),

            body: GetBuilder<ProfileCompleteController>(
              builder: (controller) => SingleChildScrollView(
                padding: Dimensions.screenPaddingHV,
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: Dimensions.space12,),
                      CustomImageWidget(imagePath: controller.imageFile?.path ?? '', onClicked: (){}),
                      const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
                      CustomTextField(
                        labelText: MyStrings.firstName.tr,
                        hintText: MyStrings.enterYourFirstName.tr,
                        textInputType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        focusNode: controller.firstNameFocusNode,
                        controller: controller.firstNameController,
                        nextFocus: controller.lastNameFocusNode,
                        onChanged: (value){
                          return;
                        },
                        validator: (value){
                          if(value!=null && value.toString().isEmpty){
                            return MyStrings.enterYourFirstName.tr;
                          } else{
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
                      CustomTextField(
                        labelText: MyStrings.lastName.tr,
                        hintText: MyStrings.enterYourLastName,
                        textInputType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        focusNode: controller.lastNameFocusNode,
                        controller: controller.lastNameController,
                        nextFocus: controller.addressFocusNode,
                        onChanged: (value){
                          return;
                        },
                        validator: (value){
                          if(value!=null && value.toString().isEmpty){
                            return MyStrings.enterYourLastName.tr;
                          } else{
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
                      CustomTextField(
                        
                        labelText: MyStrings.address,
                        hintText: MyStrings.enterYourAddress,
                        textInputType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        focusNode: controller.addressFocusNode,
                        controller: controller.addressController,
                        nextFocus: controller.stateFocusNode,
                        onChanged: (value){
                          return;
                        },
                      ),
                      const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
                      CustomTextField(
                        
                        labelText: MyStrings.state,
                        hintText: MyStrings.enterYourState,
                        textInputType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        focusNode: controller.stateFocusNode,
                        controller: controller.stateController,
                        nextFocus: controller.cityFocusNode,
                        onChanged: (value){
                          return ;
                        },
                      ),
                      const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
                      CustomTextField(
                        
                        labelText: MyStrings.city.tr,
                        hintText: MyStrings.enterYourCity,
                        textInputType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        focusNode: controller.cityFocusNode,
                        controller: controller.cityController,
                        nextFocus: controller.zipCodeFocusNode,
                        onChanged: (value){
                          return ;
                        },
                      ),
                      const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
                      CustomTextField(
                        
                        labelText: MyStrings.zipCode.tr,
                        hintText: MyStrings.enterYourCountryZipCode,
                        textInputType: TextInputType.text,
                        inputAction: TextInputAction.done,
                        focusNode: controller.zipCodeFocusNode,
                        controller: controller.zipCodeController,
                        onChanged: (value){
                          return;
                        },
                      ),
                      const SizedBox(height: Dimensions.space35),
                      controller.submitLoading ? const RoundedLoadingBtn() : RoundedButton(
                        text: MyStrings.updateProfile.tr,
                        textColor: MyColor.colorWhite,
                        press: (){
                          if(formKey.currentState!.validate()){
                            controller.updateProfile();
                          }
                        },
                        color: MyColor.getPrimaryColor(),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileCompleteController>(
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
            backgroundColor: MyColor.appPrimaryColorSecondary2,
            body: Stack(
              children: [
                const GradientView(gradientViewHeight: 3.5),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 1.0),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          // Navigator.of(context).pop();
                          showExitDialog(Get.context!);
                        },
                      ),
                      Expanded(
                        child: Text(
                            MyStrings.profileComplete.tr,
                            textAlign: TextAlign.left,
                            style: interSemiBoldOverLarge.copyWith(color: MyColor.colorWhite,decorationColor:MyColor.primaryColor)
                        ),
                      ),
                      // To keep the title centered, you can add an empty `SizedBox`
                      const SizedBox(width: 48.0),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(15.0, 70.0, 15.0, 0.0),
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
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: Dimensions.space12,),
                                      CustomImageWidget(imagePath: controller.imageFile?.path ?? '', onClicked: (){}),
                                      const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
                                      CustomTextField(
                                        needLabel: false,
                                        needOutlineBorder: true,
                                        labelText: MyStrings.firstName.tr,
                                        hintText: MyStrings.enterYourFirstName.tr,
                                        textInputType: TextInputType.text,
                                        inputAction: TextInputAction.next,
                                        focusNode: controller.firstNameFocusNode,
                                        controller: controller.firstNameController,
                                        nextFocus: controller.lastNameFocusNode,
                                        onChanged: (value){
                                          return;
                                        },
                                        validator: (value){
                                          if(value!=null && value.toString().isEmpty){
                                            return MyStrings.enterYourFirstName.tr;
                                          } else{
                                            return null;
                                          }
                                        },
                                      ),
                                      const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
                                      CustomTextField(
                                        needLabel: false,
                                        needOutlineBorder: true,
                                        labelText: MyStrings.lastName.tr,
                                        hintText: MyStrings.enterYourLastName,
                                        textInputType: TextInputType.text,
                                        inputAction: TextInputAction.next,
                                        focusNode: controller.lastNameFocusNode,
                                        controller: controller.lastNameController,
                                        nextFocus: controller.addressFocusNode,
                                        onChanged: (value){
                                          return;
                                        },
                                        validator: (value){
                                          if(value!=null && value.toString().isEmpty){
                                            return MyStrings.enterYourLastName.tr;
                                          } else{
                                            return null;
                                          }
                                        },
                                      ),
                                      const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
                                      CustomTextField(
                                        needLabel: false,
                                        needOutlineBorder: true,
                                        labelText: MyStrings.address,
                                        hintText: MyStrings.enterYourAddress,
                                        textInputType: TextInputType.text,
                                        inputAction: TextInputAction.next,
                                        focusNode: controller.addressFocusNode,
                                        controller: controller.addressController,
                                        nextFocus: controller.stateFocusNode,
                                        onChanged: (value){
                                          return;
                                        },
                                      ),
                                      const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
                                      CustomTextField(
                                        needLabel: false,
                                        needOutlineBorder: true,
                                        labelText: MyStrings.state,
                                        hintText: MyStrings.enterYourState,
                                        textInputType: TextInputType.text,
                                        inputAction: TextInputAction.next,
                                        focusNode: controller.stateFocusNode,
                                        controller: controller.stateController,
                                        nextFocus: controller.cityFocusNode,
                                        onChanged: (value){
                                          return ;
                                        },
                                      ),
                                      const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
                                      CustomTextField(
                                        needLabel: false,
                                        needOutlineBorder: true,
                                        labelText: MyStrings.city.tr,
                                        hintText: MyStrings.enterYourCity,
                                        textInputType: TextInputType.text,
                                        inputAction: TextInputAction.next,
                                        focusNode: controller.cityFocusNode,
                                        controller: controller.cityController,
                                        nextFocus: controller.zipCodeFocusNode,
                                        onChanged: (value){
                                          return ;
                                        },
                                      ),
                                      const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
                                      CustomTextField(
                                        needLabel: false,
                                        needOutlineBorder: true,
                                        labelText: MyStrings.zipCode.tr,
                                        hintText: MyStrings.enterYourCountryZipCode,
                                        textInputType: TextInputType.text,
                                        inputAction: TextInputAction.done,
                                        focusNode: controller.zipCodeFocusNode,
                                        controller: controller.zipCodeController,
                                        onChanged: (value){
                                          return;
                                        },
                                      ),
                                      const SizedBox(height: Dimensions.space35),
                                      controller.submitLoading ? const RoundedLoadingBtn() : RoundedButton(
                                        text: MyStrings.updateProfile.tr,
                                        textColor: MyColor.colorWhite,
                                        press: (){
                                          if(formKey.currentState!.validate()){
                                            controller.updateProfile();
                                          }
                                        },
                                        color: MyColor.appPrimaryColorSecondary2,
                                      )
                                    ],
                                  ),
                                ),
                            ),
                          ),
                          const SizedBox(height: Dimensions.space20), // Add spacing if needed
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
