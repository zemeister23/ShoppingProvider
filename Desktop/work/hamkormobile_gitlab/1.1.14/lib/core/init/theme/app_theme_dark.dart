import 'package:flutter/material.dart';
import 'package:mobile/core/init/theme/app_theme.dart';

class AppThemeDark extends AppTheme {
  static AppThemeDark? _instance;
  static AppThemeDark get instance {
    _instance ??= AppThemeDark._init();
    return _instance!;
  }

  AppThemeDark._init();

  ThemeData get theme => ThemeData.dark();
}
