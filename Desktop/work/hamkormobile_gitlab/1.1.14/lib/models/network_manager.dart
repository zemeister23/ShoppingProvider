import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mobile/core/constants/api/api_constants.dart';
import 'package:mobile/core/constants/enums/locale_keys_enums.dart';
import 'package:mobile/core/init/cache/locale_manager.dart';
import 'package:mobile/core/network/network_model.dart/base_model.dart';

class NetwrokManeger {
  static final NetwrokManeger _instance = NetwrokManeger._init();
  static NetwrokManeger get instance => _instance;

  NetwrokManeger._init() {
    final baseOptions = BaseOptions(
      baseUrl: ApiConst.BASE_URL,
      headers: {
        "Authorization": "Bearer " +
            LocaleManager.instance.getStringValue(PreferenceKeys.TOKEN)!
      },
    );
    _dio = Dio(baseOptions);
    _dio!.interceptors.add(
      InterceptorsWrapper(
        onError: (e, m) {},
        onRequest: (e, m) {},
      ),
    );
  }

  Dio? _dio;

  Future GET<T extends BaseModel>(String path, T model) async {
    Response response = await _dio!.get(path);
    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseBody = response.data;
        if (responseBody is List) {
          return responseBody.map((e) => model.fromJson(e)).toList();
        } else if (responseBody is Map) {
          return model.fromJson(responseBody);
        }
        return responseBody;
    }
  }

  Future POST({required String path, required dynamic data}) async {
    await _dio!.post(path, data: data);
  }
}
