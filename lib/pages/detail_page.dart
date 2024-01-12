import 'package:cryptocurrency_app/models/cryptocurrency.dart';
import 'package:cryptocurrency_app/providers/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.id});
  final String id;
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Widget _tileAndDetail(
      String title, String detail, CrossAxisAlignment crossAxisAlignment) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        Text(
          detail,
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SizedBox(
          child: Consumer<MarketProvider>(
            builder: (context, marketProvider, child) {
              CryptoCurrency currentCrypto = marketProvider.fetchCryptoId(
                id: widget.id,
              );
              return RefreshIndicator(
                onRefresh: () async {
                  await marketProvider.fetchData();
                },
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: ListView(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.all(
                          0,
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(currentCrypto.image!),
                        ),
                        title: Text(
                          currentCrypto.name!,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        subtitle: Text(
                          '\$ ${currentCrypto.currentPrice.toString()}',
                          style: const TextStyle(
                            color: Color(
                              0xff0395eb,
                            ),
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Price Change (24h)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
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
                                    fontSize: 30,
                                  ),
                                );
                              } else {
                                return Text(
                                  '+${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(4)})',
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontSize: 30,
                                  ),
                                );
                              }
                            },
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _tileAndDetail(
                              'Market Cap',
                              '\$ ${currentCrypto.marketCap!.toStringAsFixed(4)}',
                              CrossAxisAlignment.start),
                          _tileAndDetail(
                              'Market Cap Rank',
                              '#${currentCrypto.marketCapRank}',
                              CrossAxisAlignment.end),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _tileAndDetail(
                              'Low 24h',
                              '\$ ${currentCrypto.low24!.toStringAsFixed(4)}',
                              CrossAxisAlignment.start),
                          _tileAndDetail(
                              'High 24h',
                              '\$ ${currentCrypto.high24!.toStringAsFixed(4)}',
                              CrossAxisAlignment.end),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _tileAndDetail(
                              'Circulating Supply',
                              '\$ ${currentCrypto.circulatingSupply!.toString()})}',
                              CrossAxisAlignment.start),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _tileAndDetail(
                              'All Time Low',
                              '\$ ${currentCrypto.atl!.toStringAsFixed(4)}',
                              CrossAxisAlignment.start),
                          _tileAndDetail(
                              'All Time High',
                              '\$ ${currentCrypto.ath!.toStringAsFixed(4)}',
                              CrossAxisAlignment.end),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
