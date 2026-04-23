import 'package:fluter_test_luis1/features/login/data/repositories/authentication_repository_impl.dart';
import 'package:fluter_test_luis1/features/login/domain/repositories/authentication_repository.dart';

class IsLoggeedUseCase {
  final AuthenticationRepository _authenticationRepository;

  IsLoggeedUseCase({AuthenticationRepository? authenticationRepository})
    : _authenticationRepository =
          authenticationRepository ?? AuthenticationRepositoryImpl();

  Future<bool> call() async {
    return _authenticationRepository.isSignedIn();
  }
}