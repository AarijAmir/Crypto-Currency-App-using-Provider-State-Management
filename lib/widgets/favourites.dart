import 'package:cryptocurrency_app/models/cryptocurrency.dart';
import 'package:cryptocurrency_app/widgets/crypto_list_tile.dart';
import 'package:cryptocurrency_app/providers/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (context, marketProvider, child) {
        List<CryptoCurrency> favorites = marketProvider.markets
            .where((element) => element.isFavorite == true)
            .toList();
        return (favorites.isNotEmpty)
            ? ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  CryptoCurrency currentCrypto = favorites[index];
                  return CryptoListTile(currentCrypto: currentCrypto);
                },
              )
            : const Center(
                child: Text(
                  'No Favorite',
                ),
              );
      },
    );
  }
}
