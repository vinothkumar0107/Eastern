import 'package:eastern_trust/core/utils/method.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/url.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/repo/kyc/kyc_repo.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import '../../model/dynamic_form/form.dart';
import 'package:http/http.dart' as http;

class LoanRepo{

  ApiClient apiClient;
  LoanRepo({required this.apiClient});

  Future<ResponseModel> getLoanPlan() async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.loanPlanUrl}";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<dynamic> submitLoanPlan(String planId,String amount,String? authMode) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.loanApplyUrl}$planId';
    Map<String, dynamic>params = {
      'amount':amount
    };

    if(authMode!=null && authMode.isNotEmpty && authMode.toLowerCase()!=MyStrings.selectOne.toLowerCase()){
      // params['auth_mode'] = authMode.toLowerCase();
      params['auth_mode'] = authMode.toLowerCase() == MyStrings.twoFactor.toLowerCase() ? MyStrings.twoFactorValue.toLowerCase() : authMode.toLowerCase();
    }
    ResponseModel responseModel = await apiClient.request(url,Method.postMethod, params, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> getMyLoanList(int page) async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.loanListUrl}?page=$page&pagination=4  ";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> getLoanInstallmentLog(String dpsId,int page) async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.loanInstalmentUrl}$dpsId?page=$page";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }




  Future<dynamic> confirmLoanPlan(String planId,String amount,String? authMode) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.loanApplyUrl}$planId';
    Map<String, dynamic>params = {
      'amount':amount
    };

    if(authMode!=null && authMode.isNotEmpty && authMode.toLowerCase()!=MyStrings.selectOne.toLowerCase()){
      // params['auth_mode'] = authMode.toLowerCase();
      params['auth_mode'] = authMode.toLowerCase() == MyStrings.twoFactor.toLowerCase() ? MyStrings.twoFactorValue.toLowerCase() : authMode.toLowerCase();
    }
    ResponseModel responseModel = await apiClient.request(url,Method.postMethod, params, passHeader: true);
    return responseModel;
  }


  List<Map<String, String>>fieldList = [];
  List<ModelDynamicValue>filesList = [];
  Future<dynamic> confirmLoanRequest(String planId,String amount, List<FormModel>list, String twoFactorCode) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.loanConfirmUrl}$planId';

    apiClient.initToken();
    await modelToMap(list);
    var request = http.MultipartRequest('POST', Uri.parse(url));

    Map<String, String>finalMap = {};

    for (var element in fieldList) {
      finalMap.addAll(element);
    }

    request.headers.addAll(<String, String>{'Authorization': 'Bearer ${apiClient.token}'});

    for (var file in filesList) {
      request.files.add(http.MultipartFile(
          file.key ?? '', file.value.readAsBytes().asStream(),
          file.value.lengthSync(), filename: file.value.path
          .split('/')
          .last));
    }

    request.fields.addAll({'amount':amount});
    if (twoFactorCode.isNotEmpty) {
      request.fields.addAll({'authenticator_code': twoFactorCode});
    }

    request.fields.addAll(finalMap);

    http.StreamedResponse response = await request.send();
    String jsonResponse = await response.stream.bytesToString();
    ResponseModel responseModel = ResponseModel(response.statusCode==200,'${response.reasonPhrase}', response.statusCode, jsonResponse);

    return responseModel;
  }

  Future<dynamic> modelToMap(List<FormModel> list) async {
    for (var e in list) {
      if (e.type == 'checkbox') {
        if (e.cbSelected != null && e.cbSelected!.isNotEmpty) {
          for (int i = 0; i < e.cbSelected!.length; i++) {
            fieldList.add({'${e.label}[$i]': e.cbSelected![i]});
          }
        }
      }

      else if (e.type == 'file') {
        if (e.file != null) {
          filesList.add(ModelDynamicValue(e.label, e.file!));
        }
      }
      else {
        if (e.selectedValue != null && e.selectedValue
            .toString()
            .isNotEmpty) {
          fieldList.add({e.label ?? '': e.selectedValue});
        }
      }
    }
  }

}