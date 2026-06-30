import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bankapp/core/l10n/app_localizations.dart';
import '../../domain/entities/financial_product_entity.dart';

class ProductCard extends StatelessWidget {
  final FinancialProductEntity product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: _getGradient(),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: _getGradient().colors.first.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(_getIcon(), color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    _getProductName(l10n),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Text(
                product.number,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            _formatCurrency(product.balance),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _getSubtitle(l10n),
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  String _getProductName(AppLocalizations l10n) {
    switch (product.type) {
      case ProductType.savings:
        return l10n.savingsAccount;
      case ProductType.checking:
        return l10n.checkingAccount;
      case ProductType.creditCard:
        return l10n.creditCard;
      case ProductType.investment:
        return l10n.investmentFund;
    }
  }

  String _formatCurrency(double amount) {
    final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
    return formatter.format(amount);
  }

  String _getSubtitle(AppLocalizations l10n) {
    switch (product.type) {
      case ProductType.creditCard:
        return l10n.availableCredit;
      case ProductType.investment:
        return l10n.marketValue;
      default:
        return l10n.availableBalance;
    }
  }

  IconData _getIcon() {
    switch (product.type) {
      case ProductType.savings:
        return Icons.savings_outlined;
      case ProductType.checking:
        return Icons.account_balance_outlined;
      case ProductType.creditCard:
        return Icons.credit_card_outlined;
      case ProductType.investment:
        return Icons.trending_up_outlined;
    }
  }

  LinearGradient _getGradient() {
    switch (product.type) {
      case ProductType.savings:
        return const LinearGradient(
          colors: [Color(0xFF1A73E8), Color(0xFF4FC3F7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case ProductType.checking:
        return const LinearGradient(
          colors: [Color(0xFF00897B), Color(0xFF4DB6AC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case ProductType.creditCard:
        return const LinearGradient(
          colors: [Color(0xFF7B1FA2), Color(0xFFBA68C8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case ProductType.investment:
        return const LinearGradient(
          colors: [Color(0xFFE65100), Color(0xFFFF8A65)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
  }
}
