import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mobile/core/network/dio/dio_client.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/exchange_rates_model.dart';
import 'package:mobile/models/loans_model.dart';
import 'package:mobile/service/api_service/refref_token_api.dart';
import 'package:mobile/core/extensions/context_extension.dart';

class ExchangeRates {
  static final ExchangeRates _instance = ExchangeRates._init();
  static ExchangeRates get instance => _instance;
  Future<ExchangeRatesModel> getExchangeRates(BuildContext context) async {
    try {
      final response =
          await DioClient.instance.get(Endpoints.baseUrl + Endpoints.valuta,
              options: Options(
                headers: Endpoints.headers(),
              ));
      return ExchangeRatesModel.fromJson(response);
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == 401) {
          await RefreshTokenApi.instance
              .postRefreshToken()
              .then((value) => context.homePr.getP2PLast(context));
        }
      }
      throw e;
    }
  }

  ExchangeRates._init();
}
