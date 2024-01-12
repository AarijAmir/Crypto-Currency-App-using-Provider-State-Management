import 'package:cryptocurrency_app/widgets/crypto_list_tile.dart';
import 'package:cryptocurrency_app/providers/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cryptocurrency.dart';

class Markets extends StatelessWidget {
  const Markets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (context, marketProvider, child) {
        if (marketProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (marketProvider.markets.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                await MarketProvider().fetchData();
              },
              child: ListView.builder(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                itemCount: marketProvider.markets.length,
                itemBuilder: (context, index) {
                  CryptoCurrency currentCrypto = marketProvider.markets[index];
                  return CryptoListTile(currentCrypto: currentCrypto);
                },
              ),
            );
          } else {
            return const Center(
              child: Text('No Data'),
            );
          }
        }
      },
    );
  }
}
