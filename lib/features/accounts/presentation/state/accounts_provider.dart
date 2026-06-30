// Re-export del nuevo patrón para mantener compatibilidad
export 'accounts_providers.dart';
export 'accounts_state.dart';
export 'accounts_controller.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/account_entity.dart';
import 'accounts_providers.dart';

final accountsProvider = Provider<List<AccountEntity>>((ref) {
  final state = ref.watch(accountsControllerProvider);
  return state.accounts;
});
