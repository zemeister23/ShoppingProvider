import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:mobile/core/network/dio/dio_client.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/language_model.dart';

class LanguageApi {
  static final LanguageApi _instance = LanguageApi._init();
  static LanguageApi get instance => _instance;
  Future<LanguageModel> getLanguageModel({String? username}) async {
    try {
      final response = await DioClient.instance.get(Endpoints.language);

      return LanguageModel.fromJson(response);
    } catch (e) {
      if (e is DioError) {}
      throw e;
    }
  }

  LanguageApi._init();
}
