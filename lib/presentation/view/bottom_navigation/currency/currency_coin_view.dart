import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_coin/application/bloc/favorite/favorite_coin_bloc.dart';
import 'package:u_coin/application/bloc/favorite/favorite_coin_event.dart';
import 'package:u_coin/application/bloc/favorite/favorite_coin_state.dart';
import 'package:u_coin/data/network/firebase/save_favorite_coin_firestore.dart';
import 'package:u_coin/domain/options/cryptos.dart';
import '../bottom_navigation.dart';
import '../favorites/favorites_coin.dart';
import '../settings/settings.dart';
import 'currency_coin_component.dart';

class CurrencyCoin extends StatefulWidget {
  @override
  _CurrencyCoinState createState() => _CurrencyCoinState();
}

class _CurrencyCoinState extends State<CurrencyCoin> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    // Agora tem 3 itens, para cada aba do BottomNavigationBar
    Text('Início', style: TextStyle(fontSize: 30, color: Colors.white)),
    FavoritesCoin(),
    Settings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF141414),
      appBar: AppBar(
        title: Text('Criptomoedas'),
        backgroundColor: Color(0xFF141414),
        foregroundColor: Color(0xFFE0E0E0),
      ),
      body:
          _selectedIndex == 0
              ? ListView.builder(
                padding: const EdgeInsets.only(top: 20),
                itemCount: Cryptos.values.length,
                itemBuilder: (context, i) {
                  final crypto = Cryptos.values[i];

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: CurrencyCoinComponent(crypto: crypto, i: i),
                  );
                },
              )
              : Center(child: _pages[_selectedIndex]),

      bottomNavigationBar: BottomNavigation(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
