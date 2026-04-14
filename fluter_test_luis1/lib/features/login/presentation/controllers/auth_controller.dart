class AuthController {
  Future<bool> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    if (username == "admin" && password == "1234") {
      return true;
    }

    return false;
  }
}