import 'package:firebase_auth/firebase_auth.dart';

Future<User?> register(String email, String password) async {
  final userCredential = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email, password: password);
  return userCredential.user;
}

Future<User?> auth(String email, String password) async {
  final userCredential = await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password);
  return userCredential.user;
}
