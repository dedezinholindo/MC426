import 'package:mc426_front/storage/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageShared implements StorageInterface {
  late SharedPreferences _sharedPreferences;

  StorageShared();

  @override
  Future<void> initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences.reload();
  }

  @override
  Future<void> clear(String key) async {
    await _sharedPreferences.remove(key);
    return;
  }

  @override
  Future<void> clearAll() async {
    await _sharedPreferences.clear();
    return;
  }

  @override
  bool getBool(String key, {bool defaultValue = false}) {
    return _sharedPreferences.getBool(key) ?? defaultValue;
  }

  @override
  double getDouble(String key, {double defaultValue = 0.0}) {
    return _sharedPreferences.getDouble(key) ?? defaultValue;
  }

  @override
  int getInt(String key, {int defaultValue = 0}) {
    return _sharedPreferences.getInt(key) ?? defaultValue;
  }

  @override
  String? getString(String key) {
    return _sharedPreferences.getString(key);
  }

  @override
  List<String>? getStringList(String key) {
    return _sharedPreferences.getStringList(key);
  }

  @override
  Future<bool> setBool(String key, bool value) {
    return _sharedPreferences.setBool(key, value);
  }

  @override
  Future<bool> setDouble(String key, double value) {
    return _sharedPreferences.setDouble(key, value);
  }

  @override
  Future<bool> setInt(String key, int value) {
    return _sharedPreferences.setInt(key, value);
  }

  @override
  Future<bool> setString(String key, String value) {
    return _sharedPreferences.setString(key, value);
  }

  @override
  Future<bool> setStringList(String key, List<String> value) {
    return _sharedPreferences.setStringList(key, value);
  }

  @override
  bool containsKey(String key) {
    return _sharedPreferences.containsKey(key);
  }
}
