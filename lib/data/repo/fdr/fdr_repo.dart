import 'package:eastern_trust/core/utils/method.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/url.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/services/api_service.dart';

class FDRRepo{

  ApiClient apiClient;
  FDRRepo({required this.apiClient});

  Future<ResponseModel> getFdrPlan() async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.fdrPlanUrl}";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<dynamic> submitFDRPlan(String planId,String amount,String? authMode) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.fdrApplyUrl}$planId';
    Map<String, dynamic>params = {'amount': amount.toString()};
    if(authMode!=null && authMode.isNotEmpty && authMode.toLowerCase()!=MyStrings.selectOne.toLowerCase()){
      // params['auth_mode'] = authMode.toLowerCase();
      params['auth_mode'] = authMode.toLowerCase() == MyStrings.twoFactor.toLowerCase() ? MyStrings.twoFactorValue.toLowerCase() : authMode.toLowerCase();
    }
    ResponseModel responseModel = await apiClient.request(url,Method.postMethod, params, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> getFdrList(int page) async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.fdrListUrl}?page=$page";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> getFDRInstallmentLog(String dpsId,int page) async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.fdrInstalmentUrl}$dpsId?page=$page";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> getFDRPreview(String verificationId) async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.fdrPreviewUrl}$verificationId";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> confirmFDRRequest(String verificationId) async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.fdrConfirmUrl}$verificationId";
    ResponseModel responseModel = await apiClient.request(url, Method.postMethod, null, passHeader: true);
    return responseModel;
  }

  Future<dynamic> closeFDR(String planId) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.fdrCloseUrl}$planId';
    ResponseModel responseModel = await apiClient.request(url,Method.postMethod, null, passHeader: true);
    return responseModel;
  }

}