enum Cryptos {
  btc('bitcoin'),
  eth('ethereum'),
  ltc('litecoin'),
  bch('bitcoin cash'),
  xrp('ripple'),
  doge('dogecoin'),
  dot('polkadot'),
  ada('cardano'),
  sol('solana'),
  matic('polygon'),
  uni('uniswap'),
  link('chainlink'),
  xlm('stellar'),
  trx('tron'),
  bnb('binance coin'),
  avax('avalanche'),
  algo('algorand'),
  fil('filecoin'),
  aave('aave'),
  sushi('sushiswap');

  final String fullName;

  const Cryptos(this.fullName);

  @override
  String toString() => fullName;
}
