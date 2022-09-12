import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/core/network/dio/dio_client.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/add_card_model.dart';
import 'package:mobile/models/razvilka_model.dart';
import 'package:mobile/models/refresh_token_model.dart';

class RefreshTokenApi {
  final GetStorage _getStoregee = GetStorage();
  static final RefreshTokenApi _instance = RefreshTokenApi._init();
  static RefreshTokenApi get instance => _instance;

  Future<bool> postRefreshToken() async {
    String _refreshToken =
        await _getStoregee.read(GetStorageService.instance.refreshToken);
    String _deviceId =
        await _getStoregee.read(GetStorageService.instance.deviceInfo);
    var _data = {
      "device_id": _deviceId,
      "token": _refreshToken,
    };

    try {
      final response = await DioClient.instance.post(
        '${Endpoints.baseUrl}${Endpoints.refresh}',
        data: _data,
      );
      RefreshTokenModel _response = await RefreshTokenModel.fromJson(response);
      await GetStorageService.instance.box.write(
          GetStorageService.instance.accessToken, _response.data!.accessToken);
      await GetStorageService.instance.box.write(
        GetStorageService.instance.refreshToken,
        _response.data!.refreshToken,
      );
      return true;
    } on DioError catch (e) {
      if (e.error is SocketException) {
        return false;
      }
      return false;
    }
  }

  RefreshTokenApi._init();
}
