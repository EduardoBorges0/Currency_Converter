abstract class FavoriteCoinEvent {}

class SaveCoinEvent extends FavoriteCoinEvent {
  final String userId;
  final Map<String, dynamic> coin;

  SaveCoinEvent({
    required this.userId,
    required this.coin,
  });
}

class DeleteCoinEvent extends FavoriteCoinEvent {
  final String userId;
  final String coinId;

  DeleteCoinEvent({
    required this.userId,
    required this.coinId,
  });
}

class GetFavoriteCoinsEvent extends FavoriteCoinEvent {
  final String userId;
  final String coinId;
  GetFavoriteCoinsEvent({
    required this.userId,
    required this.coinId,
  });
}