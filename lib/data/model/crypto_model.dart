class CryptoModel {
  final String name;
  final double price;

  CryptoModel({
    required this.name,
    required this.price,
  });

  factory CryptoModel.fromJson(String name, Map<String, dynamic> value, String currency) {
    return CryptoModel(
      name: name,
      price: (value[currency.toLowerCase()] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson(String currency) {
    return {
      'name': name,
      currency.toLowerCase(): price,
    };
  }

  @override
  String toString() => '$name: $price';
}
