abstract class CryptoRepositories {
  Future<void> saveFavoriteCoin({
    required String userId, required Map<String, dynamic> coin
  });
  Future<bool> verifyCoinExists({
    required String userId, required String coinId
  });

  Future<void> deleteFavoriteCoin({
    required String userId, required String coinId
  });
}