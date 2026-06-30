import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:bankapp/core/l10n/app_localizations.dart';
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
        title: Text(l10n.creditCards),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.httpConsumption,
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
              child: Text(l10n.testMockApi),
            ),
          ],
        ),
      ),
    );
  }
}
