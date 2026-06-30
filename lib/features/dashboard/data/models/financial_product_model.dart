import '../../domain/entities/financial_product_entity.dart';

class FinancialProductModel {
  final String id;
  final String name;
  final String number;
  final double balance;
  final String type;
  final String currency;
  final String lastUpdated;

  const FinancialProductModel({
    required this.id,
    required this.name,
    required this.number,
    required this.balance,
    required this.type,
    this.currency = 'USD',
    required this.lastUpdated,
  });

  factory FinancialProductModel.fromJson(Map<String, dynamic> json) {
    return FinancialProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      number: json['number'] as String,
      balance: (json['balance'] as num).toDouble(),
      type: json['type'] as String,
      currency: json['currency'] as String? ?? 'USD',
      lastUpdated: json['lastUpdated'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'number': number,
        'balance': balance,
        'type': type,
        'currency': currency,
        'lastUpdated': lastUpdated,
      };

  FinancialProductEntity toEntity() {
    return FinancialProductEntity(
      id: id,
      name: name,
      number: number,
      balance: balance,
      type: ProductType.values.firstWhere(
        (e) => e.name == type,
        orElse: () => ProductType.checking,
      ),
      currency: currency,
      lastUpdated: DateTime.tryParse(lastUpdated) ?? DateTime.now(),
    );
  }

  factory FinancialProductModel.fromEntity(FinancialProductEntity entity) {
    return FinancialProductModel(
      id: entity.id,
      name: entity.name,
      number: entity.number,
      balance: entity.balance,
      type: entity.type.name,
      currency: entity.currency,
      lastUpdated: entity.lastUpdated.toIso8601String(),
    );
  }
}
