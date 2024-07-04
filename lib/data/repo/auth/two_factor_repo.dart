import 'package:eastern_trust/core/utils/method.dart';
import 'package:eastern_trust/core/utils/url.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/services/api_service.dart';

class TwoFactorRepo {

  ApiClient apiClient;
  TwoFactorRepo({required this.apiClient});

  Future<ResponseModel> verify(String code) async {
    final map = {
      'code': code,
    };
    String url = '${UrlContainer.baseUrl}${UrlContainer.verify2FAUrl}';
    ResponseModel responseModel = await apiClient.request(url, Method.postMethod, map, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> getTwoFactorData() async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.getTwoFactorUrl}";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> enableAuthenticate(final param) async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.enableTwoFactorUrl}";
    ResponseModel responseModel = await apiClient.request(url, Method.postMethod, param, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> disableAuthenticate(final param) async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.disableTwoFactorUrl}";
    ResponseModel responseModel = await apiClient.request(url, Method.postMethod, param, passHeader: true);
    return responseModel;
  }

}
