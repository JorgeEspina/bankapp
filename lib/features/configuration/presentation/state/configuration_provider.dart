import 'package:flutter_riverpod/flutter_riverpod.dart';

final configurationProvider =
    StateNotifierProvider<ConfigurationNotifier, ConfigurationState>((ref) {
      return ConfigurationNotifier();
    });

class ConfigurationNotifier extends StateNotifier<ConfigurationState> {
  ConfigurationNotifier() : super(ConfigurationState());

  void toggleDarkMode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }

  void toggleNotifications() {
    state = state.copyWith(notificationsEnabled: !state.notificationsEnabled);
  }
}

class ConfigurationState {
  final bool isDarkMode;
  final bool notificationsEnabled;

  ConfigurationState({
    this.isDarkMode = true,
    this.notificationsEnabled = true,
  });

  ConfigurationState copyWith({bool? isDarkMode, bool? notificationsEnabled}) {
    return ConfigurationState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }
}
