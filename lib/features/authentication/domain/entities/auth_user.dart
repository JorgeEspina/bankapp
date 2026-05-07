import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user.freezed.dart';

@freezed
class AuthUser with _$AuthUser {
  const factory AuthUser({
    required int id,
    required String username,
    required String email,
    required String firstName,
    required String lastName,
    required String accessToken,
    required String refreshToken,
  }) = _AuthUser;
}