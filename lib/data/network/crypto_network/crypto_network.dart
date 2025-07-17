import 'package:dio/dio.dart';
import 'package:u_coin/domain/options/cryptos.dart';

final dio = Dio();

Future<void> CryptoNetwork(String coin) async {
  try {
    String getAllCryptosFormatted() {
      return Cryptos.values.map((c) => c.fullName).join(",");
    }

    final response = await dio.get(
      'https://api.coingecko.com/api/v3/simple/price?ids=${getAllCryptosFormatted()}&vs_currencies=${coin.toLowerCase()}',
    );

    for (int i = 0; i < Cryptos.values.length; i++) {
      final crypto = Cryptos.values[i];
      print('Crypto: ${crypto.name}'); // pega "btc", "eth", etc.
    }

  } catch (e) {
    print('Erro ao buscar preço: $e');
  }
}
