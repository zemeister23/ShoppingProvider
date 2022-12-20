import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
export 'package:firebase_crashlytics/firebase_crashlytics.dart';

class Endpoints {
  Endpoints._();

  static String baseUrl =
      true ? dotenv.env['baseUrl']! : dotenv.env['test_baseUrl']!;

  static String get status =>
      baseUrl == dotenv.env['baseUrl']! ? "(1)P" : "(1)T";
  static bool get isVersionEnable => false;
  static int receiveTimeout = 60000;
  static int connectionTimeout = 60000;
  static String language = dotenv.env['language']!;
  static String operators = dotenv.env['operators']!;
  static String startRegistration = dotenv.env['startRegistration']!;
  static String finishRegistration = dotenv.env['finishRegistration']!;
  static String offerta = dotenv.env['offerta']!;
  static String razvilka = dotenv.env['razvilka']!;
  static String addCard = dotenv.env['addCard']!;
  static String refresh = dotenv.env['refresh']!;
  static String clientRegistration = dotenv.env['clientRegistration']!;

  static String clientName = dotenv.env['clientName']!;
  static String clientCards = dotenv.env['clientCards']!;
  static String p2pLast = dotenv.env['p2pLast']!;
  static String p2pTemplates = dotenv.env['p2pTemplates']!;
  static String deposits = dotenv.env['deposits']!;
  static String accounts = dotenv.env['accounts']!;
  static String loans = dotenv.env['loans']!;

  static String valuta = dotenv.env['valuta']!;
  static String productStore = dotenv.env['productStore']!;
  static String translations = dotenv.env['translations']!;
  static String transValidate = dotenv.env['transValidate']!;
  static String p2pConfirm = dotenv.env['p2pConfirm']!;
  static String p2pInit = dotenv.env['p2pInit']!;
  static String p2pInfo = dotenv.env['p2pInfo']!;
  static String history = dotenv.env['history']!;
  static String postLangugae = dotenv.env['postLangugae']!;
  static String bancomates = dotenv.env['bancomates']!;
  static String branches = dotenv.env['branches']!;
  static String regions = dotenv.env['regions']!;
  static String bioRegistration = dotenv.env['bioRegistration']!;
  static String storeAction = dotenv.env['storeAction']!;
  static String bioIdentification = dotenv.env['bioIdentification']!;
  static String clientBioIdentification =
      dotenv.env['clientBioIdentification']!;
  static String cardsBalances = dotenv.env['cardsBalances']!;
  static String minVersion = dotenv.env['minVersion']!;
  static String bioInformation = dotenv.env['bioInformation']!;
  static String bioPublicIdentify = dotenv.env['bioPublicIdentify']!;
  static String wsO2DomainProd = dotenv.env['wsO2_domain_prod']!;
  static String bioMyIdPublicIdentify = dotenv.env['bioMyIdPublicIdentify']!;

  static String cardsOperations = dotenv.env['cardsOperations']!;

  static headers() {
    String accessToken = GetStorageService.instance.box
        .read(GetStorageService.instance.accessToken);
    return {"Authorization": "Bearer $accessToken"};
  }
}
