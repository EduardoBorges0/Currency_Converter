import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRepositories {
  Future<bool> registerUser({
    required String email,
    required String password,
  });

  Future<User?> loginUser({
    required String email,
    required String password,
  });
}