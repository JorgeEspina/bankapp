import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/account.dart';
import '../../data/services/accounts_service.dart';

final AccountsService _service = AccountsService();

final accountsProvider = Provider<List<Account>>((ref) {
  return [
    Account(name: 'Corriente', number: '1234', balance: 1500.50),
    Account(name: 'Ahorros', number: '5678', balance: 4200.00),
    Account(name: 'Tarjeta Crédito', number: '9012', balance: 2250.75),
  ];
});

Future<void> loadAccounts() async {

  final data = await _service.getAccounts();

  print("Mock Accounts: $data");
}
