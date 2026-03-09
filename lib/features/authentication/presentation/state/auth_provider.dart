import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());

  Future<void> login(String email, String password) async {

    state = state.copyWith(isLoading: true);

    await Future.delayed(const Duration(seconds: 2));

    state = state.copyWith(isLoading: false);
  }
}

class AuthState {
  final bool isLoading;

  AuthState({this.isLoading = false});

  AuthState copyWith({bool? isLoading}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}