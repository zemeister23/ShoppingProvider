import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';

import 'package:mobile/core/network/dio/dio_client.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/store_action_model.dart';
import 'package:mobile/service/api_service/refref_token_api.dart';

class StoreActionService {
  static final StoreActionService _instance = StoreActionService._init();
  static StoreActionService get instance => _instance;
  Future<StoreActionModel> getStoreAction(BuildContext context) async {
    try {
      final response = await DioClient.instance
          .get('${Endpoints.baseUrl}${Endpoints.storeAction}',
              options: Options(
                headers: Endpoints.headers(),
              ));
      
      
      return await StoreActionModel.fromJson(response);
    } catch (e) {
      if (e is DioError) {
        FirebaseCrashlytics.instance.log(e.response!.data.toString());
        if (e.response!.statusCode == 401) {
          return await RefreshTokenApi.instance
              .postRefreshToken()
              .then((value) async => await getStoreAction(context));
        }
      }
      throw e;
    }
  }

  StoreActionService._init();
}
