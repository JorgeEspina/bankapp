import '../../domain/entities/financial_product_entity.dart';

class DashboardState {
  const DashboardState({
    this.products = const [],
    this.isLoading = false,
    this.error,
    this.isFromCache = false,
  });

  final List<FinancialProductEntity> products;
  final bool isLoading;
  final String? error;
  final bool isFromCache;

  double get totalBalance =>
      products.fold(0.0, (sum, p) => sum + p.balance);

  int get productCount => products.length;

  List<FinancialProductEntity> get accounts => products
      .where((p) =>
          p.type == ProductType.savings || p.type == ProductType.checking)
      .toList();

  List<FinancialProductEntity> get creditCards =>
      products.where((p) => p.type == ProductType.creditCard).toList();

  List<FinancialProductEntity> get investments =>
      products.where((p) => p.type == ProductType.investment).toList();

  DashboardState copyWith({
    List<FinancialProductEntity>? products,
    bool? isLoading,
    String? error,
    bool? isFromCache,
  }) {
    return DashboardState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isFromCache: isFromCache ?? this.isFromCache,
    );
  }
}
