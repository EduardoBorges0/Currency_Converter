abstract class CryptoEvent {}

class FetchCryptoEvent extends CryptoEvent {
  final String cryptoId;

  FetchCryptoEvent(this.cryptoId);
}
