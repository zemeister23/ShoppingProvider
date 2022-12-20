import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_name_box.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_service.dart';
import 'package:mobile/core/network/dio/dio_client.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/deposits_model.dart';
import 'package:mobile/service/api_service/refref_token_api.dart';
import 'package:mobile/core/extensions/context_extension.dart';
class DepositsApi {
  static final DepositsApi _instance = DepositsApi._init();
  static DepositsApi get instance => _instance;
  Future<Depositsmodel> getDeposits(BuildContext context) async {
    try {
      final response = await DioClient.instance.get(
        Endpoints.baseUrl + Endpoints.deposits,
        options: Options(
          headers: Endpoints.headers(),
        ),
      );
      Depositsmodel data = Depositsmodel.fromJson(response);
      Depositsmodel hiveData = await HiveService.instance.writeData(
          encKey: Endpoints.deposits,
          boxName: HiveBoxName.DEPOSITS,
          data: data);
      return hiveData;
    } catch (e) {
      if (e is DioError) {
        FirebaseCrashlytics.instance.log(e.response!.data.toString());
        if (e.response!.statusCode == 401) {
          await RefreshTokenApi.instance
              .postRefreshToken()
              .then((value) => context.homePr.getP2PLast(context));
        }
      }
      throw e;
    }
  }
  DepositsApi._init();
}
