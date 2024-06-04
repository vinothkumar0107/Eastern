import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/shared_preference_helper.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/theme/light.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/theme/dark.dart';

class ThemeController extends GetxController implements GetxService {

  final SharedPreferences sharedPreferences;
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  ThemeController({required this.sharedPreferences}) {
    _loadCurrentTheme();
  }

  void _loadCurrentTheme() {
    _darkTheme = sharedPreferences.getBool(SharedPreferenceHelper.theme) ?? false;
    update();
  }

  void toggleTheme() {
    _darkTheme = !_darkTheme;
    sharedPreferences.setBool(MyStrings.theme, _darkTheme);
    if(_darkTheme){
      Get.changeTheme(dark);
    }else{
      Get.changeTheme(light);
    }
    update();
  }

}
