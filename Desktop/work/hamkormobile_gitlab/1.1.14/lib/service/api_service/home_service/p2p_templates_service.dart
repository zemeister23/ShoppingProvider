import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/network/dio/dio_client.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/p2p_last_model.dart';
import 'package:mobile/models/p2p_templates_model.dart';
import 'package:mobile/service/api_service/refref_token_api.dart';
import 'package:mobile/core/extensions/context_extension.dart';

class P2pTemplatesAp {
  static final P2pTemplatesAp _instance = P2pTemplatesAp._init();
  static P2pTemplatesAp get instance => _instance;
  Future<P2PTemplatesModel> getP2pTemplates(BuildContext context) async {
    try {
      final response = await DioClient.instance.get(
        Endpoints.baseUrl + Endpoints.p2pTemplates,
        options: Options(
          headers: Endpoints.headers(),
        ),
      );

      return P2PTemplatesModel.fromJson(response);
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == 401) {
          await RefreshTokenApi.instance
              .postRefreshToken()
              .then((value) => context.homePr.getP2pTemplates(context));
        }
      }
      throw e;
    }
  }

  P2pTemplatesAp._init();
}
