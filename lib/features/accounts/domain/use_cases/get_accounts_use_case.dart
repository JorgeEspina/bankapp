import '../entities/account_entity.dart';
import '../repositories/accounts_repository.dart';

class GetAccountsUseCase {
  final AccountsRepository repository;

  const GetAccountsUseCase({required this.repository});

  Future<List<AccountEntity>> call() {
    return repository.getAccounts();
  }
}
