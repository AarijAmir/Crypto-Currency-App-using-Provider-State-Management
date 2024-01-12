import 'package:cryptocurrency_app/storage/local_storage_shared_preferences.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  ThemeProvider(String theme) {
    if (theme == 'light') {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
  }
  void toggleTheme() async {
    if (themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
      await LocalStorage.saveTheme('dark');
    } else {
      themeMode = ThemeMode.light;

      await LocalStorage.saveTheme('light');
    }
    notifyListeners();
  }
}
