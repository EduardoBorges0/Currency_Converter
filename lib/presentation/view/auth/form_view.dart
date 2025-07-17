import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/bloc/authentication_bloc.dart';
import '../../../application/bloc/authentication_state.dart';

class FormView extends StatefulWidget {
  const FormView({
    super.key,
    required this.onSubmit,
    required this.authOrRegister,
  });

  final Function(String email, String password) onSubmit;
  final String authOrRegister;

  @override
  State<FormView> createState() => _FormView();
}

class _FormView extends State<FormView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                cursorColor: Colors.black,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: _obscureText,
                cursorColor: Colors.black,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: _toggleVisibility,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              BlocConsumer<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    Navigator.pushReplacementNamed(context, '/main');
                  } else if (state is AuthFailure) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.error)));
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const CircularProgressIndicator();
                  }
                  return SizedBox(
                    width: 350,
                    height: 60,
                    child: FilledButton(
                      onPressed: () {
                        final email = _emailController.text.trim();
                        final password = _passwordController.text.trim();
                        context.read<AuthenticationBloc>().add(
                          widget.onSubmit(email, password),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.black),
                        shadowColor: MaterialStateProperty.all(Colors.grey),
                        elevation: MaterialStateProperty.all(8),
                        minimumSize:
                        MaterialStateProperty.all(const Size(200, 50)),
                      ),
                      child: Text(
                        widget.authOrRegister == 'Auth' ? 'Login' : 'Cadastrar',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => {
                  if(widget.authOrRegister == 'Auth') {
                    Navigator.pushReplacementNamed(context, '/register')
                  } else {
                    Navigator.pushReplacementNamed(context, '/login')
                  }
                },
                child: Text(widget.authOrRegister == 'Auth'
                    ? 'Não tem uma conta? Cadastre-se'
                    : 'Já tem uma conta? Faça login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
