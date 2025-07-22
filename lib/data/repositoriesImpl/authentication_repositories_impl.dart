import 'package:firebase_auth/firebase_auth.dart';
import 'package:u_coin/domain/repositories/authentication_repositories.dart';

import '../network/firebase/authentication_firebase_auth.dart' as AuthAndRegisterCloud;

class AuthenticationRepositoriesImpl extends AuthenticationRepositories {
  @override
  Future<User?> loginUser({required String email, required String password}) {
    return AuthAndRegisterCloud.auth(email, password);
  }
  @override
  Future<bool> logoutUser() {
    // TODO: implement logoutUser
    throw UnimplementedError();
  }

  @override
  Future<bool> registerUser({required String email, required String password}) {
    return AuthAndRegisterCloud.register(email, password)
        .then((user) {
          if (user != null) {
            return true; // Registration successful
          } else {
            return false; // Registration failed
          }
        })
        .catchError((error) {
          print("Registration error: $error");
          return false; // Handle error and return false
        });
  }

}