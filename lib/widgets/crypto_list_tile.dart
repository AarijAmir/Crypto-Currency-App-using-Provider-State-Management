import 'package:cryptocurrency_app/models/cryptocurrency.dart';
import 'package:cryptocurrency_app/providers/market_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/detail_page.dart';

class CryptoListTile extends StatelessWidget {
  const CryptoListTile({super.key, required this.currentCrypto});

  final CryptoCurrency currentCrypto;

  @override
  Widget build(BuildContext context) {
    MarketProvider marketProvider =
        Provider.of<MarketProvider>(context, listen: false);
    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailPage(id: currentCrypto.id!),
          ),
        );
      },
      contentPadding:
          const EdgeInsets.only(left: 0, right: 10, bottom: 0, top: 0),
      subtitle: Text(
        currentCrypto.symbol!,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'S ${currentCrypto.currentPrice!.toStringAsFixed(4)}',
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Builder(
            builder: (context) {
              double priceChange = currentCrypto.priceChange24!;
              double priceChangePercentage =
                  currentCrypto.priceChangePercentage24!;
              if (priceChange < 0) {
                return Text(
                  '${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(4)})',
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                );
              } else {
                return Text(
                  '+${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(4)})',
                  style: const TextStyle(
                    color: Colors.green,
                  ),
                );
              }
            },
          ),
        ],
      ),
      leading: CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: NetworkImage(currentCrypto.image!)),
      title: Row(
        children: [
          Flexible(
            child: Text(
              '${currentCrypto.name!} #${currentCrypto.marketCapRank}',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          (currentCrypto.isFavorite == false)
              ? GestureDetector(
                  child: const Icon(
                    CupertinoIcons.heart,
                    size: 18,
                  ),
                  onTap: () {
                    marketProvider.addFavorite(currentCrypto);
                  },
                )
              : GestureDetector(
                  child: const Icon(
                    CupertinoIcons.heart_fill,
                    color: Colors.red,
                    size: 18,
                  ),
                  onTap: () {
                    marketProvider.removeFavorite(currentCrypto);
                  },
                ),
        ],
      ),
    );
  }
}
