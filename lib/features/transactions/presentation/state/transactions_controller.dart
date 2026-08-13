import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'transactions_providers.dart';
import 'transactions_state.dart';

class TransactionsController extends Notifier<TransactionsState> {
  static const int _pageSize = 10;

  @override
  TransactionsState build() {
    ref.watch(currentUserIdProvider);
    Future.microtask(() => loadTransactions());
    return const TransactionsState(isLoading: true);
  }

  Future<void> loadTransactions() async {
    if (state.isLoading && state.transactions.isNotEmpty) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final repository = ref.read(transactionsRepositoryProvider);
      final userId = ref.read(currentUserIdProvider);

      // Delay para mostrar el loader
      await Future.delayed(const Duration(milliseconds: 800));

      final result = await repository.getTransactions(
        userId: userId,
        pageSize: _pageSize,
      );

      state = TransactionsState(
        transactions: result.transactions,
        isLoading: false,
        hasMore: result.transactions.length == _pageSize,
        lastDocument: result.lastDoc,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error al cargar transacciones: $e',
      );
    }
  }

  Future<void> loadMore() async {
    if (state.isLoading || state.isLoadingMore || !state.hasMore ||
        state.lastDocument == null) {
      return;
    }

    state = state.copyWith(isLoadingMore: true, error: null);

    try {
      final repository = ref.read(transactionsRepositoryProvider);
      final userId = ref.read(currentUserIdProvider);

      // Delay para mostrar el loader de paginación
      await Future.delayed(const Duration(milliseconds: 800));

      final result = await repository.getNextPage(
        userId: userId,
        lastDocument: state.lastDocument!,
        pageSize: _pageSize,
      );

      state = state.copyWith(
        transactions: [...state.transactions, ...result.transactions],
        isLoadingMore: false,
        hasMore: result.transactions.length == _pageSize,
        lastDocument: result.lastDoc,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        error: 'Error al cargar más transacciones: $e',
      );
    }
  }

  Future<void> refresh() async {
    state = const TransactionsState(isLoading: true);
    await loadTransactions();
  }
}
