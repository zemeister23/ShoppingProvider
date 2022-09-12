import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/core/constants/error/alert_error.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/core/network/dio/dio_client.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/product_store.dart';
import 'package:mobile/models/razvilka_model.dart';
import 'package:mobile/service/api_service/refref_token_api.dart';

class ProductStoreApi {
  static final ProductStoreApi _instance = ProductStoreApi._init();
  static ProductStoreApi get instance => _instance;

  Future<ProductStoreModel> getProductStore(BuildContext context) async {
    try {
      final response = await DioClient.instance
          .get('${Endpoints.baseUrl}${Endpoints.productStore}/1',
              options: Options(
                headers: Endpoints.headers(),
              ));
      return await ProductStoreModel.fromJson(response);
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == 500) {
          return ErrorMessage.instance
              .translationsEror(e.response!.data["errore_code"], context);
        }

        if (e.response!.statusCode == 401)
          return await RefreshTokenApi.instance
              .postRefreshToken()
              .then((value) async => await getProductStore(context));
      }

      throw e;
    }
  }

  ProductStoreApi._init();
}
