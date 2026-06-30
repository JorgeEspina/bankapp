class ConfigurationState {
  const ConfigurationState({
    this.isDarkMode = true,
    this.notificationsEnabled = true,
  });

  final bool isDarkMode;
  final bool notificationsEnabled;

  ConfigurationState copyWith({
    bool? isDarkMode,
    bool? notificationsEnabled,
  }) {
    return ConfigurationState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }
}
