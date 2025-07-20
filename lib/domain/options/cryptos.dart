enum Cryptos {
  btc('bitcoin'),
  eth('ethereum'),
  ltc('litecoin'),
  xrp('ripple'),
  doge('dogecoin'),
  dot('polkadot'),
  ada('cardano'),
  sol('solana'),
  uni('uniswap'),
  link('chainlink'),
  xlm('stellar'),
  trx('tron'),
  algo('algorand'),
  fil('filecoin'),
  aave('aave');

  final String fullName;

  const Cryptos(this.fullName);

  @override
  String toString() => fullName;

  // Método estático para retornar a lista ordenada
  static List<Cryptos> get sortedByName {
    final list = Cryptos.values.toList();
    list.sort((a, b) => a.fullName.compareTo(b.fullName));
    return list;
  }

  // Exemplo de método que retorna os nomes formatados já ordenados
  static String getAllFormattedSorted() {
    return sortedByName.map((c) => c.fullName).join(", ");
  }
}
