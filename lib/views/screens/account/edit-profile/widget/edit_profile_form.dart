import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/dimensions.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/data/controller/account/profile_controller.dart';
import 'package:eastern_trust/views/components/buttons/rounded_button.dart';
import 'package:eastern_trust/views/components/buttons/rounded_loading_button.dart';
import 'package:eastern_trust/views/components/text-field/custom_text_field.dart';
import 'profile_image.dart';

class EditProfileForm extends StatefulWidget {

  const EditProfileForm({Key? key,}) : super(key: key);

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) => Form(
        child: Column(
          children: [
            const SizedBox(height: 15,),
            ProfileWidget(
                isEdit:  true,
                imagePath:  controller.imageUrl,
                onClicked: () async {

                }
            ),
            const SizedBox(height: 15,),
            CustomTextField(
                labelText: MyStrings.firstName.tr,
                onChanged: (value){
                  return;
                },
                focusNode: controller.firstNameFocusNode,
                controller: controller.firstNameController
            ),
            const SizedBox(height: Dimensions.textFieldToTextFieldSpace),

            CustomTextField(
                labelText: MyStrings.lastName.tr,
                onChanged: (value){
                  return;
                },
                focusNode: controller.lastNameFocusNode,
                controller: controller.lastNameController
            ),
            const SizedBox(height: Dimensions.textFieldToTextFieldSpace),

            CustomTextField(
                labelText: MyStrings.address.tr,
                onChanged: (value){

                  return;
                },
                focusNode: controller.addressFocusNode,
                controller: controller.addressController
            ),
            const SizedBox(height: Dimensions.textFieldToTextFieldSpace),

            CustomTextField(
                labelText: MyStrings.state.tr,
                onChanged: (value){
                  return ;
                },
                focusNode: controller.stateFocusNode,
                controller: controller.stateController
            ),
            const SizedBox(height: Dimensions.textFieldToTextFieldSpace),

            CustomTextField(
                labelText: MyStrings.zipCode.tr,
                onChanged: (value){
                  return;
                },
                focusNode: controller.zipCodeFocusNode,
                controller: controller.zipCodeController
            ),
            const SizedBox(height: Dimensions.textFieldToTextFieldSpace),

            CustomTextField(
                labelText: MyStrings.city.tr,
                onChanged: (value){
                  return ;
                },
                focusNode: controller.cityFocusNode,
                controller: controller.cityController,
            ),
            const SizedBox(height: Dimensions.space35),
            controller.isSubmitLoading?
            const RoundedLoadingBtn():
            RoundedButton(
              text: MyStrings.updateProfile.tr,
              textColor: MyColor.getButtonTextColor(),
              color: MyColor.getButtonColor(),
              press: (){
                controller.updateProfile();
              }
            )
          ],
        ),
      ),
    );
  }
}
