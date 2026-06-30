import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/data_sources/accounts_remote_data_source.dart';
import '../../data/repositories/accounts_repository_impl.dart';
import '../../domain/repositories/accounts_repository.dart';
import '../../domain/use_cases/get_accounts_use_case.dart';
import 'accounts_controller.dart';
import 'accounts_state.dart';

// Data Sources
final accountsRemoteDataSourceProvider = Provider<AccountsRemoteDataSource>(
  (ref) => AccountsRemoteDataSource(),
);

// Repositories
final accountsRepositoryProvider = Provider<AccountsRepository>(
  (ref) => AccountsRepositoryImpl(
    remoteDataSource: ref.read(accountsRemoteDataSourceProvider),
  ),
);

// Use Cases
final getAccountsUseCaseProvider = Provider<GetAccountsUseCase>(
  (ref) => GetAccountsUseCase(
    repository: ref.read(accountsRepositoryProvider),
  ),
);

// Controller
final accountsControllerProvider =
    NotifierProvider<AccountsController, AccountsState>(
  AccountsController.new,
);
