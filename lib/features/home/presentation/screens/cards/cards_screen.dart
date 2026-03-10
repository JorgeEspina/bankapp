import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:bankapp/features/accounts/data/services/accounts_service.dart';

class CardsScreen extends StatelessWidget {
  static const name = 'cards-screen';

  const CardsScreen({super.key});

  Future<void> loadData() async {
    final service = AccountsService();

    final accounts = await service.getAccounts();

    print("Mock Accounts:");
    print(accounts);
  }

  // Consumo de HTTP
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
        title: const Text("Tarjetas de Crédito"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Consumo de Cliente HTTP',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                loadData();
              },
              child: const Text("Probar API Mock"),
            ),
          ],
        ),
      ),
    );
  }
}