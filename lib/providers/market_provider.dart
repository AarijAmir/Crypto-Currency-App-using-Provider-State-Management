import 'dart:async';

import 'package:cryptocurrency_app/apis/crypto_api.dart';
import 'package:cryptocurrency_app/models/cryptocurrency.dart';
import 'package:cryptocurrency_app/storage/local_storage_shared_preferences.dart';
import 'package:flutter/cupertino.dart';

class MarketProvider extends ChangeNotifier {
  MarketProvider() {
    fetchData();
  }
  bool isLoading = true;
  List<CryptoCurrency> markets = [];
  Future<void> fetchData() async {
    List<dynamic> rawMarkets = await CryptoAPI.getMarkets();
    List<String> favorites = await LocalStorage.fetchFavorites();
    List<CryptoCurrency> temp = [];
    for (var market in rawMarkets) {
      CryptoCurrency cryptoCurrency = CryptoCurrency.fromMap(market);
      if (favorites.contains(cryptoCurrency.id)) {
        cryptoCurrency.isFavorite = true;
      }
      temp.add(cryptoCurrency);
    }
    markets = temp;
    isLoading = false;
    notifyListeners();
    // Refresh After 3 seconds
    Timer(const Duration(seconds: 3), () {
      fetchData();
    });
  }

  CryptoCurrency fetchCryptoId({required String id}) {
    CryptoCurrency crypto =
        markets.where((element) => element.id == id).toList()[0];
    return crypto;
  }

  void addFavorite(CryptoCurrency cryptoCurrency) async {
    int indexOfCrypto = markets.indexOf(cryptoCurrency);
    markets[indexOfCrypto].isFavorite = true;
    await LocalStorage.addFavorite(cryptoCurrency.id!);
    notifyListeners();
  }

  void removeFavorite(CryptoCurrency cryptoCurrency) async {
    int indexOfCrypto = markets.indexOf(cryptoCurrency);
    markets[indexOfCrypto].isFavorite = false;
    await LocalStorage.removeFavorite(cryptoCurrency.id!);
    notifyListeners();
  }
}
