import 'dart:convert';
import 'package:eastern_trust/core/utils/method.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/url.dart';
import 'package:eastern_trust/data/model/general_setting/general_settings_response_model.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/services/api_service.dart';

class AirtimeRepo {

  ApiClient apiClient;

  AirtimeRepo({required this.apiClient});

  Future<ResponseModel> getAirtimeCountry() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.airtimeCountryEndPoint}';
    ResponseModel response = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return response;
  }

  Future<ResponseModel> getOperator({required String countryId}) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.operatorEndPoint}/$countryId';
    ResponseModel response = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return response;
  }

  Future<dynamic>getCountryList()async{

    String url = '${UrlContainer.baseUrl}${UrlContainer.countryEndPoint}';
    ResponseModel model=await apiClient.request(url, Method.getMethod, null);
    return model;

  }

  Future<ResponseModel> airtimeApply(Map<String, String> map) async{

    String url = "${UrlContainer.baseUrl}${UrlContainer.airtimeApplyEndPoint}";

    ResponseModel responseModel = await apiClient.request(url, Method.postMethod, map, passHeader: true);
    return responseModel;
  }

}
