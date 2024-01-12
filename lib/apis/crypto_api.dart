import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class CryptoAPI {
  static Future<List<dynamic>> getMarkets() async {
    try {
      var response = await http.get(Uri.parse(
          'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=30&page=1&sparkline=false'));
      dynamic decodedResponse;
      if (response.statusCode == 200) {
        decodedResponse = convert.jsonDecode(response.body);
      }
      List<dynamic> markets = decodedResponse as List<dynamic>;
      return markets;
    } catch (e) {
      return [];
    }
  }
}
