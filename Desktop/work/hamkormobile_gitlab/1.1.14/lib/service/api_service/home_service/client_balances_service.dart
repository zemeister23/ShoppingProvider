import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/core/network/dio/dio_client.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/cards_balances_model.dart';
import 'package:mobile/models/history_model.dart';
import 'package:mobile/models/language_model.dart';
import 'package:mobile/models/operators_model.dart';
import 'package:mobile/models/translations_model.dart';
import 'package:mobile/service/api_service/refref_token_api.dart';

class CardsBalancesService {
  static final CardsBalancesService _instance = CardsBalancesService._init();
  static CardsBalancesService get instance => _instance;
  Future<CardsBalancesModel> postCardsBalaces(List cardData) async {
    try {
      List data = cardData;
      final response = await DioClient.instance.post(
        Endpoints.baseUrl + Endpoints.cardsBalances,
        options: Options(headers: Endpoints.headers()),
        data: data,
      );
      return CardsBalancesModel.fromJson(response);
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == 401) {
          await RefreshTokenApi.instance.postRefreshToken().then((value) {
            postCardsBalaces(cardData);
          });
        }
      }
      throw e;
    }
  }

  CardsBalancesService._init();
}
