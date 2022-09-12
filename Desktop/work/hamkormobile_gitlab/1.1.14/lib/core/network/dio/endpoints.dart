import 'package:mobile/core/init/cache/get_storege.dart';
export 'package:firebase_crashlytics/firebase_crashlytics.dart';

class Endpoints {
  Endpoints._();

  // * base url if true -> prod else -> test
  static const String baseUrl = false
      ? 'https://mobilebank.hamkorbank.uz/'
      : 'https://test-mobilebank.hamkorbank.uz/';

  // getter for status control
  static String get status =>
      baseUrl == 'https://mobilebank.hamkorbank.uz/' ? " P" : " T";

  // getter for show version code
  static bool get isVersionEnable => false;
  // receiveTimeout
  static const int receiveTimeout = 60000;
  // connectTimeout
  static const int connectionTimeout = 60000;
  static const String language = 'api/v1/mobile/dict/languages';
  static const String operators = 'api/v1/mobile/dict/operators';
  static const String startRegistration = 'api/v1/mobile/start-registration';
  static const String finishRegistration = "api/v1/mobile//finish-registration";
  static const String offerta = "api/v1/mobile/registration-offer";
  static const String razvilka = "api/v1/mobile/product/store/1";
  static const String addCard = "api/v1/mobile/check-client-registration";
  static const String refresh = "api/v1/mobile/refresh";
  static const String clientRegistration = "api/v1/mobile/client-registration";
  static const String clientName = "api/v1/mobile/client-name";
  static const String clientCards = "api/v1/mobile/client-cards";
  static const String p2pLast = "api/v1/mobile/payment/p2p-lasts";
  static const String p2pTemplates = "api/v1/mobile/payment/p2p-templates";
  static const String deposits = "api/v1/mobile/product/deposits";
  static const String accounts = "api/v1/mobile/product/accounts";
  static const String loans = "api/v1/mobile/product/loans";
  static const String valuta = "api/v1/mobile/exchange-rates";
  static const String productStore = "api/v1/mobile/product/store";
  static const String translations = "api/v1/mobile/payment/p2p-templates";
  static const String transValidate = "api/v1/mobile/payment/p2p-validate";
  static const String p2pConfirm = "api/v1/mobile/payment/p2p-confirm";
  static const String p2pInit = "api/v1/mobile/payment/p2p-init";
  static const String p2pInfo = "api/v1/mobile/payment/p2p-info/";
  static const String history = "api/v2/mobile/cards-operations";
  static const String postLangugae = "api/v1/mobile/settings/language";
  static const String bancomates = "api/v1/mobile/dict/bankomates";
  static const String branches = "api/v1/mobile/dict/branches";
  static const String regions = "api/v1/mobile/dict/regions";
  static const String bioRegistration = "api/v1/mobile/client-bio-registration";
  static const String storeAction = "api/v1/mobile/product/store-action";
  static const String bioIdentification = "api/v1/mobile/bio-identification";
  static const String clientBioIdentification =
      "api/v1/mobile/client-bio-identification";
  static const String cardsBalances = "/api/v2/mobile/cards-balances";
  static const String minVersion = "/api/v1/mobile/settings/min-version";
  static headers() {
    String accessToken = GetStorageService.instance.box
        .read(GetStorageService.instance.accessToken);
    return {"Authorization": "Bearer $accessToken"};
  }
}
