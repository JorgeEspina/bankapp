import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'configuration_state.dart';

class ConfigurationController extends Notifier<ConfigurationState> {
  @override
  ConfigurationState build() => const ConfigurationState();

  void toggleDarkMode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }

  void toggleNotifications() {
    state = state.copyWith(notificationsEnabled: !state.notificationsEnabled);
  }
}
