import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:mobile/core/network/dio/dio_client.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/bancomates_model.dart';
import 'package:mobile/service/api_service/refref_token_api.dart';
import 'package:mobile/core/extensions/context_extension.dart';

class BancomatesApi {
  static final BancomatesApi _instance = BancomatesApi._init();
  static BancomatesApi get instance => _instance;
  Future<BancomatesModel> getBancomates(BuildContext context) async {
    try {
      final response = await DioClient.instance.get(
        Endpoints.baseUrl + Endpoints.bancomates,
        options: Options(headers: Endpoints.headers()),
      );
      

      return BancomatesModel.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      
      
      
      
      if (e is DioError) {
        FirebaseCrashlytics.instance.log(e.response!.data.toString());
        if (e.response!.statusCode == 401) {
          return await RefreshTokenApi.instance
              .postRefreshToken()
              .then((value) async => await getBancomates(context));
        }
      }
      throw e;
    }
  }

  BancomatesApi._init();
}
