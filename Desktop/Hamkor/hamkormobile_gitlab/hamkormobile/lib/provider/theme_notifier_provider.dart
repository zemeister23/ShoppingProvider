import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:mobile/core/constants/enums/app_theme_enums.dart';
import 'package:mobile/core/init/theme/app_theme_light_dark.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme = AppThemeLightDark.instance.light;
  ThemeData get currentTheme => AppThemeLightDark.instance.light;
  void changeTheme(AppThemes theme) {
    if (theme == AppThemes.LIGHT) {
      _currentTheme = AppThemeLightDark.instance.light;
    } else {
      _currentTheme = AppThemeLightDark.instance.dark;
    }
    notifyListeners();
  }
}
