import '../../domain/entities/account_entity.dart';
import '../../domain/repositories/accounts_repository.dart';
import '../data_sources/accounts_remote_data_source.dart';

class AccountsRepositoryImpl implements AccountsRepository {
  final AccountsRemoteDataSource remoteDataSource;

  const AccountsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<AccountEntity>> getAccounts() async {
    final models = await remoteDataSource.getAccounts();
    return models.map((m) => m.toEntity()).toList();
  }
}
