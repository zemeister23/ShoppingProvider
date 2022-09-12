import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
      return data;
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == 401) {
          await RefreshTokenApi.instance
              .postRefreshToken()
              .then((value) => context.homePr.getClientName(context));
        }
      }
      throw e;
    }
  }

  ClientCardsApi._init();
}
