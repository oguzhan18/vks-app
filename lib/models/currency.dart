class Currency {
  String name;
  String symbol;
  String code;

  Currency({
    required this.name,
    required this.symbol,
    required this.code
  });

  @override
  String toString() {
    return '$name ($code${symbol != code ? '/$symbol' : ''})';
  }
}