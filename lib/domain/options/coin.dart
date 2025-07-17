enum Coins {
  DOLAR('usd'),
  REAL('brl'),
  EURO('eur');

  final String fullName;

  const Coins(this.fullName);

  @override
  String toString() => fullName;
}
