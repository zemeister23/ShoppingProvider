import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ThemeChangerProvider extends ChangeNotifier {
  ThemeMode themeMode = ((GetStorage().read('theme') ?? false)
      ? ThemeMode.dark
      : ThemeMode.light);
  bool isLight = (GetStorage().read('theme'));
  void changeTheme(mode) async {
    if (mode) {
      themeMode = ThemeMode.dark;
      isLight = true;
      await GetStorage().write('theme', isLight);
    } else {
      themeMode = ThemeMode.light;
      isLight = false;
      await GetStorage().write('theme', isLight);
    }
    notifyListeners();
  }
}
