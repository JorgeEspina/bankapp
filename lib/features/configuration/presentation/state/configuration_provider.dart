// Re-export del nuevo patrón para mantener compatibilidad
// con imports existentes en el proyecto.
export 'configuration_providers.dart';
export 'configuration_state.dart';
export 'configuration_controller.dart';

// Alias de compatibilidad - usar configurationControllerProvider en código nuevo
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'configuration_controller.dart';
import 'configuration_state.dart';

/// @deprecated Usar configurationControllerProvider en su lugar.
final configurationProvider =
    NotifierProvider<ConfigurationController, ConfigurationState>(
  ConfigurationController.new,
);
