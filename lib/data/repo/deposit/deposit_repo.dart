import 'dart:convert';

import 'package:eastern_trust/core/utils/method.dart';
import 'package:eastern_trust/core/utils/url.dart';
import 'package:eastern_trust/data/model/authorized/deposit/deposit_insert_response_model.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:http/http.dart' as http;
import '../../model/authorization/authorization_response_model.dart';
import '../kyc/kyc_repo.dart';

class DepositRepo{

  ApiClient apiClient;
  DepositRepo({required this.apiClient});

  List<Map<String,String>>fieldList=[];
  List<ModelDynamicValue>filesList=[];

  Future<ResponseModel> getDepositHistory({required int page, String searchText = ""}) async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.depositHistoryUrl}?page=$page&search=$searchText";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<dynamic>getDepositMethods() async {
    String url='${UrlContainer.baseUrl}${UrlContainer.depositMethodUrl}';
    ResponseModel response= await apiClient.request(url,Method.getMethod, null,passHeader: true);
    return response;
  }


  Future<ResponseModel> insertDeposit({required String amount, required String methodCode, required String currency}) async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.depositInsertUrl}";
    Map<String, String> map = {
      "amount" : amount,
      "method_code": methodCode,
      "currency": currency
    };
    ResponseModel responseModel = await apiClient.request(url, Method.postMethod, map, passHeader: true);
    return responseModel;
  }

  Future<dynamic>getUserInfo() async {
    String url='${UrlContainer.baseUrl}${UrlContainer.getProfileEndPoint}';
    ResponseModel response= await apiClient.request(url,Method.getMethod, null,passHeader: true);
    return response;
  }

  Future<AuthorizationResponseModel> submitDepositData(List<Field> list, String trxNo) async {

    apiClient.initToken();
    await modelToMap(list);
    String url = '${UrlContainer.baseUrl}${UrlContainer.depositSubmitManualUrl}';

    var request=http.MultipartRequest('POST',Uri.parse(url));


    Map<String,String>finalMap={};
    fieldList.add({"track" : trxNo});
    for (var element in fieldList) {
      finalMap.addAll(element);
    }

    request.headers.addAll(<String,String>{'Authorization' : 'Bearer ${apiClient.token}'});

    for (var file in filesList) {
      request.files.add( http.MultipartFile(file.key??'', file.value.readAsBytes().asStream(), file.value.lengthSync(), filename: file.value.path.split('/').last));
    }

    request.fields.addAll(finalMap);

    http.StreamedResponse response = await request.send();

    print("http.StreamedResponse  ===> $response");

    String jsonResponse=await response.stream.bytesToString();
    print("jsonResponse  ===> $jsonResponse");
    AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(jsonResponse));


    return model;
  }

  Future<dynamic> modelToMap(List<Field> list) async {

    for (var e in list) {
      if (e.type == 'checkbox') {
        if (e.cbSelected != null && e.cbSelected!.isNotEmpty) {
          for(int i = 0;i<e.cbSelected!.length;i++){
            fieldList.add({'${e.label}[$i]' : e.cbSelected![i]});
          }
        }
      }
      else if (e.type == 'file') {
        if (e.imageFile != null) {
          filesList.add(ModelDynamicValue(e.label,e.imageFile!));
        }
      }
      else {
        if (e.selectedValue != null && e.selectedValue.toString().isNotEmpty) {
          fieldList.add({e.label??'' : e.selectedValue});
        }
      }
    }
  }

}