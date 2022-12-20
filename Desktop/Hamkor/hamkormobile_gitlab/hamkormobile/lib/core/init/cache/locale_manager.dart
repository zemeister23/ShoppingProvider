import 'package:easy_localization/easy_localization.dart';
import 'package:mobile/core/constants/enums/locale_keys_enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleManager {
  static final LocaleManager _instance = LocaleManager._init();
  SharedPreferences? _preferences;
  static LocaleManager get instance => _instance;

  LocaleManager._init() {
    SharedPreferences.getInstance().then((value) {
      _preferences = value;
    });
  }

  static preferenceInit() async {
    instance._preferences ??= await SharedPreferences.getInstance();
  }

  Future<void> setStringValue(PreferenceKeys key, String value) async {
    await _preferences!.setString(key.toString(), value);
  }

  String? getStringValue(PreferenceKeys key) =>
      _preferences!.getString(key.toString()) ?? "";
}
