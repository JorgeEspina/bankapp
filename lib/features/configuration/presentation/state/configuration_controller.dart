import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'configuration_state.dart';
import '../../../../core/notifications/notification_service.dart';

import 'package:flutter/foundation.dart';
class ConfigurationController extends Notifier<ConfigurationState> {
  @override
  ConfigurationState build() => const ConfigurationState();

  void toggleDarkMode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }

  Future<bool> setNotificationsEnabled(bool enabled) async {
    if (!enabled) {
      await NotificationService.instance.disable();
      state = state.copyWith(notificationsEnabled: false);
      return true;
    }

    try {
      final granted =
          await NotificationService.instance.requestPermission();

      debugPrint('Permiso concedido: $granted');

      if (!granted) {
        state = state.copyWith(notificationsEnabled: false);
        return false;
      }

      final token = await NotificationService.instance.getToken();

      debugPrint('TOKEN FCM: $token');

      if (token == null || token.isEmpty) {
        throw Exception('Firebase no devolvió un token FCM');
      }

      state = state.copyWith(notificationsEnabled: true);
      return true;
    } catch (error, stackTrace) {
      debugPrint('ERROR AL ACTIVAR NOTIFICACIONES: $error');
      debugPrintStack(stackTrace: stackTrace);

      state = state.copyWith(notificationsEnabled: false);
      rethrow;
    }
  }
}
