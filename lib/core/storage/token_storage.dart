import 'package:shared_preferences/shared_preferences.dart';

import '../network/dio_client.dart';

class TokenStorage {
  static const _key = 'auth_token';

  final SharedPreferences _prefs;
  final DioClient _dioClient;
  String? _token;

  TokenStorage(this._prefs, this._dioClient);

  Future<void> init() async {
    _token = _prefs.getString(_key);
    if (_token != null) {
      _dioClient.setToken(_token!);
    }
  }

  bool get hasToken => _token != null;
  String? get token => _token;

  Future<void> saveToken(String token) async {
    _token = token;
    await _prefs.setString(_key, token);
    _dioClient.setToken(token);
  }

  Future<void> clear() async {
    _token = null;
    await _prefs.remove(_key);
    _dioClient.clearToken();
  }
}