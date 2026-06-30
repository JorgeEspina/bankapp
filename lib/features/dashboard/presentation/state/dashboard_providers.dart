import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/data_sources/dashboard_local_data_source.dart';
import '../../data/data_sources/dashboard_remote_data_source.dart';
import '../../data/repositories/dashboard_repository_impl.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../../domain/use_cases/get_cached_products_use_case.dart';
import '../../domain/use_cases/get_products_use_case.dart';
import 'dashboard_controller.dart';
import 'dashboard_state.dart';

// Data Sources
final dashboardRemoteDataSourceProvider = Provider<DashboardRemoteDataSource>(
  (ref) => DashboardRemoteDataSource(),
);

final dashboardLocalDataSourceProvider = Provider<DashboardLocalDataSource>(
  (ref) => DashboardLocalDataSource(),
);

// Repositories
final dashboardRepositoryProvider = Provider<DashboardRepository>(
  (ref) => DashboardRepositoryImpl(
    remoteDataSource: ref.read(dashboardRemoteDataSourceProvider),
    localDataSource: ref.read(dashboardLocalDataSourceProvider),
  ),
);

// Use Cases
final getProductsUseCaseProvider = Provider<GetProductsUseCase>(
  (ref) => GetProductsUseCase(
    repository: ref.read(dashboardRepositoryProvider),
  ),
);

final getCachedProductsUseCaseProvider = Provider<GetCachedProductsUseCase>(
  (ref) => GetCachedProductsUseCase(
    repository: ref.read(dashboardRepositoryProvider),
  ),
);

// Controller
final dashboardControllerProvider =
    NotifierProvider<DashboardController, DashboardState>(
  DashboardController.new,
);
