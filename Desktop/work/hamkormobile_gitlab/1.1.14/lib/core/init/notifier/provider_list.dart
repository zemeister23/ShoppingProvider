import 'package:flutter/material.dart';
import 'package:mobile/provider/10_transactions_provider.dart';
import 'package:mobile/provider/11_history_provider.dart';
import 'package:mobile/provider/1_intro_provider.dart';
import 'package:mobile/provider/2_registration_provider.dart';
import 'package:mobile/provider/3_sms_provider.dart';
import 'package:mobile/provider/4_oferta_provider.dart';
import 'package:mobile/provider/5_pin-code_auth_provider.dart';
import 'package:mobile/provider/6_check_pin_code_provider.dart';
import 'package:mobile/provider/7_razvilka_provider.dart';
import 'package:mobile/provider/8_add-card_provider.dart';
import 'package:mobile/provider/9_home_provider.dart';
import 'package:mobile/provider/biometric_provider.dart';
import 'package:mobile/provider/check_pass_code_provider.dart';
import 'package:mobile/provider/lock_timer_provider.dart';
import 'package:mobile/provider/map_provider.dart';
import 'package:mobile/provider/theme_notifier_provider.dart';
import 'package:mobile/core/init/theme/app_theme.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ApplicationProvider extends AppTheme {
  static ApplicationProvider? _instance;
  static ApplicationProvider get instance {
    _instance ??= ApplicationProvider._init();
    return _instance!;
  }

  ApplicationProvider._init();

  List<SingleChildWidget> singleItems = [];
  List<SingleChildWidget> dependItems = [
    ChangeNotifierProvider(create: (ctx) => ThemeNotifier()),
    Provider.value(value: NavigationService.instance),
    ChangeNotifierProvider(create: (ctx) => IntroProvider()),
    ChangeNotifierProvider(create: (ctx) => RegistrationProvider()),
    ChangeNotifierProvider(create: (ctx) => SmsProvider()),
    ChangeNotifierProvider(create: (ctx) => OfertaProvider()),
    ChangeNotifierProvider(create: (ctx) => PinCodeAuthProvider()),
    ChangeNotifierProvider(create: (ctx) => CheckPinCodeProvider()),
    ChangeNotifierProvider(create: (ctx) => RazvilkaProvider()),
    ChangeNotifierProvider(create: (ctx) => AddCardProvider()),
    ChangeNotifierProvider(create: (ctx) => CheckPassCodeProvider()),
    ChangeNotifierProvider(create: (ctx) => HomeProvider()),
    ChangeNotifierProvider(create: (ctx) => TransactionsProivder()),
    ChangeNotifierProvider(create: (ctx) => HistoryProvider()),
    ChangeNotifierProvider(create: (ctx) => MapProvider()),
    ChangeNotifierProvider(create: (ctx) => LockProvider(ctx)),
    ChangeNotifierProvider(create: (ctx) => BiometricProvider()),
  ];
  List<SingleChildWidget> uiChangesItems = [];
}
