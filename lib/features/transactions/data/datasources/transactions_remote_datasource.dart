import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/transaction_model.dart';

class TransactionsRemoteDatasource {
  final FirebaseFirestore _firestore;

  TransactionsRemoteDatasource({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference get _collection => _firestore.collection('transfers');

  /// Obtiene la primera página de transacciones del usuario.
  /// Retorna [pageSize] documentos ordenados por fecha descendente.
  Future<List<TransactionModel>> getTransactions({
    required String userId,
    int pageSize = 10,
  }) async {
    final query = _collection
        .where('userId', isEqualTo: userId)
        .orderBy('date', descending: true)
        .limit(pageSize);

    final snapshot = await query.get();

    return snapshot.docs
        .map((doc) => TransactionModel.fromFirestore(doc))
        .toList();
  }

  /// Obtiene la siguiente página de transacciones usando el último documento
  /// como cursor para la paginación.
  Future<List<TransactionModel>> getNextPage({
    required String userId,
    required DocumentSnapshot lastDocument,
    int pageSize = 10,
  }) async {
    final query = _collection
        .where('userId', isEqualTo: userId)
        .orderBy('date', descending: true)
        .startAfterDocument(lastDocument)
        .limit(pageSize);

    final snapshot = await query.get();

    return snapshot.docs
        .map((doc) => TransactionModel.fromFirestore(doc))
        .toList();
  }

  /// Obtiene el DocumentSnapshot raw para usar como cursor de paginación.
  Future<QuerySnapshot> getRawQuery({
    required String userId,
    int pageSize = 10,
    DocumentSnapshot? lastDocument,
  }) async {
    Query query = _collection
        .where('userId', isEqualTo: userId)
        .orderBy('date', descending: true)
        .limit(pageSize);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    return query.get();
  }

  /// Agrega una nueva transacción a Firestore.
  Future<void> addTransaction(TransactionModel transaction) async {
    await _collection.add(transaction.toFirestore());
  }
}
