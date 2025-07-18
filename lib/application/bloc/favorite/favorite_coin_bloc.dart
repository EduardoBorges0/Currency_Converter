import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_coin/application/bloc/favorite/favorite_coin_event.dart';
import 'package:u_coin/application/bloc/favorite/favorite_coin_state.dart';
import 'package:u_coin/domain/repositories/crypto_repositories.dart';

class FavoriteCoinBloc extends Bloc<FavoriteCoinEvent, FavoriteCoinState> {
  final CryptoRepositories cryptoRepositories;

  FavoriteCoinBloc(this.cryptoRepositories) : super(FavoriteCoinInitial()) {
    on<SaveCoinEvent>((event, emit) async {
      emit(FavoriteCoinLoading());
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.none) {
        emit(FavoriteCoinFailure('Sem conexão com a internet'));
        return;
      }
      try {
        await cryptoRepositories.saveFavoriteCoin(
          userId: event.userId,
          coin: event.coin,
        );
        emit(FavoriteCoinSuccess("Coin saved successfully"));
      } catch (e) {
        emit(FavoriteCoinFailure(e.toString()));
      }
    });

    on<DeleteCoinEvent>((event, emit) async {
      emit(FavoriteCoinLoading());
      print("IS FAVORITE DELETADO");

      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.none) {
        emit(FavoriteCoinFailure('Sem conexão com a internet'));

        return;
      }
      try {
        await cryptoRepositories.deleteFavoriteCoin(
          userId: event.userId,
          coinId: event.coinId,
        );
        emit(FavoriteCoinSuccess("Coin deleted successfully"));
      } catch (e) {
        emit(FavoriteCoinFailure(e.toString()));
      }
    });

    on<GetFavoriteCoinsEvent>((event, emit) async {
      final connectivityResult = await Connectivity().checkConnectivity();
      emit(FavoriteCoinLoading());
      if (connectivityResult == ConnectivityResult.none) {
        emit(FavoriteCoinFailure('Sem conexão com a internet'));
        return;
      }
      try {
        final favoriteCoins = await cryptoRepositories.verifyCoinExists(
          userId: event.userId,
          coinId: event.coinId,
        );
        emit(FavoriteCoinSuccess(favoriteCoins));
      } catch (e) {
        emit(FavoriteCoinFailure(e.toString()));
      }
    });
  }
}
