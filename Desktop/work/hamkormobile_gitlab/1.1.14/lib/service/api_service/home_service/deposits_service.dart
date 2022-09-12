import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/core/network/dio/dio_client.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/deposits_model.dart';
import 'package:mobile/models/refresh_token_model.dart';
import 'package:mobile/service/api_service/refref_token_api.dart';
import 'package:mobile/core/extensions/context_extension.dart';

class DepositsApi {
  static final DepositsApi _instance = DepositsApi._init();
  static DepositsApi get instance => _instance;
  Future<Depositsmodel> getDeposits(BuildContext context) async {
    try {
      final response = await DioClient.instance.get(
        Endpoints.baseUrl + Endpoints.deposits,
        options: Options(
          headers: Endpoints.headers(),
        ),
      );
      final data = Depositsmodel.fromJson(response);
      return data;
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

  DepositsApi._init();
}
