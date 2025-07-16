
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/bloc/authentication_bloc.dart';
import '../../../application/bloc/authentication_state.dart';

class FormView extends StatefulWidget {
  const FormView({super.key, required this.onSubmit});
  final Function(String email, String password) onSubmit;

  @override
  State<FormView> createState() => _FormView(onSubmit: onSubmit);
}
class _FormView extends State<FormView>{
  final Function(String email, String password) onSubmit;
  _FormView({required this.onSubmit});
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Registro realizado!')),
                    );
                    Navigator.pushReplacementNamed(context, '/main');
                  } else if (state is AuthFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
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
                          onSubmit(email, password),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.black),
                        shadowColor: MaterialStateProperty.all(Colors.grey),
                        elevation: MaterialStateProperty.all(8),
                        minimumSize: MaterialStateProperty.all(const Size(200, 50)),
                      ),
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

}