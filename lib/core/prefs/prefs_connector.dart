import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  Prefs._();

  static SharedPreferences? _sharedPreferences;

  static Future<void> preferencesInitializer() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static String getString(String key) {
    return _sharedPreferences?.getString(key) ?? '';
  }

  static int getInt(String key) {
    return _sharedPreferences?.getInt(key) ?? -1;
  }

  static double getDouble(String key) {
    return _sharedPreferences?.getDouble(key) ?? -1;
  }

  static bool getBool(String key) {
    return _sharedPreferences?.getBool(key) ?? false;
  }

  static Future setString(String key, String? value) async {
    await _sharedPreferences?.setString(key, value ?? '');
  }

  static Future setInt(String key, int? value) async {
    await _sharedPreferences?.setInt(key, value ?? -1);
  }

  static void setDouble(String key, double? value) {
    _sharedPreferences?.setDouble(key, value ?? 0.0);
  }

  static void setBool(String key, bool? value) {
    _sharedPreferences?.setBool(key, value ?? false);
  }

  static Future<bool>? removePreference(String key) =>
      _sharedPreferences?.remove(key);

  static Future clear() async {
    await _sharedPreferences?.clear();
  }
}
