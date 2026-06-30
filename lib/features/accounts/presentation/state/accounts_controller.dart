import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'accounts_providers.dart';
import 'accounts_state.dart';

class AccountsController extends Notifier<AccountsState> {
  @override
  AccountsState build() {
    Future.microtask(() => _loadAccounts());
    return const AccountsState(isLoading: true);
  }

  Future<void> _loadAccounts() async {
    try {
      final getAccounts = ref.read(getAccountsUseCaseProvider);
      final accounts = await getAccounts();
      state = state.copyWith(accounts: accounts, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error al cargar las cuentas',
      );
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, error: null);
    await _loadAccounts();
  }
}
