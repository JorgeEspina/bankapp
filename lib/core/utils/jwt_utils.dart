import 'dart:convert';

class JwtUtils {
  static DateTime? getExpirationDate(String token) {
    try {
      final parts = token.split('.');

      if (parts.length != 3) {
        return null;
      }

      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      final decoded = utf8.decode(base64Url.decode(normalized));
      final payloadMap = jsonDecode(decoded);

      final exp = payloadMap['exp'];

      if (exp == null) {
        return null;
      }

      return DateTime.fromMillisecondsSinceEpoch(exp * 1000);
    } catch (_) {
      return null;
    }
  }

  static bool isExpired(String token) {
    final expirationDate = getExpirationDate(token);

    if (expirationDate == null) {
      return true;
    }

    return DateTime.now().isAfter(expirationDate);
  }
}