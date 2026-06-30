import '../models/financial_product_model.dart';

/// Datasource remoto simulado con datos mock.
class DashboardRemoteDataSource {
  Future<List<FinancialProductModel>> getProducts() async {
    await Future.delayed(const Duration(milliseconds: 100));

    return _mockProducts;
  }

  static final List<FinancialProductModel> _mockProducts = [
    FinancialProductModel(
      id: '1',
      name: 'Cuenta de Ahorros',
      number: '****1234',
      balance: 15250.75,
      type: 'savings',
      currency: 'USD',
      lastUpdated: DateTime.now().toIso8601String(),
    ),
    FinancialProductModel(
      id: '2',
      name: 'Cuenta Corriente',
      number: '****5678',
      balance: 3420.00,
      type: 'checking',
      currency: 'USD',
      lastUpdated: DateTime.now().toIso8601String(),
    ),
    FinancialProductModel(
      id: '3',
      name: 'Tarjeta Visa Platinum',
      number: '****9012',
      balance: 2800.50,
      type: 'creditCard',
      currency: 'USD',
      lastUpdated: DateTime.now().toIso8601String(),
    ),
    FinancialProductModel(
      id: '4',
      name: 'Fondo Inversión Plus',
      number: '****3456',
      balance: 48000.00,
      type: 'investment',
      currency: 'USD',
      lastUpdated: DateTime.now().toIso8601String(),
    ),
    FinancialProductModel(
      id: '5',
      name: 'Tarjeta Mastercard Gold',
      number: '****7890',
      balance: 1500.25,
      type: 'creditCard',
      currency: 'USD',
      lastUpdated: DateTime.now().toIso8601String(),
    ),
  ];
}
