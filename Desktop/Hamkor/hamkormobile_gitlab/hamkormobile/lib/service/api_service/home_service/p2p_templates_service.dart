import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_name_box.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_service.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:mobile/core/network/dio/dio_client.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/p2p_last_model.dart';
import 'package:mobile/models/p2p_template_model.dart';
import 'package:mobile/service/api_service/refref_token_api.dart';
import 'package:mobile/core/extensions/context_extension.dart';

class P2pTemplatesAp {
  static final P2pTemplatesAp _instance = P2pTemplatesAp._init();
  static P2pTemplatesAp get instance => _instance;
  Future<P2PTemplatesModel> getP2pTemplates(BuildContext context) async {
    try {
      final response = await DioClient.instance.get(
        Endpoints.baseUrl + Endpoints.p2pTemplates,
        options: Options(
          headers: Endpoints.headers(),
        ),
      );
      P2PTemplatesModel data = P2PTemplatesModel.fromJson(response);

      P2PTemplatesModel hiveData = await HiveService.instance.writeData(
        encKey: Endpoints.p2pTemplates,
        boxName: HiveBoxName.P2PTEMPLATES,
        data: data,
      );

      return hiveData;
    } catch (e) {
      if (e is DioError) {
        FirebaseCrashlytics.instance.log(e.response!.data.toString());
        if (e.response!.statusCode == 401) {
          await RefreshTokenApi.instance
              .postRefreshToken()
              .then((value) => context.homePr.getP2pTemplates(context));
        }
      }
      throw e;
    }
  }

  P2pTemplatesAp._init();
}
