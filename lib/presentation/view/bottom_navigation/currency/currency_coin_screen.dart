import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_coin/application/bloc/crypto/crypto_state.dart';
import 'package:u_coin/application/bloc/favorite/favorite_coin_bloc.dart';
import 'package:u_coin/application/bloc/favorite/favorite_coin_event.dart';
import 'package:u_coin/application/bloc/favorite/favorite_coin_state.dart';
import 'package:u_coin/application/bloc/settings/settings_bloc.dart';
import 'package:u_coin/data/network/firebase/save_favorite_coin_firestore.dart';
import 'package:u_coin/data/offline/preference_coin.dart';
import 'package:u_coin/domain/options/cryptos.dart';
import '../../../../application/bloc/crypto/crypto_bloc.dart';
import '../../../../application/bloc/crypto/crypto_event.dart';
import '../../../../data/model/crypto_model.dart';
import '../bottom_navigation.dart';
import '../favorites/favorites_coin_screen.dart';
import '../settings/settings_screen.dart';
import '../common/widget/currency_coin_view.dart';

class CurrencyCoinScreen extends StatefulWidget {
  @override
  _CurrencyCoinState createState() => _CurrencyCoinState();
}

class _CurrencyCoinState extends State<CurrencyCoinScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    Text('Início', style: TextStyle(fontSize: 30, color: Colors.white)),
    FavoritesCoinScreen(),
    BlocProvider(create: (_) => SettingsBloc(), child: SettingScreen()),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<CryptoBloc>().add(
      FetchCryptoEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: AppBar(
        title: const Text('Criptomoedas'),
        backgroundColor: const Color(0xFF141414),
        foregroundColor: const Color(0xFFE0E0E0),
      ),
      body: _selectedIndex == 0
          ? BlocBuilder<CryptoBloc, CryptoState>(
        builder: (context, state) {
          if (state is CryptoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CryptoSuccess<List<CryptoModel>>) {
            final cryptosList = state.data;
            return ListView.builder(
              padding: const EdgeInsets.only(top: 20),
              itemCount: Cryptos.values.length,
              itemBuilder: (context, i) {
                final crypto = Cryptos.sortedByName[i];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: CurrencyCoinView(
                    crypto: crypto,
                    i: i,
                    price: cryptosList[i].price,
                  ),
                );
              },
            );
          } else if (state is CryptoFailure) {
            return const Center(child: Text("Erro ao carregar moedas", style: TextStyle(color: Colors.red)));
          } else {
            return const SizedBox.shrink();
          }
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
