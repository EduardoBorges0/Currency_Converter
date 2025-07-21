import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_coin/application/bloc/crypto/crypto_bloc.dart';
import 'package:u_coin/application/bloc/crypto/crypto_event.dart';
import 'package:u_coin/application/bloc/crypto/crypto_state.dart';
import 'package:u_coin/application/bloc/favorite/favorite_coin_bloc.dart';
import 'package:u_coin/data/model/crypto_model.dart';
import 'package:u_coin/data/network/firebase/save_favorite_coin_firestore.dart';
import 'package:u_coin/data/repositoriesImpl/crypto_repositories_impl.dart';
import 'package:u_coin/domain/options/cryptos.dart';

import '../../common/widget/currency_coin_view.dart';

class FavoritesCoinScreen extends StatelessWidget {
  FavoritesCoinScreen({super.key});

  final cryptoRepository = CryptoRepositoriesImpl();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FavoriteCoinBloc(cryptoRepository)),
        BlocProvider(
          create: (_) => CryptoBloc()..add(FetchCryptoEvent()), // Dispara evento aqui
        ),
      ],
      child: const FavoritesCoinView(),
    );
  }
}

class FavoritesCoinView extends StatefulWidget {
  const FavoritesCoinView({super.key});

  @override
  State<FavoritesCoinView> createState() => _FavoritesCoinViewState();
}

class _FavoritesCoinViewState extends State<FavoritesCoinView> {
  late final String userId;

  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: getUserFavorites(userId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final favoriteCoins = snapshot.data!;
        final cryptoFavorites = Cryptos.values
            .where((c) => favoriteCoins.contains(c.fullName))
            .toList();

        final cryptoState = context.watch<CryptoBloc>().state;

        if (cryptoState is! CryptoSuccess<List<CryptoModel>>) {
          return const Center(child: CircularProgressIndicator(color: Colors.white));
        }

        final cryptosList = cryptoState.data;

        return ListView.builder(
          padding: const EdgeInsets.only(top: 20),
          itemCount: cryptoFavorites.length,
          itemBuilder: (context, i) {
            final crypto = cryptoFavorites[i];
            final match = cryptosList.firstWhere(
                  (c) => c.name.toLowerCase() == crypto.fullName.toLowerCase(),
              orElse: () => CryptoModel(name: crypto.fullName, price: 0),
            );

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: CurrencyCoinView(
                crypto: crypto,
                i: i,
                price: match.price,
              ),
            );
          },
        );
      },
    );
  }
}
