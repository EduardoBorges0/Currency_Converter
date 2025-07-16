import 'package:u_coin/domain/repositories/authentication_repositories.dart';

class AuthenticationViewModel{
  final AuthenticationRepositories authAndRegisterRepositories;
  AuthenticationViewModel({required this.authAndRegisterRepositories});

  void registerUser({
    required String email,
    required String password,
  }) {
    authAndRegisterRepositories.registerUser(
      email: email,
      password: password,
    );
  }
  void loginUser({
    required String email,
    required String password,
  }) {
    authAndRegisterRepositories.loginUser(
      email: email,
      password: password,
    );
  }
  
}