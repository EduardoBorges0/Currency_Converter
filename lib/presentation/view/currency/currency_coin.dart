import 'package:flutter/cupertino.dart';

class CurrencyCoin extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Currency Coin',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}