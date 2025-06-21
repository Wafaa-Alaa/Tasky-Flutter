import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider {
  static final SharedPreferencesProvider _instance = SharedPreferencesProvider._internal();
  factory SharedPreferencesProvider() => _instance;
  SharedPreferencesProvider._internal();

  SharedPreferences? _prefs;

  Future<SharedPreferences> get prefs async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  // Add any commonly used methods here for convenience
  Future<bool> setString(String key, String value) async {
    final prefs = await this.prefs;
    return prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    final prefs = await this.prefs;
    return prefs.getString(key);
  }

  Future<bool> setBool(String key, bool value) async {
    final prefs = await this.prefs;
    return prefs.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    final prefs = await this.prefs;
    return prefs.getBool(key);
  }

  Future<bool> remove(String key) async {
    final prefs = await this.prefs;
    return prefs.remove(key);
  }
}