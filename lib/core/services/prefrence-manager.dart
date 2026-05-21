import 'package:shared_preferences/shared_preferences.dart';

class PrefrenceManager {
  static final PrefrenceManager _instance = PrefrenceManager._internal();

  factory PrefrenceManager() {
    return _instance;
  }

  //private Constructor
  PrefrenceManager._internal();

  late SharedPreferences _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<bool> setString(String key, String value) async {
    return await _preferences.setString(key, value);
  }

  Future<bool> setInt(String key, int value) async {
    return await _preferences.setInt(key, value);
  }

  Future<bool> setDouble(String key, double value) async {
    return await _preferences.setDouble(key, value);
  }

  Future<bool> setbool(String key, bool value) async {
    return await _preferences.setBool(key, value);
  }

  String? getString(String key) {
    return _preferences.getString(key);
  }

  int? getInt(String key) {
    return _preferences.getInt(key);
  }

  double? getDouble(String key) {
    return _preferences.getDouble(key);
  }

  bool? getBool(String key) {
    return _preferences.getBool(key);
  }

  remove(String key) async {
    return _preferences.remove(key);
  }

  clear() async {
    return _preferences.clear();
  }
}
