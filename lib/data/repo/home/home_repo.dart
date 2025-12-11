import 'dart:convert';
import 'package:eastern_trust/core/utils/method.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/url.dart';
import 'package:eastern_trust/data/model/general_setting/general_settings_response_model.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/services/api_service.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../core/helper/shared_preference_helper.dart';
import '../../../core/route/route.dart';
import '../../model/dashboard/dashboard_response_model.dart';

class HomeRepo {

  ApiClient apiClient;

  HomeRepo({required this.apiClient});

  String token = '', tokenType = '';
  String isTwoFactorEnabled = '';

  Future<ResponseModel> getData() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.dashBoardEndPoint}';
    ResponseModel response = await apiClient.request(url, Method.getMethod, null, passHeader: true);

    DashboardResponseModel dashModel = DashboardResponseModel.fromJson(jsonDecode(response.responseJson));
    if(dashModel.status.toString().toLowerCase() == 'success'){
      isTwoFactorEnabled = dashModel.data?.user?.ts.toString() ?? "0";
      apiClient.sharedPreferences.setString(SharedPreferenceHelper.twoFactorEnableKey, isTwoFactorEnabled);
    }

    return response;
  }

  Future<dynamic> refreshGeneralSetting() async {

    String url = '${UrlContainer.baseUrl}${UrlContainer.generalSettingEndPoint}';
    ResponseModel response = await apiClient.request(url, Method.getMethod, null, passHeader: false);

    if (response.statusCode == 200) {
      GeneralSettingsResponseModel model = GeneralSettingsResponseModel.fromJson(jsonDecode(response.responseJson));
      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        apiClient.storeGeneralSetting(model);
      }
    }
  }

}
