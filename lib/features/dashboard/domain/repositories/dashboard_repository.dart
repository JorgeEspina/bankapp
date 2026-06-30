import '../entities/financial_product_entity.dart';

abstract class DashboardRepository {
  Future<List<FinancialProductEntity>> getProducts();
  Future<List<FinancialProductEntity>?> getCachedProducts();
  Future<void> cacheProducts(List<FinancialProductEntity> products);
  Future<void> clearCache();
}
