import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_coin/domain/options/cryptos.dart';

import '../../../../application/bloc/favorite/favorite_coin_bloc.dart';
import '../../../../application/bloc/favorite/favorite_coin_event.dart';
import '../../../../application/bloc/favorite/favorite_coin_state.dart';
import '../../../../data/network/crypto_network/crypto_network.dart';
import '../../../../data/network/firebase/save_favorite_coin_firestore.dart';

class CurrencyCoinComponent extends StatefulWidget {
  const CurrencyCoinComponent({
    super.key,
    required this.crypto,
    required this.i
  });
  final Cryptos crypto;
  final int i;


  @override
  State<StatefulWidget> createState() => _CurrencyCoinComponentState();
}

class _CurrencyCoinComponentState extends State<CurrencyCoinComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/${widget.crypto.name}.png',
              height: 40,
              width: 40,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                widget.crypto.fullName,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            BlocConsumer<FavoriteCoinBloc, FavoriteCoinState>(
              listener: (context, state) {
                if (state is FavoriteCoinSuccess) {
                } else if (state is FavoriteCoinFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error)),
                  );
                }
              },
              builder: (context, state) {
                return FutureBuilder<bool>(
                  future: verifyCoinExists(
                    FirebaseAuth.instance.currentUser!.uid,
                    widget.crypto.fullName,
                  ),
                  builder: (context, snapshot) {
                    final isFavorite = snapshot.data ?? false;

                    return IconButton(
                      icon: Icon(
                        isFavorite ? Icons.star : Icons.star_outline,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        if (isFavorite) {
                          context.read<FavoriteCoinBloc>().add(
                            DeleteCoinEvent(
                              userId: FirebaseAuth.instance.currentUser!.uid,
                              coinId: widget.crypto.name,
                            ),
                          );
                        } else {
                          context.read<FavoriteCoinBloc>().add(
                            SaveCoinEvent(
                              userId: FirebaseAuth.instance.currentUser!.uid,
                              coin: {
                                'name': widget.crypto.fullName,
                                'symbol': widget.crypto.name,
                              },
                            ),
                          );
                        }

                        setState(() {}); // Refaz o FutureBuilder para reavaliar se está favoritado
                      },
                    );
                  },
                );
              },
            )

          ],
        ),
        const SizedBox(height: 10),
        if (widget.i != Cryptos.values.length - 1)
          const Divider(color: Colors.grey),
      ],
    );
  }
}