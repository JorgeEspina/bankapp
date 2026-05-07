import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/auth_response_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<AuthUser> login({
    required String username,
    required String password,
  }) async {
    final response = await remoteDataSource.login(
      username: username,
      password: password,
    );

    await localDataSource.saveToken(response.accessToken);

    return response.toEntity();
  }

  @override
  Future<void> logout() async {
    await localDataSource.clearSession();
  }

  @override
  Future<bool> isLoggedIn() async {
    return localDataSource.hasValidToken();
  }
}