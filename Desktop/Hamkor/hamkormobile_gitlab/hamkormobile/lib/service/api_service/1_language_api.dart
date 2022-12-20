import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:mobile/core/network/dio/dio_client.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/language_model.dart';

class LanguageApi {
  static final LanguageApi _instance = LanguageApi._init();
  static LanguageApi get instance => _instance;
  Future<LanguageModel> getLanguageModel() async {
    try {
      final response = await DioClient.instance.get(Endpoints.baseUrl +  Endpoints.language);
  
      return LanguageModel.fromJson(response);
    } catch (e) {
        
        
      if (e is DioError) {
        FirebaseCrashlytics.instance.log(e.response!.data.toString());
        
      }
      throw e;
    }
  }
  LanguageApi._init();
}
