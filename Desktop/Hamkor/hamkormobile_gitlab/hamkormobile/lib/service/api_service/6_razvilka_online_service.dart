import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/core/network/dio/dio_client.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/razvilka_model.dart';
import 'package:mobile/provider/7_razvilka_provider.dart';
import 'package:mobile/service/api_service/refref_token_api.dart';
import 'package:provider/provider.dart';

class RazvilkaApi {
  static final RazvilkaApi _instance = RazvilkaApi._init();
  static RazvilkaApi get instance => _instance;
  Future<RazvilkaModel> getRazvilka(BuildContext context) async {
    try {
      final response = await DioClient.instance
          .get('${Endpoints.baseUrl}${Endpoints.razvilka}',
              options: Options(
                headers: Endpoints.headers(),
              ));

      return RazvilkaModel.fromJson(response);
    } catch (e) {
      if (e is DioError) {
        FirebaseCrashlytics.instance.log(e.response!.data.toString());
        
        if (e.response!.statusCode == 401) {
          return await RefreshTokenApi.instance
              .postRefreshToken()
              .then((value) async => await getRazvilka(context));
        }
      }

      throw e;
    }
  }

  RazvilkaApi._init();
}
