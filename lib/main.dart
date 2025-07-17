import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:u_coin/data/network/crypto_network/crypto_network.dart';
import 'package:u_coin/presentation/view/auth/authentication_screen.dart';
import 'package:u_coin/presentation/view/auth/register_screen.dart';
import 'package:u_coin/presentation/view/currency/currency_coin.dart';
import 'data/repositoriesImpl/authentication_repositories_impl.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  CryptoNetwork("usd");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login': (context) => AuthenticationScreen(),
        '/register': (context) => RegisterScreen(),
        '/main': (context) => CurrencyCoin(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:
          FirebaseAuth.instance.currentUser?.uid != null
              ? CurrencyCoin()
              : AuthenticationScreen(),
    );
  }
}
