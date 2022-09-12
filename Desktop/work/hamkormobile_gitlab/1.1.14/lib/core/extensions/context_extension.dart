import 'package:flutter/material.dart';
import 'package:mobile/provider/10_transactions_provider.dart';
import 'package:mobile/provider/11_history_provider.dart';
import 'package:mobile/provider/2_registration_provider.dart';
import 'package:mobile/provider/3_sms_provider.dart';
import 'package:mobile/provider/4_oferta_provider.dart';
import 'package:mobile/provider/5_pin-code_auth_provider.dart';
import 'package:mobile/provider/8_add-card_provider.dart';
import 'package:mobile/provider/9_home_provider.dart';
import 'package:mobile/provider/biometric_provider.dart';
import 'package:mobile/provider/check_pass_code_provider.dart';
import 'package:mobile/provider/map_provider.dart';
import 'package:mobile/service/api_service/9_add_card_service.dart';
import 'package:provider/provider.dart';
import '../../provider/1_intro_provider.dart';

extension SizedContext on BuildContext {
  /// Returns same as MediaQuery.of(context)
  MediaQueryData get mq => MediaQuery.of(this);
  TextTheme get theme => Theme.of(this).textTheme;
  BuildContext get cont => this;

  /// Returns if Orientation is landscape
  bool get isLandscape => mq.orientation == Orientation.landscape;

  /// Returns same as MediaQuery.of(context).size
  Size get sizePx => mq.size;

  /// Returns same as MediaQuery.of(context).size.width
  double get w => sizePx.width;

  /// Returns same as MediaQuery.of(context).size.height
  double get h => sizePx.height;

  /// Returns fraction (0-1) of screen width in pixels
  double widthPct(double fraction) => fraction * w;

  /// Returns fraction (0-1) of screen height in pixels
  double heightPct(double fraction) => fraction * h;
  IntroProvider get introPr => Provider.of<IntroProvider>(this, listen: false);
  IntroProvider get introPrStream => this.watch<IntroProvider>();
  RegistrationProvider get phoneRegisterPr =>
      Provider.of<RegistrationProvider>(this, listen: false);
  RegistrationProvider get phoneRegisterPrStream =>
      this.watch<RegistrationProvider>();

  OfertaProvider get ofertaPr =>
      Provider.of<OfertaProvider>(this, listen: false);
  AddCardProvider get addCardPr =>
      Provider.of<AddCardProvider>(this, listen: false);
  AddCardProvider get addCardPrStreem => watch<AddCardProvider>();
  HomeProvider get homePrStreem => watch<HomeProvider>();
  HomeProvider get homePr => Provider.of<HomeProvider>(this, listen: false);
  SmsProvider get smsPr => Provider.of<SmsProvider>(this, listen: false);
  TransactionsProivder get transactionsPr =>
      Provider.of<TransactionsProivder>(this, listen: false);
  TransactionsProivder get transactionPrStream =>
      this.watch<TransactionsProivder>();
  HistoryProvider get historyPr =>
      Provider.of<HistoryProvider>(this, listen: false);
  HistoryProvider get historyPrStreem => this.watch<HistoryProvider>();
  MapProvider get mapPr => Provider.of<MapProvider>(this, listen: false);
  MapProvider get mapPrStream => this.watch<MapProvider>();
  CheckPassCodeProvider get passCodePr =>
      Provider.of<CheckPassCodeProvider>(this, listen: false);
  CheckPassCodeProvider get passCodePrStream =>
      this.watch<CheckPassCodeProvider>();
  BiometricProvider get biometricPr =>
      Provider.of<BiometricProvider>(this, listen: false);
  BiometricProvider get biometricPrStream => this.watch<BiometricProvider>();
}
