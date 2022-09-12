import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/core/network/dio/dio_client.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/history_model.dart';
import 'package:mobile/models/language_model.dart';
import 'package:mobile/models/operators_model.dart';
import 'package:mobile/models/translations_model.dart';
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
        if (e.response!.statusCode == 401) {
          await RefreshTokenApi.instance.postRefreshToken().then((value) {
            postHistory(cardData);
          });
        }
      }
      throw e;
    }
  }

  HistoryApi._init();
}
