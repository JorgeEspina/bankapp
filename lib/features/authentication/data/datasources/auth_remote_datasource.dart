import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/auth_user.dart';

abstract class AuthRemoteDataSource {
  Future<AuthUser> login({
    required String email,
    required String password,
  });

  Future<AuthUser> register({
    required String email,
    required String password,
  });

  Future<void> logout();

  bool isLoggedIn();

  AuthUser? getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _auth;

  AuthRemoteDataSourceImpl({FirebaseAuth? auth})
      : _auth = auth ?? FirebaseAuth.instance;

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _mapUserCredential(credential);
  }

  @override
  Future<AuthUser> register({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _mapUserCredential(credential);
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
  }

  @override
  bool isLoggedIn() {
    return _auth.currentUser != null;
  }

  @override
  AuthUser? getCurrentUser() {
    final user = _auth.currentUser;
    if (user == null) return null;
    return AuthUser(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName ?? '',
    );
  }

  AuthUser _mapUserCredential(UserCredential credential) {
    final user = credential.user!;
    return AuthUser(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName ?? '',
    );
  }
}
