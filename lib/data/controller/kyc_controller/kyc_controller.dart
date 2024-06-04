import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/data/model/authorization/authorization_response_model.dart';
import 'package:eastern_trust/data/model/kyc/kyc_response_model.dart';
import 'package:eastern_trust/data/repo/kyc/kyc_repo.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';


class KycController extends GetxController {

  KycRepo repo;
  KycController({required this.repo});
  File? imageFile;


  bool isLoading = true;
  List<FormModel> formList = [];
  String selectOne = MyStrings.selectOne;


  KycResponseModel model = KycResponseModel();
  bool isNoDataFound=false;
  bool isAlreadyVerified=false;
  bool isAlreadyPending=false;

  beforeInitLoadKycData() async {
    setStatusTrue();
    try{
      model=await repo.getKycData() ;
      if(model.data!=null && model.status?.toLowerCase()== MyStrings.success.toLowerCase()){
        List<FormModel>? tList = model.data?.form?.list;
        if (tList != null && tList.isNotEmpty) {
          formList.clear();
          for (var element in tList) {
            if (element.type == 'select') {
              bool? isEmpty = element.options?.isEmpty;
              bool empty = isEmpty ?? true;
              if (element.options != null && empty != true) {
                element.options?.insert(0, selectOne);
                element.selectedValue = element.options?.first;
                formList.add(element);
              }
            } else {
              formList.add(element);
            }
          }
        }

        isNoDataFound=false;
      }else{
        if(model.remark?.toLowerCase() == 'already_verified'){
          isAlreadyVerified=true;
        }else if(model.remark?.toLowerCase() == 'under_review'){
          isAlreadyPending=true;
        }
        else{
          isNoDataFound=true;
        }
      }
    }catch(e){
      setStatusFalse();
    }
    setStatusFalse();
  }

  setStatusTrue() {
    isLoading = true;
    update();
  }

  setStatusFalse() {
    isLoading = false;
    update();
  }


  bool submitLoading=false;
  submitKycData() async {

    List<String> list = hasError();


    if (list.isNotEmpty) {
      CustomSnackBar.error(errorList: list);
      return;
    }
    submitLoading=true;
    update();

    AuthorizationResponseModel response =await repo.submitKycData(formList);

    if(response.status?.toLowerCase()==MyStrings.success.toLowerCase()){
      isAlreadyPending = true;
      CustomSnackBar.success(successList: response.message?.success??[MyStrings.success.tr], );
    }else{
      CustomSnackBar.error(errorList: response.message?.error??[MyStrings.requestFail.tr]);
    }

    submitLoading=false;
    update();

  }

  List<String> hasError() {
    List<String> errorList = [];
    errorList.clear();
    for (var element in formList) {
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
          if (element.selectedValue == '' || element.selectedValue == selectOne) {
            errorList.add('${element.name} ${MyStrings.isRequired}');
          }
        }

      }
    }
    return errorList;
  }


  void changeSelectedValue(value, int index) {
    formList[index].selectedValue = value;
    update();
  }

  void changeSelectedRadioBtnValue(int listIndex, int selectedIndex) {
    formList[listIndex].selectedValue =
    formList[listIndex].options?[selectedIndex];
    update();
  }

  void changeSelectedCheckBoxValue(int listIndex, String value) {

    List<String>list=value.split('_');
    int index=int.parse(list[0]);
    bool status=list[1]=='true'?true:false;

    List<String>?selectedValue=formList[listIndex].cbSelected;

    if(selectedValue!=null){
      String? value=formList[listIndex].options?[index];
      if(status){
        if(!selectedValue.contains(value)){
          selectedValue.add(value!);
          formList[listIndex].cbSelected=selectedValue;
          update();
        }
      }else{
        if(selectedValue.contains(value)){
          selectedValue.removeWhere((element) => element==value);
          formList[listIndex].cbSelected=selectedValue;
          update();
        }
      }
    }else{
      selectedValue=[];
      String? value=formList[listIndex].options?[index];
      if(status){
        if(!selectedValue.contains(value)){
          selectedValue.add(value!);
          formList[listIndex].cbSelected=selectedValue;
          update();
        }
      }else{
        if(selectedValue.contains(value)){
          selectedValue.removeWhere((element) => element==value);
          formList[listIndex].cbSelected=selectedValue;
          update();
        }
      }
    }

  }

  void pickFile(int index) async{

    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'jpeg', 'pdf', 'doc', 'docx']);

    if (result == null) return;

    formList[index].imageFile = File(result.files.single.path!);
    String fileName = result.files.single.name;
    formList[index].selectedValue = fileName;
    update();
    return;
  }

}