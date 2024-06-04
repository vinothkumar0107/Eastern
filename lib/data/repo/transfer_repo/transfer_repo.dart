
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/url.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/repo/kyc/kyc_repo.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:http/http.dart' as http;
import '../../../core/utils/method.dart';
import '../../model/dynamic_form/form.dart';

class TransferRepo{

  ApiClient apiClient;
  TransferRepo({required this.apiClient});

  Future<ResponseModel> getTransferHistory(int page) async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.transferHistoryUrl}?page=$page";
    ResponseModel responseModel = await apiClient.request(url,Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> getWireTransferData() async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.wireTransferFormUrl}";
    ResponseModel responseModel = await apiClient.request(url,Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<dynamic> otherBankTransferRequest(String id,String amount,String? authMode) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.otherBankTransferUrl}$id';
    Map<String, dynamic>params = {'amount': amount.toString()};
    if(authMode!=null && authMode.isNotEmpty && authMode.toLowerCase()!=MyStrings.selectOne.toLowerCase()){
      params['auth_mode'] = authMode.toLowerCase();
    }
    ResponseModel responseModel = await apiClient.request(url,Method.postMethod, params, passHeader: true);
    return responseModel;
  }

  Future<dynamic> myBankTransferRequest(String id,String amount,String? authMode) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.myBankTransferUrl}$id';
    Map<String, dynamic>params = {'amount': amount.toString()};
    if(authMode!=null && authMode.isNotEmpty && authMode.toLowerCase()!=MyStrings.selectOne.toLowerCase()){
      params['auth_mode'] = authMode.toLowerCase();
    }
    ResponseModel responseModel = await apiClient.request(url,Method.postMethod, params, passHeader: true);
    return responseModel;
  }


  List<Map<String, String>>fieldList = [];
  List<ModelDynamicValue>filesList = [];
  Future<dynamic> submitWireTransferRequest(String amount,String authRequest, List<FormModel>list, String twoFactorCode) async {

    String url = '${UrlContainer.baseUrl}${UrlContainer.wireTransferRequestUrl}';

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
          file.value.lengthSync(), filename: file.value.path.split('/').last));
    }

    request.fields.addAll({'amount':amount});

    if (twoFactorCode.isNotEmpty) {
      request.fields.addAll({'authenticator_code': twoFactorCode});
    }

    if (authRequest.isNotEmpty && authRequest.toLowerCase()!=MyStrings.selectOne.toLowerCase()) {
      request.fields.addAll({'auth_mode': authRequest.toLowerCase()});
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
        if (e.selectedValue != null && e.selectedValue.toString().isNotEmpty) {
          fieldList.add({e.label ?? '': e.selectedValue});
        }
      }
    }
  }

}