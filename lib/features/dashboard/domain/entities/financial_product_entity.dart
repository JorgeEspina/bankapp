enum ProductType {
  savings,
  checking,
  creditCard,
  investment,
}

class FinancialProductEntity {
  final String id;
  final String name;
  final String number;
  final double balance;
  final ProductType type;
  final String currency;
  final DateTime lastUpdated;

  const FinancialProductEntity({
    required this.id,
    required this.name,
    required this.number,
    required this.balance,
    required this.type,
    this.currency = 'USD',
    required this.lastUpdated,
  });
}
