import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/constants/error/alert_error.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/core/init/cache/secure_storege.dart';
import 'package:mobile/models/acounts_model.dart';
import 'package:mobile/models/cards_balances_model.dart';
import 'package:mobile/models/client_cards_model.dart';
import 'package:mobile/models/client_name_model.dart';
import 'package:mobile/models/deposits_model.dart';
import 'package:mobile/models/exchange_rates_model.dart';
import 'package:mobile/models/loans_model.dart';
import 'package:mobile/models/p2p_last_model.dart';
import 'package:mobile/models/p2p_templates_model.dart';
import 'package:mobile/provider/lock_timer_provider.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/service/api_service/home_service/accounts_service.dart';
import 'package:mobile/service/api_service/home_service/client_balances_service.dart';
import 'package:mobile/service/api_service/home_service/client_cards_service.dart';
import 'package:mobile/service/api_service/home_service/client_name_service.dart';
import 'package:mobile/service/api_service/home_service/deposits_service.dart';
import 'package:mobile/service/api_service/home_service/exchange_rates_service.dart';
import 'package:mobile/service/api_service/home_service/loans_service.dart';
import 'package:mobile/service/api_service/home_service/p2p_last_service.dart';
import 'package:mobile/service/api_service/home_service/p2p_templates_service.dart';
import 'package:mobile/service/api_service/refref_token_api.dart';
import 'package:provider/provider.dart';

class HomeProvider extends ChangeNotifier {
  late P2PTemplatesModel responsep2pTemplatesModel;
  ClientCardsModel? responseClientCards;
  late ClientNameModel _responseClientName;
  ClientNameModel get responseClientName => _responseClientName;

  bool isExpanded = false;
  bool isExpandedDeposits = false;
  bool isExpandedkridit = false;
  bool hasAppBar = true;
  List cardList = [];
  int currentIndex = 0;
  late P2PLastModel responseP2pLast;
  CardsBalancesModel? responseCardsBalances = null;
  late int erorLength;

  Trace _trace = FirebasePerformance.instance.newTrace('main_page');
  Trace _trace_client_name =
      FirebasePerformance.instance.newTrace('client_name');
  Trace _trace_client_cards =
      FirebasePerformance.instance.newTrace('client_cards');
  Trace _trace_p2p_last = FirebasePerformance.instance.newTrace('p2p_last');
  Trace _trace_p2p_templates =
      FirebasePerformance.instance.newTrace('p2p_templates');
  Trace _trace_deposit = FirebasePerformance.instance.newTrace('deposits');
  Trace _trace_loans = FirebasePerformance.instance.newTrace('credits');
  Trace _trace_exchange_rates =
      FirebasePerformance.instance.newTrace('exchanges');

  int indexForPerformance = 0;

  init(
    BuildContext context,
  ) {
    GetStorageService.instance.box
        .remove(GetStorageService.instance.cardidList);
    Provider.of<LockProvider>(context, listen: false).initializeTimer();
    Provider.of<HomeProvider>(context, listen: false).currentIndex = 0;
    erorLength > 6
        ? ErrorMessage.instance.translationsEror(1001, context)
        : null;
  }

  changeState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  changeHasAppBar(bool s) {
    hasAppBar = s;
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  changeAllText(String text) {
    try {
      final format = NumberFormat("#,##0.00", "en_US");
      List listText = format.format(double.parse(text)).split(".");
      return listText[0].toString().replaceAll(",", " ") + " ";
    } catch (e) {
      return "";
    }
  }

  String reBuildDeposits(String data) {
    if (data == " ") {
      return "";
    } else {
      List<String> temp = data.split(".");
      return "term_until".locale +
          "${temp[0]} ${intToString(temp[1])} ${temp[2]}"
              .replaceAll("NUMBER", "");
    }
  }

  String reBuild(String data) {
    List<String> temp = data.split(".");
    return "Платеж ${temp[0]} ${intToString(temp[1])}";
  }

  String intToString(String data) {
    switch (data) {
      case "1":
        return "yanvar".locale;

      case "2":
        return "fevral".locale;

      case "3":
        return "mart".locale;

      case "4":
        return "aprel".locale;

      case "5":
        return "may".locale;

      case "6":
        return "iyun".locale;

      case "7":
        return "iyul".locale;

      case "8":
        return "avgust".locale;

      case "9":
        return "sentabr".locale;
      case "01":
        return "yanvar".locale;

      case "02":
        return "fevral".locale;

      case "03":
        return "mart".locale;

      case "04":
        return "aprel".locale;

      case "05":
        return "may".locale;

      case "06":
        return "iyun".locale;

      case "07":
        return "iyul".locale;

      case "08":
        return "avgust".locale;

      case "09":
        return "sentabr".locale;

      case "10":
        return "oktabr".locale;

      case "11":
        return "noyabr".locale;

      case "12":
        return "dekabr".locale;

      default:
        return "";
    }
  }

  changeIsExpanded() async {
    isExpanded = await !isExpanded;
    notifyListeners();
  }

  changeIsExpandedDeposits() async {
    isExpandedDeposits = await !isExpandedDeposits;
    notifyListeners();
  }

  changeIsExpandedKridit() async {
    isExpandedkridit = await !isExpandedkridit;
    notifyListeners();
  }

  changePage(int v) {
    if (v == 1) {
      NavigationService.instance.pushNamed(routeName: "/11_transactions");
    } else {
      currentIndex = v;

      notifyListeners();
    }
  }

  // user first ,last and middle name data
  Future<ClientNameModel> getClientName(BuildContext context) async {
    try {
      _trace_client_name.start();
      ClientNameModel responseClientName =
          await ClientNameApi.instance.getClientNameService(context);
      _trace_client_name.stop();
      return responseClientName;
    } catch (e) {
      _trace_client_name.stop();
      if (e is DioError) {
        if (e.response!.statusCode == 500) {
          erorLength += 1;
        }
        if (e.response!.statusCode == 401)
          return await RefreshTokenApi.instance
              .postRefreshToken()
              .then((value) async => await getClientName(context));
      }
      throw e;
    }
  }

  Future<ClientCardsModel> getClientCards(BuildContext context) async {
    try {
      _trace_client_cards.start();
      responseClientCards =
          await ClientCardsApi.instance.getClientCards(context);
      _trace_client_cards.stop();
      String a = "";

      if (responseClientCards!.data!.cards!.isNotEmpty) {
        cardList = [];
        for (var i = 0; i < responseClientCards!.data!.cards!.length; i++) {
          cardList.add({
            "card_id": responseClientCards!.data!.cards![i].cardId!,
            "ps_code": responseClientCards!.data!.cards![i].psCode!
          });
        }
      }

      return responseClientCards!;
    } catch (e) {
      _trace_client_cards.stop();
      if (e is DioError) {
        erorLength += 1;
        if (e.response!.statusCode == 401)
          return await RefreshTokenApi.instance
              .postRefreshToken()
              .then((value) async => await getClientCards(context));
        if (e.response!.statusCode == 500) {
          ErrorMessage.instance
              .translationsEror(e.response!.data["error_code"], context);
        }
      }
      throw Exception("$e");
    }
  }

  // get p2plast vremenna  ne  rabotaet
  Future<P2PLastModel> getP2PLast(BuildContext context) async {
    try {
      _trace_p2p_last.start();
      responseP2pLast = await P2PLastApi.instance.getP2PLast(context);
      _trace_p2p_last.stop();
      return responseP2pLast;
    } catch (e) {
      _trace_p2p_last.stop();
      if (e is DioError) {
        erorLength += 1;
        if (e.response!.statusCode == 401)
          return await RefreshTokenApi.instance
              .postRefreshToken()
              .then((value) async => await getP2PLast(context));
      }
      throw e;
    }
  }

  Future<P2PTemplatesModel> getP2pTemplates(BuildContext context) async {
    try {
      _trace_p2p_templates.start();
      responsep2pTemplatesModel =
          await P2pTemplatesAp.instance.getP2pTemplates(context);
      _trace_p2p_templates.stop();
      return responsep2pTemplatesModel;
    } catch (e) {
      _trace_p2p_templates.stop();
      if (e is DioError) {
        if (e.response!.statusCode == 401)
          return await RefreshTokenApi.instance
              .postRefreshToken()
              .then((value) async => await getP2pTemplates(context));
      }
      throw e;
    }
  }

  Future<Depositsmodel> getDeposits(BuildContext context) async {
    try {
      _trace_deposit.start();
      Depositsmodel responseDeposits =
          await DepositsApi.instance.getDeposits(context);
      _trace_deposit.stop();
      return responseDeposits;
    } catch (e) {
      _trace_deposit.stop();
      if (e is DioError) {
        erorLength += 1;
        if (e.response!.statusCode == 401)
          return await RefreshTokenApi.instance
              .postRefreshToken()
              .then((value) async => await getDeposits(context));
      }
    }
    throw Exception("hato");
  }

  Future<LoansModel> getLoans(BuildContext context) async {
    try {
      _trace_loans.start();
      final responseLoans = await LoansApi.instance.getLoans(context);
      _trace_loans.stop();
      return responseLoans;
    } catch (e) {
      _trace_loans.stop();
      erorLength += 1;
      if (e is DioError) {
        if (e.response!.statusCode == 401)
          return await RefreshTokenApi.instance
              .postRefreshToken()
              .then((value) async => await getLoans(context));
      }
    }
    throw Exception("hato");
  }

  Future<ExchangeRatesModel> getExchangeRates(BuildContext context) async {
    try {
      _trace_exchange_rates.start();
      ExchangeRatesModel responsExchangeRates =
          await ExchangeRates.instance.getExchangeRates(context);
      _trace_exchange_rates.stop();
      return responsExchangeRates;
    } catch (e) {
      _trace_exchange_rates.stop();
      if (e is DioError) {
        erorLength += 1;
        if (e.response!.statusCode == 401)
          return await RefreshTokenApi.instance
              .postRefreshToken()
              .then((value) async => await getExchangeRates(context));
      }
    }

    throw Exception("hato");
  }

  Future<AccountsModel> getAccounts(BuildContext context) async {
    try {
      AccountsModel responsExchangeRates =
          await AccountsApi.instance.getAcounts(context);
      return responsExchangeRates;
    } catch (e) {
      if (e is DioError) {
        erorLength += 1;
        if (e.response!.statusCode == 401)
          return await RefreshTokenApi.instance
              .postRefreshToken()
              .then((value) async => await getAccounts(context));
      }
    }

    throw Exception("hato");
  }

  Future<CardsBalancesModel> postClientBalances(BuildContext context) async {
    try {
      responseCardsBalances =
          await CardsBalancesService.instance.postCardsBalaces(cardList);
      return responseCardsBalances!;
    } catch (e) {
      erorLength += 1;
      throw e;
    }
  }

  String cardsBalances(String text, int index) {
    return responseCardsBalances == null
        ? changeAllText(text)
        : changeAllText(
            responseCardsBalances!.data!.balances![index].balance!.toString());
  }

  reciverPan(String cardNumber) {
    String card = "";

    for (var i = 0; i < cardNumber.length; i++) {
      if (i > 7) {
        card += cardNumber[i];
      }
    }

    return card;
  }

  smallCardNumber(String cardNumber) {
    String card = " ";
    for (var i = 5; i > 0; i--) {
      if (i > 0) {
        card += cardNumber[cardNumber.length - i];
      }
      if (i == 5) {
        card += " ";
      }
    }
    return card;
  }
}
