import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_coin/application/bloc/auth/authentication_event.dart';

import '../../../application/bloc/auth/authentication_bloc.dart';
import '../../../application/bloc/auth/authentication_state.dart';
import '../common/widget/text_field_widget.dart';

class FormView extends StatefulWidget {
  const FormView({
    super.key,
    required this.onSubmit,
    required this.authOrRegister,
  });

  final AuthenticationEvent Function(String email, String password) onSubmit;
  final String authOrRegister;

  @override
  State<FormView> createState() => _FormView();
}

class _FormView extends State<FormView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF141414),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: SingleChildScrollView(
            child: Column(
            children: [
              const SizedBox(height: 30),
              Image.asset(
                'assets/logo_app.png'
              ),
              TextFieldWidget(
                controller: _emailController,
                hintText: 'Email',
                isPasswordField: false,
              ),
              const SizedBox(height: 20),
              TextFieldWidget(
                controller: _passwordController,
                hintText: 'Password',
                isPasswordField: true,
              ),

              const SizedBox(height: 20),
              BlocConsumer<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    Navigator.pushReplacementNamed(context, '/main');
                  } else if (state is AuthFailure) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.error)));
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const CircularProgressIndicator(color: Colors.white);
                  }
                  return SizedBox(
                    width: 350,
                    height: 60,
                    child: FilledButton(
                      onPressed: () {
                        final email = _emailController.text.trim();
                        final password = _passwordController.text.trim();
                        final event = widget.onSubmit(email, password);
                        context.read<AuthenticationBloc>().add(event);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.white,
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        shadowColor: MaterialStateProperty.all(Colors.grey),
                        elevation: MaterialStateProperty.all(8),
                        minimumSize: MaterialStateProperty.all(
                          const Size(200, 50),
                        ),
                      ),
                      child: Text(
                        widget.authOrRegister == 'Auth' ? 'Login' : 'Cadastrar',
                        style: const TextStyle(color: Colors.black45),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed:
                    () => {
                      if (widget.authOrRegister == 'Auth')
                        {Navigator.pushReplacementNamed(context, '/register')}
                      else
                        {Navigator.pushReplacementNamed(context, '/login')},
                    },
                child: Text(
                  widget.authOrRegister == 'Auth'
                      ? 'Não tem uma conta? Cadastre-se'
                      : 'Já tem uma conta? Faça login',
                ),
              ),

            ],

          ),
        ),
      )
    );
  }
}
