import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_coin/application/bloc/settings/settings_state.dart';
import 'package:u_coin/domain/options/settings_options.dart';

import '../../../../application/bloc/settings/settings_bloc.dart';
import '../../../../application/bloc/settings/settings_event.dart';

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF141414),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            const SizedBox(height: 20),
            BlocConsumer<SettingsBloc, SettingsState>(
              listener: (context, state) {
                if (state is SettingsSuccess) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',              // nova rota
                        (Route<dynamic> route) => false, // remove tudo que veio antes
                  );
                } else if (state is SettingsFailure) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.error)));
                }
              },
              builder: (context, state) {
                return Column(
                  children: List.generate(SettingsOptions.values.length, (i) {
                    final option = SettingsOptions.values[i];
                    return Column(
                      children: [
                        ListTile(
                          leading: Icon(option.icon, color: Colors.white),
                          title: Text(
                            option.title,
                            style: const TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            switch (option) {
                              case SettingsOptions.account:
                                Navigator.pushNamed(context, '/account');
                                break;
                              case SettingsOptions.about:
                                Navigator.pushNamed(context, '/about');
                                break;
                              case SettingsOptions.logout:
                                context.read<SettingsBloc>().add(LogoutEvent());
                                break;
                              case SettingsOptions.language:
                                Navigator.pushNamed(context, '/settings/choose_preference');
                            }
                          },
                        ),
                        const Divider(color: Colors.grey),
                      ],
                    );
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
