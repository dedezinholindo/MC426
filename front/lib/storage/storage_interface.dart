abstract class StorageInterface {
  Future<void> initialize();
  Future<bool> setBool(String key, bool value);
  Future<bool> setDouble(String key, double value);
  Future<bool> setInt(String key, int value);
  Future<bool> setString(String key, String value);
  Future<bool> setStringList(String key, List<String> value);
  bool getBool(String key, {bool defaultValue});
  double getDouble(String key, {double defaultValue});
  int getInt(String key, {int defaultValue});
  String? getString(String key);
  List<String>? getStringList(String key);
  Future<void> clear(String key);
  Future<void> clearAll();
  bool containsKey(String key);
}
