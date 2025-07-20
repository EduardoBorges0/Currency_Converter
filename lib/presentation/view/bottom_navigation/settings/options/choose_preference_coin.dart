import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:u_coin/data/offline/preference_coin.dart';
import 'package:u_coin/domain/options/preference_coin_options.dart';

class ChoosePreferenceCoin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChoosePreferenceCoinState();
}

class _ChoosePreferenceCoinState extends State<ChoosePreferenceCoin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF141414),
      appBar: AppBar(
        title: const Text('Moedas'),
        foregroundColor: const Color(0xFFE0E0E0),
        backgroundColor: const Color(0xFF141414),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            ...List.generate(PreferenceCoinOptions.values.length, (i) {
              final preferenceCoins = PreferenceCoinOptions.values[i];
              return Column(
                children: [
                  ListTile(
                    leading: Text(
                      preferenceCoins.symbol,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    title: Text(
                      preferenceCoins.fullName,
                      style: const TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      PreferenceCoin().savePreferenceCoin(
                        preferenceCoins.code,
                        preferenceCoins.locale,
                        preferenceCoins.symbol,
                      );
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/main',
                        (Route<dynamic> route) => false,
                      );
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
