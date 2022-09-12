import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/network/dio/dio_client.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/acounts_model.dart';
import 'package:mobile/models/client_cards_model.dart';
import 'package:mobile/service/api_service/refref_token_api.dart';
import 'package:mobile/core/extensions/context_extension.dart';

class AccountsApi {
  static final AccountsApi _instance = AccountsApi._init();
  static AccountsApi get instance => _instance;
  Future<AccountsModel> getAcounts(BuildContext context) async {
    try {
      final response = await DioClient.instance.get(
          Endpoints.baseUrl + Endpoints.accounts,
          options: Options(headers: Endpoints.headers()));
      return AccountsModel.fromJson(response);
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == 401) {
          await RefreshTokenApi.instance
              .postRefreshToken()
              .then((value) => context.homePr.getAccounts(context));
        }
      }
      throw e;
    }
  }

  AccountsApi._init();
}
