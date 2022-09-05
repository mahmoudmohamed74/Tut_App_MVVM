import 'package:flutter_advanced/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String prefsAppKey = "";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);
  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(prefsAppKey);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      // return default language
      return LanguageType.ENGLISH.getValue();
    }
  }
}
