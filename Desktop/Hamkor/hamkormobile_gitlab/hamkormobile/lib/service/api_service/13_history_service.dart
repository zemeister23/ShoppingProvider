import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_name_box.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_service.dart';
import 'package:mobile/core/network/dio/dio_client.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/cards_operations_model.dart';
import 'package:mobile/models/history_model.dart';
import 'package:mobile/models/language_model.dart';
import 'package:mobile/models/operators_model.dart';
import 'package:mobile/models/transactions_model.dart';
import 'package:mobile/service/api_service/refref_token_api.dart';

class HistoryApi {
  static final HistoryApi _instance = HistoryApi._init();
  static HistoryApi get instance => _instance;
  Future<HistoryModel> postHistory(List cardData) async {
    try {
      var data = {"cards": cardData};
      final response = await DioClient.instance.post(
        Endpoints.baseUrl + Endpoints.history,
        options: Options(headers: Endpoints.headers()),
        data: data,
      );

      return HistoryModel.fromJson(response);
    } catch (e) {
      if (e is DioError) {
        FirebaseCrashlytics.instance.log(e.response!.data.toString());

        if (e.response!.statusCode == 401) {
          await RefreshTokenApi.instance.postRefreshToken().then((value) {
            postHistory(cardData);
          });
        }
      }
      throw e;
    }
  }

  Future<CardsOperationsModel> cardsOperations(
      List<String> cardData, String startDate, String endDdate) async {
    
    
    
    try {
      
      var data = {
        "card_ids": cardData,
        "end_date": endDdate,
        "start_date": startDate
      };

     
      
      final response = await DioClient.instance.post(
        Endpoints.baseUrl + Endpoints.cardsOperations,
        options: Options(headers: Endpoints.headers()),
        data: data,
      );
    
      
      CardsOperationsModel beckData =
          await CardsOperationsModel.fromJson(response);
      return beckData;
    } catch (e) {
      
      // 
      if (e is DioError) {
        
        FirebaseCrashlytics.instance.log(e.response!.data.toString());
        if (e.response!.statusCode == 401) {
          await RefreshTokenApi.instance.postRefreshToken().then((value) {
            cardsOperations(cardData, startDate, endDdate);
          });
        }
      }
      throw e;
    }
  }

  HistoryApi._init();
}
