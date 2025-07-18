abstract class FavoriteCoinState{}

class FavoriteCoinInitial extends FavoriteCoinState {}

class FavoriteCoinLoading extends FavoriteCoinState {}

class FavoriteCoinSuccess<T> extends FavoriteCoinState {
  final T data;

  FavoriteCoinSuccess(this.data);
}

class FavoriteCoinFailure extends FavoriteCoinState {
  final String error;

  FavoriteCoinFailure(this.error);
}