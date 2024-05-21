
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eastern_trust/core/helper/shared_preference_helper.dart';
import 'package:eastern_trust/data/model/language/language_model.dart';
import '../../../core/utils/my_strings.dart';

class LocalizationController extends GetxController {

  final SharedPreferences sharedPreferences;

  LocalizationController({required this.sharedPreferences}) {
    loadCurrentLanguage();
  }



  Locale _locale = Locale(MyStrings.languages[0].languageCode, MyStrings.languages[0].countryCode);
  bool _isLtr = true;
  List<LanguageModel> _languages = [];

  Locale get locale => _locale;
  bool get isLtr => _isLtr;
  List<LanguageModel> get languages => _languages;

  void setLanguage(Locale locale) {
    Get.updateLocale(locale);
    _locale = locale;
    if(_locale.languageCode == 'ar' ) {
      _isLtr = false;
    }else {
      _isLtr = true;
    }
    saveLanguage(_locale);
    update();
  }

  void loadCurrentLanguage() async {

    _locale = Locale(sharedPreferences.getString(SharedPreferenceHelper.languageCode) ?? MyStrings.languages[0].languageCode,
        sharedPreferences.getString(SharedPreferenceHelper.countryCode) ?? MyStrings.languages[0].countryCode);
    _isLtr = _locale.languageCode != 'ar';
    update();
  }

  void saveLanguage(Locale locale) async {
    sharedPreferences.setString(SharedPreferenceHelper.languageCode, locale.languageCode);
    sharedPreferences.setString(SharedPreferenceHelper.countryCode, locale.countryCode??'');
  }

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void setSelectIndex(int index) {
    _selectedIndex = index;
    update();
  }

  void searchLanguage(String query) {
    if (query.isEmpty) {
      _languages  = [];
    } else {
      _selectedIndex = -1;
      _languages = [];
    }
    update();
  }
}