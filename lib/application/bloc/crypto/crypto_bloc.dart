import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_coin/application/bloc/crypto/crypto_event.dart';
import 'package:u_coin/application/bloc/crypto/crypto_state.dart';
import 'package:u_coin/data/model/crypto_model.dart';
import 'package:u_coin/data/network/crypto_network/crypto_network.dart';
import 'package:u_coin/data/offline/preference_coin.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  CryptoBloc() : super(CryptoInitial()) {
    on<FetchCryptoEvent>((event, emit) async {
      emit(CryptoLoading());
      try {
        List<CryptoModel> crypto = await CryptoNetwork(
          await PreferenceCoin().getPreferenceCoin(),
        );
        emit(CryptoSuccess<List<CryptoModel>>(crypto));
      } catch (e) {
        emit(CryptoFailure(e.toString()));
      }
    });
  }
}
