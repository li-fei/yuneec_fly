import 'package:shared_preferences/shared_preferences.dart';

class SPutils {

  static String key_settingSoundOnOffCheck = "settingSoundOnOffCheck";
  static String key_settingNextStartupCheck = "settingNextStartupCheck";
  static String key_settingUseRecomendCheck = "settingUseRecomendCheck";
  static String key_settingLowPowerCheck = "settingLowPowerCheck";
  static String key_disableAllDataPersistenceCheck = "disableAllDataPersistenceCheck";
  static String key_settingSaveLogAfterCheck = "settingSaveLogAfterCheck";
  static String key_settingSaveLogsEvenCheck = "settingSaveLogsEvenCheck";

  static saveBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static Future<bool> getBool(String key) async {
    bool value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    value = prefs.getBool(key);
    return value;
  }

  static saveString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<String> getString(String key) async {
    String value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    value = prefs.getString(key);
    return value;
  }

}
