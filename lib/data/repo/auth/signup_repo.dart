import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:eastern_trust/core/helper/shared_preference_helper.dart';
import 'package:eastern_trust/core/utils/method.dart';
import 'package:eastern_trust/core/utils/url.dart';
import 'package:eastern_trust/data/model/auth/sign_up_model/sign_up_model.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/services/api_service.dart';

class RegistrationRepo {
  ApiClient apiClient;

  RegistrationRepo({required this.apiClient});

  Future<ResponseModel> registerUser(SignUpModel model) async {
    final map = modelToMap(model);
    String url ='${UrlContainer.baseUrl}${UrlContainer.registrationEndPoint}';
    final res=await apiClient.request(url, Method.postMethod, map,passHeader: true,isOnlyAcceptType: true);
   return res;
  }

  Map<String, dynamic> modelToMap(SignUpModel model) {
    Map<String, dynamic> bodyFields = {
      'mobile':model.mobile,
      'email': model.email,
      'agree': 'true',
      'username': model.username,
      'password': model.password,
      'password_confirmation':model.password,//password and confirm password check from front end panel
      'country_code': model.countryCode, //model.country_code,
      'country': model.country, //model.country,
      "mobile_code": model.mobileCode,
    };

    return bodyFields;
  }

  Future<dynamic>getCountryList()async{

    String url = '${UrlContainer.baseUrl}${UrlContainer.countryEndPoint}';
    ResponseModel model=await apiClient.request(url, Method.getMethod, null);
    return model;

  }

  Future<bool> sendUserToken() async {
    String deviceToken;
    if (apiClient.sharedPreferences.containsKey(SharedPreferenceHelper.fcmDeviceKey)) {
      deviceToken =
          apiClient.sharedPreferences.getString(SharedPreferenceHelper.fcmDeviceKey) ??
              '';
    } else {
      deviceToken = '';
    }
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    bool success = false;
    if (deviceToken.isEmpty) {
      firebaseMessaging.getToken().then((fcmDeviceToken) async {
        success = await sendUpdatedToken(fcmDeviceToken ?? '');
      });
    } else {
      firebaseMessaging.onTokenRefresh.listen((fcmDeviceToken) async {
          apiClient.sharedPreferences.setString(
              SharedPreferenceHelper.fcmDeviceKey, fcmDeviceToken);
          success = await sendUpdatedToken(fcmDeviceToken);

      });
    }
    return success;
  }

  Future<bool> sendUpdatedToken(String deviceToken) async {
    String url='${UrlContainer.baseUrl}${UrlContainer.deviceTokenEndPoint}';
    Map<String,String>map = deviceTokenMap(deviceToken);
    await apiClient.request(url,Method.postMethod,map,passHeader: true);
    return true;
  }

  Map<String,String> deviceTokenMap(String deviceToken) {
    Map<String, String> map = {'token': deviceToken.toString()};
    return map;
  }

}