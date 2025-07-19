import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_coin/application/bloc/settings/settings_bloc.dart';
import 'package:u_coin/application/bloc/settings/settings_event.dart';
import 'package:u_coin/application/bloc/settings/settings_state.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});

  final email =
      FirebaseAuth.instance.currentUser?.email ?? 'Usuário não autenticado';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: AppBar(
        title: const Text('Account'),
        foregroundColor: const Color(0xFFE0E0E0),
        backgroundColor: const Color(0xFF141414),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.email, color: Colors.grey),
              title: Text(email, style: const TextStyle(color: Colors.grey)),
              onTap: () {},
            ),
            const Divider(color: Colors.grey),
            BlocConsumer<SettingsBloc, SettingsState>(
              builder: (context, state) {
                return ListTile(
                  leading: Icon(Icons.delete_outline, color: Colors.red),
                  title: Text(
                    "Deletar conta",
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () {
                    final passwordController = TextEditingController();
                    final settingsBloc = context.read<SettingsBloc>();

                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Confirmar Exclusão'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Digite sua senha para excluir sua conta:'),
                            const SizedBox(height: 8),
                            TextField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'Senha',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            child: const Text('Cancelar'),
                            onPressed: () => Navigator.pop(context),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                            child: const Text('Confirmar'),
                            onPressed: () {
                              final senha = passwordController.text;
                              Navigator.pop(context); // fecha o dialog
                              settingsBloc.add(RemoveAccountEvent(email: email, password: senha));
                            },
                          ),
                        ],
                      ),
                    );
                  },

                );
              },
              listener: (context, state) {
                if (state is SettingsSuccess) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                        (Route<dynamic> route) => false, // remove tudo que veio antes
                  );
                } else if (state is SettingsFailure) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.error)));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
