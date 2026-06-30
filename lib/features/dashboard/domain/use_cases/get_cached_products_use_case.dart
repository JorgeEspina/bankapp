import '../entities/financial_product_entity.dart';
import '../repositories/dashboard_repository.dart';

class GetCachedProductsUseCase {
  final DashboardRepository repository;

  const GetCachedProductsUseCase({required this.repository});

  Future<List<FinancialProductEntity>?> call() {
    return repository.getCachedProducts();
  }
}
