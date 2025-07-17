import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_coin/application/bloc/authentication_event.dart';
import 'package:u_coin/presentation/view/auth/form_view.dart';

import '../../../application/bloc/authentication_bloc.dart';
import '../../../data/repositoriesImpl/authentication_repositories_impl.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(AuthenticationRepositoriesImpl()),
      child: const LoginForm(),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return FormView(
      authOrRegister: 'Auth',
      onSubmit: (email, password) => LoginUserEvent(email: email, password: password),
    );
  }
}
