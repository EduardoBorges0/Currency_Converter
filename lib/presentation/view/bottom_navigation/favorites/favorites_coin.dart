
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_coin/application/bloc/favorite/favorite_coin_event.dart';
import 'package:u_coin/application/bloc/favorite/favorite_coin_state.dart';
import 'package:u_coin/presentation/view/bottom_navigation/currency/currency_coin_component.dart';

import '../../../../application/bloc/favorite/favorite_coin_bloc.dart';
import '../../../../data/network/firebase/save_favorite_coin_firestore.dart';
import '../../../../data/repositoriesImpl/crypto_repositories_impl.dart';
import '../../../../domain/options/cryptos.dart';

class FavoritesCoin extends StatelessWidget {
  FavoritesCoin({super.key});

  final cryptoRepository = CryptoRepositoriesImpl();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavoriteCoinBloc(cryptoRepository),
      child: const FavoritesCoinView(),
    );
  }
}

class FavoritesCoinView extends StatelessWidget {
  const FavoritesCoinView({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    return FutureBuilder<List<String>>(
      future: getUserFavorites(userId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final favoriteCoins = snapshot.data!;
        final cryptoFavorites = Cryptos.values.where(
              (c) => favoriteCoins.contains(c.fullName),
        ).toList();
        return ListView.builder(
          padding: const EdgeInsets.only(top: 20),
          itemCount: cryptoFavorites.length,
          itemBuilder: (context, i) {
            final crypto = cryptoFavorites[i];
            print('Crypto: ${crypto.fullName}');
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: CurrencyCoinComponent(crypto: crypto, i: i),
            );
          },
        );
      },
    );
  }
}
