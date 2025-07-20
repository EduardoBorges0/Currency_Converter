enum PreferenceCoinOptions {
  brl('R\$', 'pt_BR', 'BRL', 'Real Brasileiro'),
  usd('\$', 'en_US', 'USD', 'Dólar Americano'),
  eur('€', 'de_DE', 'EUR', 'Euro');

  final String symbol;
  final String locale;
  final String code;
  final String fullName;

  const PreferenceCoinOptions(this.symbol, this.locale, this.code, this.fullName);
}
