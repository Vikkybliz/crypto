import 'dart:convert';

import 'package:http/http.dart' as http;
  

class Crypto {
  final String name;
  final String symbol;
  final String price_usd;

  Crypto(
      {required this.name,
      required this.symbol,
      required this.price_usd});

  factory Crypto.fromJson(Map<String, dynamic> json) {
    return Crypto(
        name: json['data'][0]['name'],
        symbol: json['data'][0]['symbol'],
        price_usd: json['data'][0]['price_usd']);
  }
}

Future <List<Crypto>> fetchCrypto() async {
  final url = 'https://api.coinlore.net/api/tickers/';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Crypto.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

