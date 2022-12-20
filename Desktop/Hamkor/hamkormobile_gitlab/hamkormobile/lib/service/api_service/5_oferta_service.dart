import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/core/network/dio/dio_client.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/offerta_model.dart';
import 'package:mobile/service/api_service/refref_token_api.dart';

import '../../models/refresh_token_model.dart';

class OfertaService {
  GetStorage _getStorage = GetStorage();
  static final OfertaService _instance = OfertaService._init();
  static OfertaService get instance => _instance;
  Future<OffertaModel> getOferta() async {
    String _accessToken =
        _getStorage.read(GetStorageService.instance.accessToken);
    final _headers = {"Authorization": "Bearer $_accessToken"};
    try {
      final response = await DioClient.instance
          .get('${Endpoints.baseUrl}${Endpoints.offerta}',
              options: Options(
                headers: _headers,
              ));
      return OffertaModel.fromJson(response);
    } catch (e) {
      if (e is DioError) {
        FirebaseCrashlytics.instance.log(e.response!.data.toString());
        if (e.response!.statusCode == 401) {
          return await RefreshTokenApi.instance
              .postRefreshToken()
              .then((value) async => await getOferta());
        }
      }
      throw e;
    }
  }

  OfertaService._init();
}
