// import 'package:bankapp/features/accounts/data/models/account.dart';
import 'package:bankapp/features/accounts/presentation/state/accounts_provider.dart';
import 'package:bankapp/features/accounts/presentation/widgets/account_card.dart';
import 'package:bankapp/features/home/presentation/widgets/custom_appbar.dart';
import 'package:bankapp/features/home/presentation/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:bankapp/features/home/presentation/widgets/custom_bottom_navigation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: CustomAppbar(scaffoldKey: scaffoldKey),
      ),
      body: const _HomeView(),
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final accounts = ref.watch(accountsProvider);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bienvenido Jorge',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 20),
            Text(
              'Cuentas',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.white70),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: PageView.builder(
                itemCount: accounts.length,
                controller: PageController(viewportFraction: 0.85),
                padEnds: false,
                itemBuilder: (context, index) {
                  final account = accounts[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: AccountCard(account: account),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            Text(
              'Tarjetas de credito',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.white70),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: PageView.builder(
                itemCount: accounts.length,
                controller: PageController(viewportFraction: 0.85),
                padEnds: false,
                itemBuilder: (context, index) {
                  final account = accounts[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: AccountCard(account: account),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
