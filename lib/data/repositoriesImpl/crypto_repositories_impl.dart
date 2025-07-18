import 'package:u_coin/data/network/firebase/save_favorite_coin_firestore.dart';

import '../../domain/repositories/crypto_repositories.dart';

class CryptoRepositoriesImpl extends CryptoRepositories {
  @override
  Future<void> saveFavoriteCoin({
    required String userId,
    required Map<String, dynamic> coin,
  }) {
    return saveFavoriteCoinFirestore(userId, coin);
  }

  @override
  Future<bool> verifyCoinExists({
    required String userId,
    required String coinId,
  }) {
    return verifyCoinExists(userId: userId, coinId: coinId);
  }

  @override
  Future<void> deleteFavoriteCoin({
    required String userId,
    required String coinId,
  }) {
    return deleteCoinFirestore(userId, coinId);
  }
}
