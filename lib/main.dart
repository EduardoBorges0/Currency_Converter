import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_coin/data/network/crypto_network/crypto_network.dart';
import 'package:u_coin/data/network/firebase/save_favorite_coin_firestore.dart';
import 'package:u_coin/presentation/view/auth/authentication_screen.dart';
import 'package:u_coin/presentation/view/auth/register_screen.dart';
import 'package:u_coin/presentation/view/currency/currency_coin.dart';
import 'application/bloc/favorite/favorite_coin_bloc.dart';
import 'data/repositoriesImpl/authentication_repositories_impl.dart';
import 'data/repositoriesImpl/crypto_repositories_impl.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // saveFavoriteCoinFirestore(
  //   FirebaseAuth.instance.currentUser!.uid,
  //   {
  //     'name': 'bitcoin',
  //     'symbol': 'btc',
  //   },
  // );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final cryptoRepository = CryptoRepositoriesImpl();

    return MaterialApp(
      routes: {
        '/login': (context) => AuthenticationScreen(),
        '/register': (context) => RegisterScreen(),
        '/main': (context) => BlocProvider(
          create: (_) => FavoriteCoinBloc(cryptoRepository),
          child: CurrencyCoin(),
        ),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: FirebaseAuth.instance.currentUser?.uid != null
          ? BlocProvider(
        create: (_) => FavoriteCoinBloc(cryptoRepository),
        child: CurrencyCoin(),
      )
          : AuthenticationScreen(),
    );
  }
}
