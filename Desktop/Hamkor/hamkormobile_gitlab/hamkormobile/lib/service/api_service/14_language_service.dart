import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/core/network/dio/dio_client.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/language_model.dart';
import 'package:mobile/models/operators_model.dart';

class PutLanguageApi {
  static final PutLanguageApi _instance = PutLanguageApi._init();
  static PutLanguageApi get instance => _instance;
  Future putLanguage() async {
    // print(
    //     "DATAAA: ${GetStorageService.instance.box.read(GetStorageService.instance.language)}");
    var data = {
      "device_id": GetStorageService.instance.box
          .read(GetStorageService.instance.deviceInfo),
      "lang_id": GetStorageService.instance.box
          .read(GetStorageService.instance.language)
          .toString()
          .trim(),
    };
    try {
      final response = await DioClient.instance.put(
        Endpoints.baseUrl + Endpoints.postLangugae,
        options: Options(
          headers: Endpoints.headers(),
        ),
        data: data,
      );
      
    } catch (e) {
      throw e;
    }
  }

  PutLanguageApi._init();
}
