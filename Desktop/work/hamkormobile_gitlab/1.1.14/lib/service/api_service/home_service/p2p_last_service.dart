import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/network/dio/dio_client.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/p2p_last_model.dart';
import 'package:mobile/service/api_service/refref_token_api.dart';
import 'package:mobile/core/extensions/context_extension.dart';

class P2PLastApi {
  static final P2PLastApi _instance = P2PLastApi._init();
  static P2PLastApi get instance => _instance;
  Future<P2PLastModel> getP2PLast(BuildContext context) async {
    try {
      final response =
          await DioClient.instance.get(Endpoints.baseUrl + Endpoints.p2pLast,
              options: Options(
                headers: Endpoints.headers(),
              ));

      return P2PLastModel.fromJson(response);
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

  P2PLastApi._init();
}
