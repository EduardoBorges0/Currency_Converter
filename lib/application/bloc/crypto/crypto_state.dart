abstract class CryptoState {}

class CryptoInitial extends CryptoState {}

class CryptoLoading extends CryptoState {}

class CryptoSuccess<T> extends CryptoState {
  final T data;

  CryptoSuccess(this.data);
}

class CryptoFailure extends CryptoState {
  final String error;

  CryptoFailure(this.error);
}