import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_coin/application/bloc/authentication_bloc.dart';
import 'package:u_coin/application/bloc/authentication_event.dart';
import 'package:u_coin/data/repositoriesImpl/authentication_repositories_impl.dart';
import 'package:u_coin/domain/repositories/authentication_repositories.dart';
import 'package:u_coin/presentation/view/auth/form_view.dart';

import '../../../application/bloc/authentication_state.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(AuthenticationRepositoriesImpl()),
      child: const RegisterForm(),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  @override
  Widget build(BuildContext context) {
    return FormView(
      authOrRegister: 'Register',
      onSubmit:
          (email, password) => RegisterUserEvent(email: email, password: password),
    );
  }
}
