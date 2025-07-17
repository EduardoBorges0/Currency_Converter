import 'package:flutter/material.dart';
import 'package:u_coin/domain/options/cryptos.dart';

import '../bottom_navigation/bottom_navigation.dart';

class CurrencyCoin extends StatefulWidget {
  @override
  _CurrencyCoinState createState() => _CurrencyCoinState();
}

class _CurrencyCoinState extends State<CurrencyCoin> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    // Agora tem 3 itens, para cada aba do BottomNavigationBar
    Text('Início', style: TextStyle(fontSize: 30, color: Colors.white)),
    Text('Favoritos', style: TextStyle(fontSize: 30, color: Colors.white)),
    Text('Configurações', style: TextStyle(fontSize: 30, color: Colors.white)),
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
      body: _selectedIndex == 0
          ? ListView.builder(
        padding: const EdgeInsets.only(top: 20),
        itemCount: Cryptos.values.length,
        itemBuilder: (context, i) {
          final crypto = Cryptos.values[i];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/${crypto.name}.png',
                      height: 40,
                      width: 40,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        crypto.fullName,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                if (i != Cryptos.values.length - 1)
                  const Divider(color: Colors.grey),
              ],
            ),
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
