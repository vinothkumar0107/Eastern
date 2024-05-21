import 'dart:convert';
import 'package:eastern_trust/data/model/authorization/authorization_response_model.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import '../../../../core/utils/method.dart';
import '../../../../core/utils/url.dart';
import 'package:http/http.dart' as http;
import '../../../model/dynamic_form/form.dart';
import '../../kyc/kyc_repo.dart';

class BeneficiaryRepo{

  ApiClient apiClient;
  BeneficiaryRepo({required this.apiClient});

  Future<ResponseModel> getOtherBankBeneficiary(int page) async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.otherBankBeneficiaryUrl}?page=$page";
    ResponseModel responseModel = await apiClient.request(url,Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> getMyBankBeneficiary(int page) async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.myBankBeneficiaryUrl}?page=$page";
    ResponseModel responseModel = await apiClient.request(url,Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> checkMyBankBeneficiary(String value) async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.checkAccountUrl}$value";
    ResponseModel responseModel = await apiClient.request(url,Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel>addBeneficiary(String accountNumber, String accountName, String shortName) async{

    String url = "${UrlContainer.baseUrl}${UrlContainer.myBankBeneficiaryUrl}";

    Map<String,dynamic>map = {
      'account_number':accountNumber,
      'account_name':accountName,
      'short_name':shortName
    };

    ResponseModel responseModel = await apiClient.request(url,Method.postMethod, map, passHeader: true);
    return responseModel;
  }


  List<Map<String, String>>fieldList = [];
  List<ModelDynamicValue>filesList = [];
  Future<dynamic>addOtherBankBeneficiary(String bankId,String shortName,List<FormModel>list) async{

    String url = "${UrlContainer.baseUrl}${UrlContainer.otherBankBeneficiaryUrl}";

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
    request.fields.addAll({
      'bank':bankId,
      'short_name':shortName
    });

    request.fields.addAll(finalMap);


    http.StreamedResponse response = await request.send();
    String jsonResponse = await response.stream.bytesToString();

    AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(jsonResponse));
    return model;
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