import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/jwt_utils.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<bool> hasValidToken();
  Future<void> clearSession();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const String tokenKey = 'access_token';

  @override
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
  }

  @override
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }

  @override
  Future<bool> hasValidToken() async {
    final token = await getToken();

    if (token == null || token.isEmpty) {
      return false;
    }

    final isExpired = JwtUtils.isExpired(token);

    if (isExpired) {
      await clearSession();
      return false;
    }

    return true;
  }

  @override
  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
  }
}