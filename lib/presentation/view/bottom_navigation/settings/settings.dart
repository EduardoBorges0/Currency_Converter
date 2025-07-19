import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:u_coin/domain/options/settings_options.dart';

class Settings extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => SettingsState();
}
class SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF141414),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            const SizedBox(height: 20),
            ...List.generate(SettingsOptions.values.length, (i) {
              final option = SettingsOptions.values[i];
              return Column(
                children: [
                  ListTile(
                    leading: Icon(option.icon, color: Colors.white),
                    title: Text(option.title, style: const TextStyle(color: Colors.white)),
                    onTap: () {
                      switch (option) {
                        case SettingsOptions.account:
                          Navigator.pushNamed(context, '/account');
                          break;
                        case SettingsOptions.about:
                          Navigator.pushNamed(context, '/about');
                          break;
                        case SettingsOptions.logout:
                          FirebaseAuth.instance.signOut().then((_) {
                            Navigator.pushReplacementNamed(context, '/login');
                          }).catchError((error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Erro ao sair: $error')),
                            );
                          });
                          break;
                      }
                    },
                  ),
                  const Divider(color: Colors.grey),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}