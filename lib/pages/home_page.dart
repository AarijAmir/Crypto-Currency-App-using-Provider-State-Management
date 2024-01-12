import 'package:cryptocurrency_app/widgets/favourites.dart';
import 'package:cryptocurrency_app/widgets/markets.dart';
import 'package:cryptocurrency_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          top: 20,
          left: 20,
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome Back',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Crypto Today',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      themeProvider.toggleTheme();
                    },
                    icon: (themeProvider.themeMode == ThemeMode.dark)
                        ? const Icon(
                            Icons.dark_mode,
                          )
                        : const Icon(
                            Icons.light_mode,
                          ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TabBar(
                controller: _tabController,
                tabs: [
                  Tab(
                    child: Text(
                      'Market',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Favorites',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  )
                ],
              ),
              Expanded(
                child: TabBarView(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  controller: _tabController,
                  children: const [
                    Markets(),
                    Favorites(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
