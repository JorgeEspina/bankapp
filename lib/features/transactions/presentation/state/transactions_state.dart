import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/models/transaction_model.dart';

class TransactionsState {
  final List<TransactionModel> transactions;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? error;
  final DocumentSnapshot? lastDocument;

  const TransactionsState({
    this.transactions = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.error,
    this.lastDocument,
  });

  TransactionsState copyWith({
    List<TransactionModel>? transactions,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? error,
    DocumentSnapshot? lastDocument,
  }) {
    return TransactionsState(
      transactions: transactions ?? this.transactions,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      error: error,
      lastDocument: lastDocument ?? this.lastDocument,
    );
  }
}
