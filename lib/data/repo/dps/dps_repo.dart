import 'package:eastern_trust/core/utils/method.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/url.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/services/api_service.dart';

class DPSRepo{

  ApiClient apiClient;
  DPSRepo({required this.apiClient});

  Future<ResponseModel> getDpsPlan() async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.dpsPlanUrl}";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<dynamic> submitDPSPlan(String planId,String? authMode) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.dpsApplyUrl}$planId';
    Map<String, dynamic>params = {};

    if(authMode!=null && authMode.isNotEmpty && authMode.toLowerCase()!=MyStrings.selectOne.toLowerCase()){
      params['auth_mode'] = authMode.toLowerCase();
    }
    ResponseModel responseModel = await apiClient.request(url,Method.postMethod, params, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> getDPSList(int page) async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.dpsListUrl}?page=$page";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> getDPSInstallmentLog(String dpsId,int page) async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.dpsInstalmentUrl}$dpsId?page=$page";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<dynamic> withdrawDPS(String planId) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.dpsWithdrawUrl}$planId';
    ResponseModel responseModel = await apiClient.request(url,Method.postMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> getDPSPreview(String verificationId) async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.dpsPreviewUrl}$verificationId";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> confirmDPSRequest(String verificationId) async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.dpsConfirmUrl}$verificationId";
    ResponseModel responseModel = await apiClient.request(url, Method.postMethod, null, passHeader: true);
    return responseModel;
  }

}