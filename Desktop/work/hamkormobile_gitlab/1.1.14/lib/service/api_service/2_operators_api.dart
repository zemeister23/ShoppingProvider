import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:mobile/core/network/dio/dio_client.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/operators_model.dart';

class OperatorsApi {
  static final OperatorsApi _instance = OperatorsApi._init();
  static OperatorsApi get instance => _instance;
  Future<OperatorsModel> getOperators() async {
    try {
      final response = await DioClient.instance
          .get('${Endpoints.baseUrl}${Endpoints.operators}');

      return OperatorsModel.fromJson(response);
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == 400) {}
      }
      throw e;
    }
  }

  OperatorsApi._init();
}
