import 'package:eastern_trust/core/utils/method.dart';
import 'package:eastern_trust/core/utils/url.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/services/api_service.dart';

class BalanceTransferRepo{

  ApiClient apiClient;
  BalanceTransferRepo({required this.apiClient});


  Future<ResponseModel> transferBalance(String username,String amount,String wallet) async{
    Map<String, String> map = {'username': username, 'amount': amount,'wallet':wallet};
    String url = '${UrlContainer.baseUrl}${UrlContainer.balanceTransfer}';
    ResponseModel model=await apiClient.request(url, Method.postMethod, map,passHeader: true);
    return model;
  }
}