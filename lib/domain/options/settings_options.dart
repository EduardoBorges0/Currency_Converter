import 'package:flutter/material.dart';

enum SettingsOptions {
  account(
    icon: Icons.account_circle,
    title: 'Conta',
  ),
  language(
    icon: Icons.monetization_on,
    title: 'Moeda',
  ),
  about(
    icon: Icons.info,
    title: 'Sobre',
  ),
  logout(
    icon: Icons.logout,
    title: 'Sair',
  );

  final IconData icon;
  final String title;

  const SettingsOptions({
    required this.icon,
    required this.title,
  });
}
