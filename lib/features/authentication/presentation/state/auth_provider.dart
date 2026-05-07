import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/auth_local_datasource.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import 'auth_state.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthRemoteDataSourceImpl(dio);
});

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  return AuthLocalDataSourceImpl();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remote = ref.watch(authRemoteDataSourceProvider);
  final local = ref.watch(authLocalDataSourceProvider);

  return AuthRepositoryImpl(
    remoteDataSource: remote,
    localDataSource: local,
  );
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LoginUseCase(repository);
});

final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LogoutUseCase(repository);
});

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final loginUseCase = ref.watch(loginUseCaseProvider);
  final logoutUseCase = ref.watch(logoutUseCaseProvider);
  final repository = ref.watch(authRepositoryProvider);

  return AuthNotifier(
    loginUseCase: loginUseCase,
    logoutUseCase: logoutUseCase,
    repository: repository,
  );
});

class AuthNotifier extends StateNotifier<AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final AuthRepository repository;

  AuthNotifier({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.repository,
  }) : super(const AuthState.initial()) {
    checkSession();
  }

  Future<void> checkSession() async {
    final isLogged = await repository.isLoggedIn();

    if (isLogged) {
      state = const AuthState.initial();
    } else {
      state = const AuthState.unauthenticated();
    }
  }

  Future<void> login({
    required String username,
    required String password,
  }) async {
    try {
      state = const AuthState.loading();

      final user = await loginUseCase(
        username: username,
        password: password,
      );

      print('Login exitoso');
      print('Usuario: ${user.username}');
      print('Token: ${user.accessToken}');

      state = AuthState.authenticated(user);
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'Error al iniciar sesión';
      state = AuthState.error(message);
    } catch (_) {
      state = const AuthState.error('Ocurrió un error inesperado');
    }
  }

  Future<void> logout() async {
    await logoutUseCase();
    state = const AuthState.unauthenticated();
  }

  Future<bool> isLoggedIn() async {
    return repository.isLoggedIn();
  }
}