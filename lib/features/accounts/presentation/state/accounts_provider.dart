import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/account.dart';

final accountsProvider = Provider<List<Account>>((ref) {
  return [
    Account(name: 'Corriente', number: '1234', balance: 1500.50),
    Account(name: 'Ahorros', number: '5678', balance: 4200.00),
    Account(name: 'Tarjeta Crédito', number: '9012', balance: 2250.75),
  ];
});