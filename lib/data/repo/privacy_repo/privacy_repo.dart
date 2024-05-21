
import 'package:eastern_trust/core/utils/method.dart';
import 'package:eastern_trust/core/utils/url.dart';
import 'package:eastern_trust/data/services/api_service.dart';

class PrivacyRepo{

  ApiClient apiClient;
  PrivacyRepo({required this.apiClient});

  Future<dynamic>loadPrivacyAndPolicy()async{
    String template = apiClient.getTemplateName();
    String url = '${UrlContainer.baseUrl}${UrlContainer.privacyPolicyEndPoint}?template=$template';
    final response = await apiClient.request(url, Method.getMethod, null);
    return response;
  }

}