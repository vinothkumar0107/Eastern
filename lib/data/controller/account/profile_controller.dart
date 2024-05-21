import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/shared_preference_helper.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/url.dart';
import 'package:eastern_trust/data/model/profile/profile_response_model.dart';
import 'package:eastern_trust/data/model/user_post_model/user_post_model.dart';
import 'package:eastern_trust/data/repo/account/profile_repo.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';



class ProfileController extends GetxController {

  ProfileRepo profileRepo;
  ProfileResponseModel model=ProfileResponseModel();


  ProfileController({required this.profileRepo});

  String imageUrl='';

  bool isLoading = false;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();


  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode mobileNoFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode stateFocusNode = FocusNode();
  FocusNode zipCodeFocusNode = FocusNode();
  FocusNode cityFocusNode = FocusNode();
  FocusNode countryFocusNode = FocusNode();

  File? imageFile;




  loadProfileInfo() async {
    isLoading = true;
    update();
    model= await profileRepo.loadProfileInfo();
    if(model.data!=null && model.status?.toLowerCase()==MyStrings.success.toLowerCase()){
      loadData(model);
    }else{
      isLoading=false;
      update();
    }

  }


  bool isSubmitLoading = false;
  updateProfile()async{

    isSubmitLoading = true;
    update();

    String firstName  =  firstNameController.text;
    String lastName   =  lastNameController.text.toString();
    String address    =  addressController.text.toString();
    String city       =  cityController.text.toString();
    String zip        =  zipCodeController.text.toString();
    String state      =  stateController.text.toString();
    User?  user       =  model.data?.user;

    if(firstName.isNotEmpty && lastName.isNotEmpty){
      isLoading=true;
      update();

      UserPostModel model=UserPostModel(
          firstname: firstName, lastName: lastName, mobile: user?.mobile??'', email: user?.email??'',
          username: user?.username??'', countryCode: user?.countryCode??'', country: user?.address?.country??'', mobileCode: '880',
          image:imageFile, address: address, state: state,
          zip: zip, city: city);

      bool b= await profileRepo.updateProfile(model,true);

      if(b){
        await loadProfileInfo();
      }
    }else{
      if(firstName.isEmpty){
        CustomSnackBar.error(errorList: [ MyStrings.kFirstNameNullError.tr],);
      } if(lastName.isEmpty){
        CustomSnackBar.error(errorList: [MyStrings.kLastNameNullError.tr],);
      }
    }

    isSubmitLoading = false;
    update();

  }

  void loadData(ProfileResponseModel? model) {

    firstNameController.text=model?.data?.user?.firstname??'';
    profileRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userNameKey, '${model?.data?.user?.username}');
    lastNameController.text = model?.data?.user?.lastname??'';
    emailController.text = model?.data?.user?.email??'';
    mobileNoController.text = model?.data?.user?.mobile??'';
    addressController.text =model?.data?.user?.address?.address??'';
    stateController.text = model?.data?.user?.address?.state??'';
    zipCodeController.text = model?.data?.user?.address?.zip??'';
    cityController.text = model?.data?.user?.address?.city??'';
    imageUrl=model?.data?.user?.image==null?'':'${model?.data?.user?.image}';
    if(imageUrl.isNotEmpty&& imageUrl !='null'){
      imageUrl = '${UrlContainer.domainUrl}assets/images/user/profile/$imageUrl';
    }
    isLoading=false;

    update();
  }
}
