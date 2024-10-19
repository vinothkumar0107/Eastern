import 'dart:convert';
import 'dart:io';
import 'package:eastern_trust/core/utils/my_images.dart';
import 'package:eastern_trust/data/model/authorized/deposit/deposit_insert_response_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../core/route/route.dart';
import '../../../core/utils/my_strings.dart';
import '../../../views/components/bottom_sheet/custom_bottom_notification.dart';
import '../../../views/components/snackbar/show_custom_snackbar.dart';
import '../../model/authorization/authorization_response_model.dart';
import '../../repo/deposit/deposit_repo.dart';



class DepositPayNowController extends GetxController{

  DepositRepo depositRepo;
  DepositPayNowController({required this.depositRepo});
  bool isLoading = false;
  TextEditingController bankNameController = TextEditingController();
  TextEditingController bankAddressController = TextEditingController();
  TextEditingController msgReferenceController = TextEditingController();
  final FocusNode bankNameFocusNode = FocusNode();
  final FocusNode bankAddressFocusNode = FocusNode();
  final FocusNode msgReferenceFocusNode = FocusNode();
  List<Field>? formList = [];


  void clearData() {

    bankNameController.text = '';
    bankAddressController.text = '';
    msgReferenceController.text = '';
    isLoading = false;
  }

  bool submitLoading=false;
  submitKycData(BuildContext context, String trxNo) async {

    List<String> list = hasError();

    if (list.isNotEmpty) {
      CustomSnackBar.error(errorList: list);
      return;
    }
    submitLoading=true;
    update();
    AuthorizationResponseModel response =await depositRepo.submitDepositData(formList!, trxNo);

    if (!context.mounted) return;

    if(response.status?.toLowerCase()==MyStrings.success.toLowerCase()){
      // CustomSnackBar.success(successList: response.message?.success??[MyStrings.success.tr], );
      showCustomBottomSheetNotification(
        context: context,
        icon: MyImages.successTickImg,
        title: MyStrings.success.tr, successList: response.message?.success??[MyStrings.success.tr],
        buttonText: MyStrings.done.tr,
        onButtonPressed: () {
          // Navigator.pop(context);
          // Get.back(result: true);
          Get.offAndToNamed(RouteHelper.depositsScreen);
        },
      );

    }else{
      CustomSnackBar.error(errorList: response.message?.error??[MyStrings.requestFail.tr]);
    }

    submitLoading=false;
    update();

  }

  List<String> hasError() {
    List<String> errorList = [];
    errorList.clear();
    formList?.forEach((element)  {
      if (element.isRequired == 'required') {
        if(element.type=='checkbox'){
          if (element.cbSelected == null ) {
            errorList.add('${element.name} ${MyStrings.isRequired}');
          }
        }else if(element.type=='file'){
          if (element.imageFile==null) {
            errorList.add('${element.name} ${MyStrings.isRequired}');
          }
        }else{
          if (element.selectedValue == '' || element.selectedValue == null || element.selectedValue == MyStrings.selectOne) {
            errorList.add('${element.name} ${MyStrings.isRequired}');
          }
        }

      }
    });

    return errorList;
  }

  void changeSelectedValue(value, int index) {
    formList?[index].selectedValue = value;
    update();
  }

  void changeSelectedCheckBoxValue(int listIndex, String value) {

    List<String>list=value.split('_');
    int index=int.parse(list[0]);
    bool status=list[1]=='true'?true:false;

    List<String>?selectedValue=formList?[listIndex].cbSelected;

    if(selectedValue!=null){
      String? value=formList?[listIndex].options?[index];
      if(status){
        if(!selectedValue.contains(value)){
          selectedValue.add(value!);
          formList?[listIndex].cbSelected=selectedValue;
          update();
        }
      }else{
        if(selectedValue.contains(value)){
          selectedValue.removeWhere((element) => element==value);
          formList?[listIndex].cbSelected=selectedValue;
          update();
        }
      }
    }else{
      selectedValue=[];
      String? value=formList?[listIndex].options?[index];
      if(status){
        if(!selectedValue.contains(value)){
          selectedValue.add(value!);
          formList?[listIndex].cbSelected=selectedValue;
          update();
        }
      }else{
        if(selectedValue.contains(value)){
          selectedValue.removeWhere((element) => element==value);
          formList?[listIndex].cbSelected=selectedValue;
          update();
        }
      }
    }

  }

  void changeSelectedRadioBtnValue(int listIndex, int selectedIndex) {
    formList?[listIndex].selectedValue =
    formList?[listIndex].options?[selectedIndex];
    update();
  }

  void pickFile(int index) async{

    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'jpeg', 'pdf', 'doc', 'docx']);

    if (result == null) return;

    formList?[index].imageFile = File(result.files.single.path!);
    String fileName = result.files.single.name;
    formList?[index].selectedValue = fileName;
    update();
    return;
  }








}