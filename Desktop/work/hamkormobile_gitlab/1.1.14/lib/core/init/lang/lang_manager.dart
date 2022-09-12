import 'package:flutter/material.dart';

class LanguageManager {
  static LanguageManager? _instance;
  static LanguageManager get instance {
    _instance ??= LanguageManager._init();
    return _instance!;
  }

  LanguageManager._init();

  final enLocale = const Locale("en", "US");
  final ruLocale = const Locale("ru", "RU");
  final uzLocale = const Locale("uz", "UZ");

  List<Locale> get supportedLocales => [
        enLocale,
        ruLocale,
        uzLocale,
      ];
}
