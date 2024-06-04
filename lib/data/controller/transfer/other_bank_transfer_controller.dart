import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/data/model/authorization/authorization_response_model.dart' as auth_model;
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/model/transfer/beneficiary/other_bank_beneficiary_response_model.dart';
import 'package:eastern_trust/data/repo/transfer_repo/beneficiaries_repo/beneficiaries_repo.dart';
import 'package:eastern_trust/data/repo/transfer_repo/transfer_repo.dart';
import 'package:eastern_trust/views/components/file_download_dialog/download_dialogue.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';
import '../../../core/utils/url.dart';
import '../../model/dynamic_form/form.dart';

class OtherBankTransferController extends GetxController{

  TransferRepo repo;
  BeneficiaryRepo beneficiaryRepo;
  OtherBankTransferController({required this.repo,required this.beneficiaryRepo});

  bool isLoading = true;
  List<Data> beneficiaryList = [];
  List<Banks> bankList = [];
  List<FormModel>? bankFormList = [];
  Banks selectedBank = Banks(name: MyStrings.selectOne);

  int page = 1;
  String nextPageUrl = "";
  String currency = "";
  String currencySymbol = "";
  String limitPerTrx = '0';
  String dailyMaxLimit = '0';
  String monthlyLimit = '0';
  String chargePerTrx = '0';

  List<String>authorizationList = [];
  String? selectedAuthorizationMode ;

  void changeSelectedBank(dynamic value){
    if( value!=null ){
      selectedBank = value;
      bankFormList  = selectedBank.form?.formData?.list;
      update();
    }
  }

  Future<void> loadPaginationData() async{
    await loadHistoryList();
    update();
  }

  void changeAuthorizationMode(String? value){
    if(value!=null){
      selectedAuthorizationMode = value;
      update();
    }
  }


  void initialSelectedValue() async{
    currency = repo.apiClient.getCurrencyOrUsername();
    currencySymbol = repo.apiClient.getCurrencyOrUsername(isSymbol: true);
    authorizationList = repo.apiClient.getAuthorizationList();
    changeAuthorizationMode(authorizationList[0]);
    page = 0;
    beneficiaryList.clear();
    bankList.clear();
    selectedBank = Banks(name: MyStrings.selectOne);
    bankList.add(selectedBank);
    isLoading = true;
    update();
    await loadHistoryList();
    isLoading = false;
    update();


  }

  Future<void> loadHistoryList() async{

    page = page + 1;
    if(page == 1){
      beneficiaryList.clear();
      bankList.clear();
      selectedBank = Banks(name: MyStrings.selectOne);
      bankList.add(selectedBank);
    }

    ResponseModel responseModel = await beneficiaryRepo.getOtherBankBeneficiary(page);
    if(responseModel.statusCode == 200){
      OtherBankBeneficiaryResponseModel model = OtherBankBeneficiaryResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      nextPageUrl = model.data?.beneficiaries?.nextPageUrl ?? "";

      if(model.status.toString().toLowerCase() == "success"){
        List<Data>? tempBeneficiaryList = model.data?.beneficiaries?.data;
        if(tempBeneficiaryList != null && tempBeneficiaryList.isNotEmpty){
          beneficiaryList.addAll(tempBeneficiaryList);
        }
        List<Banks>? tempBankList = model.data?.banks;
        if(tempBankList !=null && tempBankList.isNotEmpty){
          bankList.addAll(tempBankList);
        }
      }
      else{
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong]);
      }
    }
    else{
      CustomSnackBar.error(errorList: [responseModel.message],);
    }
  }

  bool hasNext(){
    return nextPageUrl.isNotEmpty && nextPageUrl != 'null' ? true : false;
  }


  int expandIndex = -1;
  void changeIndex(int index){
    if(expandIndex!=index){
      expandIndex = index;
    } else{
      expandIndex = -1;
    }
    update();

  }

  int attachmentIndex = -1;
  void downloadAttachment(String url,BuildContext context) {
    String mainUrl = '${UrlContainer.baseUrl}assets/verify/$url';
    if(url.isNotEmpty && url != 'null'){
      showDialog(
        context: context,
        builder: (context) => DownloadingDialog(isPdf:false,url: mainUrl,fileName: '',),
      );
      update();
    }
  }

  TextEditingController amountController = TextEditingController();
  bool submitLoading = false;
  void transferMoney(String id) async{
    String amount = amountController.text;
    if(amount.isEmpty){
      CustomSnackBar.error(errorList: [MyStrings.invalidAmount]);
      return;
    }
    submitLoading = true;
    update();
    ResponseModel response = await repo.otherBankTransferRequest(id,amount,selectedAuthorizationMode);
    if(response.statusCode==200){
      auth_model.AuthorizationResponseModel model = auth_model.AuthorizationResponseModel.fromJson(jsonDecode(response.responseJson));
      if(model.status?.toLowerCase()==MyStrings.success.toLowerCase()){
        String otp = model.data?.otpId??'';
        if(otp.isNotEmpty && authorizationList.length>1){
          Get.offAndToNamed(RouteHelper.otpScreen,arguments:[RouteHelper.transferHistoryScreen,model.data?.otpId,selectedAuthorizationMode?.toLowerCase().toString()]);
        } else{
          Get.offAndToNamed(RouteHelper.transferHistoryScreen);
          CustomSnackBar.success(successList: model.message?.success??[MyStrings.requestSuccess]);
        }
      } else{
        CustomSnackBar.error(errorList: model.message?.error??[MyStrings.requestFail]);
      }
    } else{
      CustomSnackBar.error(errorList: [response.message]);
    }
    amountController.text = '';
    submitLoading = false;
    update();
  }

  void clearTextField(){
    shortNameController.text   = '';
    bankFormList = [];
    if(bankList.isNotEmpty){
      selectedBank = bankList[0];
    }
  }
  TextEditingController shortNameController   = TextEditingController();

  bool isSubmitLoading = false;
  void addBeneficiary() async{


    String shortName = shortNameController.text;
    String bankId = selectedBank.id.toString();

    if(bankId.isEmpty || bankId == 'null'||bankId == '-1'){
      CustomSnackBar.error(errorList: [MyStrings.selectBank]);
      return;
    }

    if(shortName.isEmpty){
      CustomSnackBar.error(errorList: [MyStrings.shortNameRequired]);
      return;
    }

    List<String> list = hasError();
    if (list.isNotEmpty) {
      CustomSnackBar.error(errorList: list);
      return;
    }
    isSubmitLoading = true;
    update();
    auth_model.AuthorizationResponseModel model = await beneficiaryRepo.addOtherBankBeneficiary(bankId,shortName,bankFormList!=null?bankFormList!:[]);
    if(model.status?.toLowerCase()==MyStrings.success.toLowerCase()){
      Get.back();
      CustomSnackBar.success(successList: model.message?.success??[MyStrings.requestSuccess]);
      initialSelectedValue();

    } else{
      CustomSnackBar.error(errorList: model.message?.error??[MyStrings.requestFail]);
    }

    isSubmitLoading = false;
    update();
  }

  List<String> hasError() {
    List<String> errorList = [];
    if(bankFormList!=null && bankFormList!.isNotEmpty){
      for (var element in bankFormList!) {
        if (element.isRequired == 'required') {
          if (element.selectedValue == '' || element.selectedValue.toString().toLowerCase() == MyStrings.selectOne.toLowerCase() ) {
            errorList.add('${element.name} ${MyStrings.isRequired}');
          }
        }
      }
    }
    return errorList;
  }

  void changeSelectedValue(value, int index) {
    bankFormList?[index].selectedValue = value;
    update();
  }

  void changeSelectedRadioBtnValue(int listIndex, int selectedIndex) {
    bankFormList?[listIndex].selectedValue = bankFormList?[listIndex].options?[selectedIndex];
    update();
  }

  void changeSelectedCheckBoxValue(int listIndex, String value) {

    List<String>list=value.split('_');
    int index=int.parse(list[0]);
    bool status=list[1]=='true'?true:false;

    List<String>?selectedValue=bankFormList?[listIndex].cbSelected;

    if(selectedValue!=null){
      String? value=bankFormList?[listIndex].options?[index];
      if(status){
        if(!selectedValue.contains(value)){
          selectedValue.add(value!);
          bankFormList?[listIndex].cbSelected = selectedValue;
          update();
        }
      }else{
        if(selectedValue.contains(value)){
          selectedValue.removeWhere((element) => element==value);
          bankFormList?[listIndex].cbSelected=selectedValue;
          update();
        }
      }
    }else{
      selectedValue=[];
      String? value=bankFormList?[listIndex].options?[index];
      if(status){
        if(!selectedValue.contains(value)){
          selectedValue.add(value!);
          bankFormList?[listIndex].cbSelected=selectedValue;
          update();
        }
      }else{
        if(selectedValue.contains(value)){
          selectedValue.removeWhere((element) => element==value);
          bankFormList?[listIndex].cbSelected=selectedValue;
          update();
        }
      }
    }

  }

  void changeSelectedFile(File file, int index) {
    bankFormList?[index].file = file;
    update();
  }

  void pickFile(int index) async{

    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'jpeg', 'pdf', 'doc', 'docx']);

    if (result == null) return;

    bankFormList?[index].file = File(result.files.single.path!);
    String fileName = result.files.single.name;
    bankFormList?[index].selectedValue = fileName;
    update();
    return;
  }


  bool isLimitShow = false;
  void changeLimitShowStatus(){
    isLimitShow = !isLimitShow;
    update();
  }

}