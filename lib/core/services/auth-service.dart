// auth_service.dart
import 'package:flutter/cupertino.dart';
import 'package:tas/core/services/sharedprefernce-manager.dart';

class AuthService {
  final SharedPreferencesProvider _prefsProvider = SharedPreferencesProvider();
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final ValueNotifier<String?> authNotifier = ValueNotifier(null);

  Future<void> initialize() async {
  
    authNotifier.value =await _prefsProvider .getString('username');
  }

  Future<void> login(String username) async {
    await _prefsProvider .setString('username', username);
    authNotifier.value = username;
  }

  Future<void> logout() async {

    await _prefsProvider.remove('username');
    await _prefsProvider.remove('tasks');
    await _prefsProvider.remove('profileImage');
    authNotifier.value = null;
  }
}