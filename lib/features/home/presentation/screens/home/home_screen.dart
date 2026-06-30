import 'package:bankapp/features/dashboard/presentation/state/dashboard_providers.dart';
import 'package:bankapp/features/dashboard/presentation/widgets/dashboard_error.dart';
import 'package:bankapp/features/dashboard/presentation/widgets/dashboard_shimmer.dart';
import 'package:bankapp/features/dashboard/presentation/widgets/product_card.dart';
import 'package:bankapp/features/dashboard/presentation/widgets/total_balance_card.dart';
import 'package:bankapp/features/home/presentation/widgets/custom_appbar.dart';
import 'package:bankapp/features/home/presentation/widgets/side_menu.dart';
import 'package:bankapp/core/l10n/app_localizations.dart';
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
    final state = ref.watch(dashboardControllerProvider);
    final l10n = AppLocalizations.of(context);

    if (state.isLoading) {
      return const DashboardShimmer();
    }

    if (state.error != null && state.products.isEmpty) {
      return DashboardError(
        message: l10n.errorLoadingData,
        onRetry: () =>
            ref.read(dashboardControllerProvider.notifier).refresh(),
      );
    }

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Saldo total
          TotalBalanceCard(
            totalBalance: state.totalBalance,
            isFromCache: state.isFromCache,
            productCount: state.productCount,
          ),
          const SizedBox(height: 24),

          // Cuentas
          if (state.accounts.isNotEmpty) ...[
            _SectionTitle(title: l10n.accounts, count: state.accounts.length),
            const SizedBox(height: 12),
            ...state.accounts.map((p) => ProductCard(product: p)),
            const SizedBox(height: 16),
          ],

          // Tarjetas de crédito
          if (state.creditCards.isNotEmpty) ...[
            _SectionTitle(
                title: l10n.creditCards, count: state.creditCards.length),
            const SizedBox(height: 12),
            ...state.creditCards.map((p) => ProductCard(product: p)),
            const SizedBox(height: 16),
          ],

          // Inversiones
          if (state.investments.isNotEmpty) ...[
            _SectionTitle(title: l10n.investments, count: state.investments.length),
            const SizedBox(height: 12),
            ...state.investments.map((p) => ProductCard(product: p)),
          ],
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final int count;

  const _SectionTitle({required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '$count',
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
