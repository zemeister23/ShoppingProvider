import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_name_box.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_service.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/core/network/dio/dio_client.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/client_name_model.dart';
import 'package:mobile/models/refresh_token_model.dart';
import 'package:mobile/service/api_service/refref_token_api.dart';
import 'package:mobile/core/extensions/context_extension.dart';

class ClientNameApi {
  static final ClientNameApi _instance = ClientNameApi._init();
  static ClientNameApi get instance => _instance;
  Future<ClientNameModel> getClientNameService(BuildContext context) async {
    try {
      final response = await DioClient.instance.get(
          Endpoints.baseUrl + Endpoints.clientName,
          options: Options(headers: Endpoints.headers()));
      ClientNameModel data = ClientNameModel.fromJson(response);
      ClientNameModel hiveData = await HiveService.instance.writeData(
          encKey: Endpoints.clientName,
          boxName: HiveBoxName.CLIENT_NAME,
          data: data);
      return hiveData;
    } catch (e) {
      if (e is DioError) {
        FirebaseCrashlytics.instance.log(e.response!.data.toString());
      }
      throw e;
    }
  }

  ClientNameApi._init();
}
