import 'package:fluter_test_luis1/core/dependencies.dart';
import 'package:fluter_test_luis1/features/dashboard/data/data_sources/local_logout_datasource.dart';
import 'package:fluter_test_luis1/features/dashboard/domain/repositories/logout_repository.dart';

class LogoutRepositoryImpl extends LogoutRepository {
  final LocalLogoutDatasource _localLogoutDatasource;

  LogoutRepositoryImpl({LocalLogoutDatasource? localLogoutDatasource})
    : _localLogoutDatasource =
          localLogoutDatasource ?? getIt<LocalLogoutDatasource>();

  @override
  Future<void> logOut() async {
    await _localLogoutDatasource.clearSession();
  }
}