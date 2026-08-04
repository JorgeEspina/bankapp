import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final String userId;
  final String description;
  final double amount;
  final DateTime date;
  final String type; // 'income' | 'expense'

  const TransactionModel({
    required this.id,
    required this.userId,
    required this.description,
    required this.amount,
    required this.date,
    required this.type,
  });

  factory TransactionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TransactionModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      description: data['description'] ?? '',
      amount: (data['amount'] ?? 0).toDouble(),
      date: (data['date'] as Timestamp).toDate(),
      type: data['type'] ?? 'expense',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'description': description,
      'amount': amount,
      'date': Timestamp.fromDate(date),
      'type': type,
    };
  }

  bool get isIncome => type == 'income';
}
