import 'package:dio/dio.dart';
import 'package:u_coin/domain/options/cryptos.dart';

import '../../model/crypto_model.dart';

final dio = Dio();

Future<List<CryptoModel>> CryptoNetwork(String currency) async {
  try {
    String getAllCryptosFormatted() {
      return Cryptos.sortedByName.map((c) => c.fullName).join(",");
    }

    final response = await dio.get(
      'https://api.coingecko.com/api/v3/simple/price?ids=${getAllCryptosFormatted()}&vs_currencies=${currency.toLowerCase()}',
    );

    final data = response.data as Map<String, dynamic>;

    final cryptos =
        data.entries.map((entry) {
          return CryptoModel.fromJson(entry.key, entry.value, currency);
        }).toList();

    return cryptos;
  } catch (e) {
    print('Erro ao buscar preço: $e');
    return [];
  }
}
