import 'package:dio/dio.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/models/client_cards_model.dart';
import 'package:mobile/models/client_name_model.dart';
import 'package:mobile/models/history_model.dart';
import 'package:mobile/service/api_service/13_history_service.dart';
import 'package:mobile/service/api_service/home_service/client_name_service.dart';
import 'package:mobile/service/api_service/refref_token_api.dart';

class HistoryProvider extends ChangeNotifier {
  void refreshData() {
    notifyListeners();
  }

  Trace _trace = FirebasePerformance.instance.newTrace('payment_story');

  Future<HistoryModel> postHistory(BuildContext context) async {
    _trace.start();
    try {
      List cardList = [];
      ClientCardsModel data = await context.homePr.getClientCards(context);
      if (data.data!.cards!.isNotEmpty) {
        for (var i = 0; i < data.data!.cards!.length; i++) {

          cardList.add({
            "id": data.data!.cards![i].cardId!,
            "ps_code": data.data!.cards![i].psCode!
          });
        }
      }
      HistoryModel response = await HistoryApi.instance.postHistory(cardList);
      _trace.stop();
      return response;
    } catch (e) {
      _trace.stop();
      throw e;
    }
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

  smallCardNumber(String cardNumber) {
    String card = " *";
    for (var i = 4; i > 0; i--) {
      if (i > 0) {
        card += cardNumber[cardNumber.length - i];
      }
      if (i == 5) {
        card += " ";
      }
    }
    return card;
  }

  String changeTimeText(String data) {
    try {
      if (data.isEmpty || data == " ") {
        return "";
      } else {
        List temp = data.split(" ");
        temp = temp[0].toString().split("-");
        String day = temp[2].toString().split("T")[0];

        return "$day ${intToString(temp[1])}";
      }
    } catch (e) {
      return "";
    }
  }
}
