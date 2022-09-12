import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:mobile/core/network/dio/dio_client.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/language_model.dart';
import 'package:mobile/models/operators_model.dart';
import 'package:mobile/models/translations_model.dart';

class TranslationsApi {
  static final TranslationsApi _instance = TranslationsApi._init();
  static TranslationsApi get instance => _instance;
  Future<TransactionModel> getTranlation() async {
    try {
      final response = await DioClient.instance.get(
        Endpoints.baseUrl + Endpoints.translations,
        options: Options(headers: Endpoints.headers()),
      );
      return TransactionModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  TranslationsApi._init();
}
