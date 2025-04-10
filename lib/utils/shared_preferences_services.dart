import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesServices {
  static SharedPreferences? _sharedPreferences;

  static Future<bool> setValue(String key, dynamic value) async {
    _sharedPreferences ??= await SharedPreferences.getInstance();

    switch (value.runtimeType) {
      case const (String):
        return await _sharedPreferences!.setString(key, value);
      case const (int):
        return await _sharedPreferences!.setInt(key, value);
      case const (bool):
        return await _sharedPreferences!.setBool(key, value);
      case const (double):
        return await _sharedPreferences!.setDouble(key, value);
      case const (List<String>):
        return await _sharedPreferences!.setStringList(key, value);
    }
    return false;
  }

  static Future<dynamic> getValue(String key, dynamic defaultValue) async {
    _sharedPreferences ??= await SharedPreferences.getInstance();

    switch (defaultValue.runtimeType) {
      case const (String):
        return _sharedPreferences!.getString(key) ?? defaultValue;
      case const (int):
        return _sharedPreferences!.getInt(key) ?? defaultValue;
      case const (bool):
        return _sharedPreferences!.getBool(key) ?? defaultValue;
      case const (double):
        return _sharedPreferences!.getDouble(key) ?? defaultValue;
      case const (List<String>):
        return _sharedPreferences!.getStringList(key) ?? defaultValue;
    }
    return defaultValue;
  }

  static Future<bool?> deleteKey(String key) async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    return _sharedPreferences!.remove(key);
  }
}
