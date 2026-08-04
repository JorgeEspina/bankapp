import 'package:cloud_firestore/cloud_firestore.dart';

import '../datasources/transactions_remote_datasource.dart';
import '../models/transaction_model.dart';

class TransactionsRepositoryImpl {
  final TransactionsRemoteDatasource remoteDatasource;

  TransactionsRepositoryImpl({required this.remoteDatasource});

  /// Obtiene la primera página de transacciones.
  Future<({List<TransactionModel> transactions, DocumentSnapshot? lastDoc})>
      getTransactions({
    required String userId,
    int pageSize = 10,
  }) async {
    final snapshot = await remoteDatasource.getRawQuery(
      userId: userId,
      pageSize: pageSize,
    );

    final transactions = snapshot.docs
        .map((doc) => TransactionModel.fromFirestore(doc))
        .toList();

    final lastDoc = snapshot.docs.isNotEmpty ? snapshot.docs.last : null;

    return (transactions: transactions, lastDoc: lastDoc);
  }

  /// Obtiene la siguiente página usando el cursor del último documento.
  Future<({List<TransactionModel> transactions, DocumentSnapshot? lastDoc})>
      getNextPage({
    required String userId,
    required DocumentSnapshot lastDocument,
    int pageSize = 10,
  }) async {
    final snapshot = await remoteDatasource.getRawQuery(
      userId: userId,
      pageSize: pageSize,
      lastDocument: lastDocument,
    );

    final transactions = snapshot.docs
        .map((doc) => TransactionModel.fromFirestore(doc))
        .toList();

    final lastDoc = snapshot.docs.isNotEmpty ? snapshot.docs.last : null;

    return (transactions: transactions, lastDoc: lastDoc);
  }

  /// Agrega una nueva transacción.
  Future<void> addTransaction(TransactionModel transaction) async {
    await remoteDatasource.addTransaction(transaction);
  }
}
