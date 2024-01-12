import 'package:cryptocurrency_app/constants/themes.dart';
import 'package:cryptocurrency_app/pages/home_page.dart';
import 'package:cryptocurrency_app/providers/market_provider.dart';
import 'package:cryptocurrency_app/providers/theme_provider.dart';
import 'package:cryptocurrency_app/storage/local_storage_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  String currentTheme = await LocalStorage.getTheme() ?? 'light';
  runApp(
    MyApp(
      theme: currentTheme,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.theme});
  final String theme;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MarketProvider>(
          create: (context) => MarketProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider('dark'),
        ),
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: lightTheme,
          darkTheme: darkTheme,
          home: const MyHomePage(),
        );
      }),
    );
  }
}
