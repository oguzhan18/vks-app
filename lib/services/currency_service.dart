import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:vks/models/currency.dart';

class CurrencyService {
  late Future<List<Currency>> currenciesFuture;

  CurrencyService() {
    currenciesFuture = loadCurrenciesFuture();
  }

  Future<List<Currency>> loadCurrenciesFuture() async {
    List<dynamic> data =
        jsonDecode(await rootBundle.loadString('assets/curs.json'));
    List<Currency> curs = data
        .map((cur) => Currency(
            name: cur['name']!, symbol: cur['symbol']!, code: cur['code']!))
        .toList();
    curs.sort((a, b) => a.name.compareTo(b.name));
    return curs;
  }
}
