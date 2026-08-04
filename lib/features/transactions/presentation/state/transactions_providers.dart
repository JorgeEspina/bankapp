import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../authentication/presentation/state/auth_provider.dart';
import '../../data/datasources/transactions_remote_datasource.dart';
import '../../data/repositories/transactions_repository_impl.dart';
import 'transactions_controller.dart';
import 'transactions_state.dart';

// Data Sources
final transactionsDatasourceProvider =
    Provider<TransactionsRemoteDatasource>((ref) {
  return TransactionsRemoteDatasource();
});

// Repositories
final transactionsRepositoryProvider =
    Provider<TransactionsRepositoryImpl>((ref) {
  final datasource = ref.watch(transactionsDatasourceProvider);
  return TransactionsRepositoryImpl(remoteDatasource: datasource);
});

// UserId del usuario logueado
final currentUserIdProvider = Provider<String>((ref) {
  final authState = ref.watch(authProvider);
  return authState.user?.uid ?? '';
});

// Controller
final transactionsControllerProvider =
    NotifierProvider<TransactionsController, TransactionsState>(
  TransactionsController.new,
);
