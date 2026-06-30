import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'configuration_controller.dart';
import 'configuration_state.dart';

// Controller
final configurationControllerProvider =
    NotifierProvider<ConfigurationController, ConfigurationState>(
  ConfigurationController.new,
);
