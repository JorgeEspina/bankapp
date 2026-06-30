import '../../domain/entities/financial_product_entity.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../data_sources/dashboard_local_data_source.dart';
import '../data_sources/dashboard_remote_data_source.dart';
import '../models/financial_product_model.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;
  final DashboardLocalDataSource localDataSource;

  const DashboardRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<FinancialProductEntity>> getProducts() async {
    try {
      final models = await remoteDataSource.getProducts();
      // Guardar en cache
      await localDataSource.cacheProducts(models);
      return models.map((m) => m.toEntity()).toList();
    } catch (e) {
      // Intentar desde cache
      final cached = await localDataSource.getCachedProducts();
      if (cached != null && cached.isNotEmpty) {
        return cached.map((m) => m.toEntity()).toList();
      }
      rethrow;
    }
  }

  @override
  Future<List<FinancialProductEntity>?> getCachedProducts() async {
    final cached = await localDataSource.getCachedProducts();
    return cached?.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> cacheProducts(List<FinancialProductEntity> products) async {
    final models =
        products.map((e) => FinancialProductModel.fromEntity(e)).toList();
    await localDataSource.cacheProducts(models);
  }

  @override
  Future<void> clearCache() async {
    await localDataSource.clearCache();
  }
}
