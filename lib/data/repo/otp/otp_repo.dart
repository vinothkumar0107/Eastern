import 'package:eastern_trust/core/utils/method.dart';
import 'package:eastern_trust/core/utils/url.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/services/api_service.dart';

class OtpRepo {

  ApiClient apiClient;
  OtpRepo({required this.apiClient});

  Future<ResponseModel> submitOtp(String code,String otpId) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.submitOtpUrl}$otpId';
    Map<String, dynamic>params = {'otp': code};
    ResponseModel responseModel = await apiClient.request(url,Method.postMethod, params, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel>resendOtp(String otpId) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.resendOtpUrl}$otpId';
    ResponseModel responseModel = await apiClient.request(url,Method.postMethod, null, passHeader: true);
    return responseModel;
  }

}
