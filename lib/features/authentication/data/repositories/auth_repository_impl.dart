import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) async {
    return remoteDataSource.login(email: email, password: password);
  }

  @override
  Future<AuthUser> register({
    required String email,
    required String password,
  }) async {
    return remoteDataSource.register(email: email, password: password);
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
  }

  @override
  bool isLoggedIn() {
    return remoteDataSource.isLoggedIn();
  }

  @override
  AuthUser? getCurrentUser() {
    return remoteDataSource.getCurrentUser();
  }
}
