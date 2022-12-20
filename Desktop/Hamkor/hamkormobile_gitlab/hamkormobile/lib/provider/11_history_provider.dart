import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
// import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/constants/error/alert_error.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_name_box.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_service.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/cards_operations_model.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
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
  List<HistoryOperation> datum = [];
  List<String> cardList = [];
  Set setData  = {};

  Future<List<HistoryOperation>> cardsOperations(BuildContext context) async {
     DateTime dtm1 = DateTime.fromMillisecondsSinceEpoch(Timestamp.now().millisecondsSinceEpoch);
 datum = [];
      String startDate =
          DateTime.utc(dtm1.year, dtm1.month  -1, dtm1.day +1)
              .toString()
              .split(" ")
              .first;
      String endDate =
          DateTime.utc(DateTime.now().year, DateTime.now().month, dtm1.day)
              .toString()
              .split(" ")
              .first;
    //  _trace.start();
    try {
      
      
      List<String> cardsID = await cardListSort(context);
      
      CardsOperationsModel response = await HistoryApi.instance
          .cardsOperations(cardsID, startDate.toString(), endDate.toString());
      await sortData(response);
    
    await HiveService.instance.writeData(
          encKey: Endpoints.cardsOperations,
          boxName: HiveBoxName.CARDS_OPERATIONS,
          data: datum);
      return   datum;
    } catch (e) {
      //   _trace.stop();
      
      if(e is DioError){
        if(e.response!.statusCode == 500){
          return ErrorMessage.instance.translationsEror(1001, context);
        }
      }
      return  throw Exception(e);
    }
  }
  cardListSort(BuildContext context) async {
    cardList = [];
    ClientCardsModel data;
    try {
      data = await HiveService.instance.readBox(
          encKey: Endpoints.clientCards, boxName: HiveBoxName.CLIENT_CARDS);
    } catch (e) {
      data = await context.homePr.getClientCards(context, true);
    }
    if (data.data!.cards!.isNotEmpty) {
      for (var i = 0; i < data.data!.cards!.length; i++) {
     
        cardList.add(
          data.data!.cards![i].cardId!.toString(),
        );
      }
    }
    
    return cardList;
  }
  Future sortData(CardsOperationsModel response) async {
       setData = {};
    try {
      for (var i = 0; i < response.data!.length; i++) {
    
        for (var j = 0; j < response.data![i].operations!.length; j++) {
          
           setData.add(changeTimeText(response.data![i].operations![j].operationTime!.toString()));
           datum.add(response.data![i].operations![j]);
        }
        
      }
    } catch (e) {
      
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
