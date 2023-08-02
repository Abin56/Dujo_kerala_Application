import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static String batchIdKey = 'batchId';
  static String schoolIdKey = 'schoolId';
  static String classIdKey = 'classId';
  static String userRoleKey = 'userRole';
  static late SharedPreferences _prefs;

  static Future<void> clearSharedPreferenceData() async {
    await setString(batchIdKey, "");
    await setString(schoolIdKey, "");
    await setString(classIdKey, "");
    await setString(userRoleKey, "");
  }

  static Future<void> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String? getString(String key) {
    return _prefs.getString(key);
  }

  static Future<bool> setString(String key, String value) async {
    final result = await _prefs.setString(key, value);
    return result;
  }

  static int? getInt(String key) {
    return _prefs.getInt(key);
  }

  static Future<bool> setInt(String key, int value) async {
    final result = await _prefs.setInt(key, value);

    return result;
  }

  // Add more functions as needed
}
