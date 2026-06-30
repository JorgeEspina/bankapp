import '../../domain/entities/account_entity.dart';

class AccountsState {
  const AccountsState({
    this.accounts = const [],
    this.isLoading = false,
    this.error,
  });

  final List<AccountEntity> accounts;
  final bool isLoading;
  final String? error;

  AccountsState copyWith({
    List<AccountEntity>? accounts,
    bool? isLoading,
    String? error,
  }) {
    return AccountsState(
      accounts: accounts ?? this.accounts,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
