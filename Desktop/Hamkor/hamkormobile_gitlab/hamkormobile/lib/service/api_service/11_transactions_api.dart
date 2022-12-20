import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_name_box.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_service.dart';
import 'package:mobile/core/network/dio/dio_client.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/language_model.dart';
import 'package:mobile/models/operators_model.dart';
import 'package:mobile/models/transactions_model.dart';

import '../../models/p2p_template_model.dart';

class TranslationsApi {
  static final TranslationsApi _instance = TranslationsApi._init();
  static TranslationsApi get instance => _instance;

  // If we use the Service in main screen, we need to put one parameter for getting data again and again
  Future<P2PTemplatesModel> getTranlation() async {
    try {
      P2PTemplatesModel hiveData = await HiveService.instance.readBox(
        encKey: Endpoints.p2pTemplates,
        boxName: HiveBoxName.P2PTEMPLATES,
      );
      print("BEFORE THE CATCH");
      return hiveData;
    } catch (e) {
      try {
        final response = await DioClient.instance.get(
          Endpoints.baseUrl + Endpoints.translations,
          options: Options(headers: Endpoints.headers()),
        );
        P2PTemplatesModel data = P2PTemplatesModel.fromJson(response);
        P2PTemplatesModel hiveData = await HiveService.instance.writeData(
          encKey: Endpoints.translations,
          boxName: HiveBoxName.TRANSACTIONS,
          data: data,
        );
        print("AFTER THE CATCH");

        return hiveData;
      } catch (e) {
        throw e;
      }
    }
  }

  TranslationsApi._init();
}
