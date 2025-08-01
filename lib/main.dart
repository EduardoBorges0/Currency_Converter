import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_coin/application/bloc/crypto/crypto_bloc.dart';
import 'package:u_coin/application/bloc/settings/settings_bloc.dart';
import 'package:u_coin/data/network/crypto_network/crypto_network.dart';
import 'package:u_coin/data/network/firebase/save_favorite_coin_firestore.dart';
import 'package:u_coin/presentation/view/auth/authentication_screen.dart';
import 'package:u_coin/presentation/view/auth/register_screen.dart';
import 'package:u_coin/presentation/view/bottom_navigation/currency/currency_coin_screen.dart';
import 'package:u_coin/presentation/view/bottom_navigation/settings/options/account_screen.dart';
import 'package:u_coin/presentation/view/bottom_navigation/settings/options/choose_preference_coin.dart';
import 'application/bloc/favorite/favorite_coin_bloc.dart';
import 'data/repositoriesImpl/authentication_repositories_impl.dart';
import 'data/repositoriesImpl/crypto_repositories_impl.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        '/settings/choose_preference': (context) => ChoosePreferenceCoin(),
        '/account':
            (context) => BlocProvider(
              create: (_) => SettingsBloc(),
              child: AccountScreen(),
            ),
        '/main': (context) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => FavoriteCoinBloc(cryptoRepository)),
            BlocProvider(create: (_) => CryptoBloc()),
          ],
          child: CurrencyCoinScreen(),
        ),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:
          FirebaseAuth.instance.currentUser?.uid != null
              ? MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => FavoriteCoinBloc(cryptoRepository)),
              BlocProvider(create: (_) => CryptoBloc())
            ],
                child: CurrencyCoinScreen(),
              )
              : AuthenticationScreen(),
    );
  }
}
