import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:eastern_trust/core/utils/method.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/url.dart';
import 'package:eastern_trust/data/model/authorization/authorization_response_model.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/model/kyc/kyc_response_model.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';

class KycRepo {

  ApiClient apiClient;
  KycRepo({required this.apiClient});

  Future<KycResponseModel> getKycData() async {

    String url = '${UrlContainer.baseUrl}${UrlContainer.kycFormUrl}';
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);

    if (responseModel.statusCode == 200) {
      KycResponseModel model =
      KycResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.status == 'success') {
        return model;
      } else {
        if(model.remark?.toLowerCase() != 'already_verified' && model.remark?.toLowerCase() != 'under_review') {
          CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong]);
        }
        return model;
      }
    } else {
      return KycResponseModel();
    }
  }



  List<Map<String,String>>fieldList=[];
  List<ModelDynamicValue>filesList=[];



  Future<AuthorizationResponseModel> submitKycData(List<FormModel> list) async {


    apiClient.initToken();
    await modelToMap(list);
    String url = '${UrlContainer.baseUrl}${UrlContainer.kycSubmitUrl}';

    var request=http.MultipartRequest('POST',Uri.parse(url));


    Map<String,String>finalMap={};

    for (var element in fieldList) {
      finalMap.addAll(element);
    }

    request.headers.addAll(<String,String>{'Authorization' : 'Bearer ${apiClient.token}'});

    for (var file in filesList) {
      request.files.add( http.MultipartFile(file.key??'', file.value.readAsBytes().asStream(), file.value.lengthSync(), filename: file.value.path.split('/').last));
    }

    request.fields.addAll(finalMap);

    http.StreamedResponse response = await request.send();

    String jsonResponse=await response.stream.bytesToString();
    AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(jsonResponse));


    return model;
  }

  Future<dynamic> modelToMap(List<FormModel> list) async {

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

class ModelDynamicValue {

  String? key;
  dynamic value;
  ModelDynamicValue(this.key, this.value);

}
