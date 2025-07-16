abstract class AuthenticationRepositories {
  Future<bool> registerUser({
    required String email,
    required String password,
  });

  Future<bool> loginUser({
    required String email,
    required String password,
  });

  Future<bool> logoutUser();

  Future<bool> isLoggedIn();

  Future<String?> getCurrentUserId();
}