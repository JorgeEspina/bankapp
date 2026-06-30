import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bankapp/core/l10n/app_localizations.dart';
import '../../domain/entities/financial_product_entity.dart';
import '../state/dashboard_providers.dart';
import '../widgets/dashboard_error.dart';
import '../widgets/dashboard_shimmer.dart';
import '../widgets/product_card.dart';
import '../widgets/total_balance_card.dart';

class DashboardScreen extends ConsumerWidget {
  static const name = 'dashboard-screen';

  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardControllerProvider);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.dashboard,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () =>
                ref.read(dashboardControllerProvider.notifier).refresh(),
          ),
        ],
      ),
      body: _buildBody(context, ref, state),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, dynamic state) {
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

    return _DashboardContent(
      products: state.products,
      totalBalance: state.totalBalance,
      isFromCache: state.isFromCache,
      productCount: state.productCount,
      accounts: state.accounts,
      creditCards: state.creditCards,
      investments: state.investments,
    );
  }
}

class _DashboardContent extends StatelessWidget {
  final List<FinancialProductEntity> products;
  final double totalBalance;
  final bool isFromCache;
  final int productCount;
  final List<FinancialProductEntity> accounts;
  final List<FinancialProductEntity> creditCards;
  final List<FinancialProductEntity> investments;

  const _DashboardContent({
    required this.products,
    required this.totalBalance,
    required this.isFromCache,
    required this.productCount,
    required this.accounts,
    required this.creditCards,
    required this.investments,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TotalBalanceCard(
            totalBalance: totalBalance,
            isFromCache: isFromCache,
            productCount: productCount,
          ),
          const SizedBox(height: 24),

          if (accounts.isNotEmpty) ...[
            _SectionTitle(title: l10n.accounts, count: accounts.length),
            const SizedBox(height: 12),
            ...accounts.map((p) => ProductCard(product: p)),
            const SizedBox(height: 16),
          ],

          if (creditCards.isNotEmpty) ...[
            _SectionTitle(title: l10n.creditCards, count: creditCards.length),
            const SizedBox(height: 12),
            ...creditCards.map((p) => ProductCard(product: p)),
            const SizedBox(height: 16),
          ],

          if (investments.isNotEmpty) ...[
            _SectionTitle(title: l10n.products, count: investments.length),
            const SizedBox(height: 12),
            ...investments.map((p) => ProductCard(product: p)),
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
