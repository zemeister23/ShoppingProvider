import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/constants/error/alert_error.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_name_box.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_service.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:mobile/core/init/cache/secure_storege.dart';
import 'package:mobile/core/network/dio/dio_client.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/client_cards_model.dart';
import 'package:mobile/service/api_service/refref_token_api.dart';
import 'package:mobile/core/extensions/context_extension.dart';

class ClientCardsApi {
  static final ClientCardsApi _instance = ClientCardsApi._init();
  static ClientCardsApi get instance => _instance;
  Future<ClientCardsModel> getClientCards(BuildContext context) async {
    try {
      final response = await DioClient.instance.get(
          Endpoints.baseUrl + Endpoints.clientCards,
          options: Options(headers: Endpoints.headers()));
      ClientCardsModel data = ClientCardsModel.fromJson(response);
      
      ClientCardsModel hiveData = await HiveService.instance.writeData(
          encKey: Endpoints.clientCards,
          boxName: HiveBoxName.CLIENT_CARDS,
          data: data);
      return hiveData;
    } catch (e) {
      if (e is DioError) {
        FirebaseCrashlytics.instance.log(e.response!.data.toString());
        FirebaseCrashlytics.instance.log(e.response!.data.toString());
        if (e.response!.statusCode == 401) {
          await RefreshTokenApi.instance
              .postRefreshToken()
              .then((value) => context.homePr.getClientCards(context, true));
        }
      }

      throw e;
    }
  }

  ClientCardsApi._init();
}
