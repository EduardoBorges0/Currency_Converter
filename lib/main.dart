import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:u_coin/presentation/view/auth/authentication_screen.dart';
import 'package:u_coin/presentation/view/auth/register_screen.dart';
import 'package:u_coin/presentation/view/currency/currency_coin.dart';
import 'package:u_coin/presentation/viewModel/authentication_view_model.dart';

import 'data/repositoriesImpl/authentication_repositories_impl.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Cria o repositório e viewmodel
  final authRepository = AuthenticationRepositoriesImpl();
  final authViewModel = AuthenticationViewModel(
    authAndRegisterRepositories: authRepository,
  );

  runApp(MyApp(authViewModel: authViewModel));
}

class MyApp extends StatelessWidget {
  final AuthenticationViewModel authViewModel;

  const MyApp({super.key, required this.authViewModel});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login':
            (context) =>
                AuthenticationScreen(),
        '/register': (context) =>
            RegisterScreen(),
        '/main': (context) =>
            CurrencyCoin(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: AuthenticationScreen()
    );
  }
}
