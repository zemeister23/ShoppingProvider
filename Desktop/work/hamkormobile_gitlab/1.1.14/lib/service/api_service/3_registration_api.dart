import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/core/constants/error/alert_error.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/core/network/dio/dio_client.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/phone_registration.dart';

class RegistrationApi {
  static final RegistrationApi _instance = RegistrationApi._init();
  static RegistrationApi get instance => _instance;
  Future<PhoneRegistation> postNumber(
      String number, int value, BuildContext context) async {
    GetStorageService.instance.box
        .write(GetStorageService.instance.language, value == 1 ? "ru" : "uz");
    var _data = {
      "phone": number.toString(),
      "phone_type": "1",
      "device_id": GetStorageService.instance.box
          .read(GetStorageService.instance.deviceInfo),
      "device_info":
          GetStorageService.instance.box.read(GetStorageService.instance.model),
      "device_os": GetStorageService.instance.box
          .read(GetStorageService.instance.systemName),
      "lang_id": GetStorageService.instance.box
          .read(GetStorageService.instance.language),
      "app_version": GetStorageService.instance.box
          .read(GetStorageService.instance.version),
    };

    try {
      final response = await DioClient.instance.post(
        '${Endpoints.baseUrl}${Endpoints.startRegistration}',
        data: _data,
      );

      return PhoneRegistation.fromJson(response);
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == 500) {
          ErrorMessage.instance.translationsEror(
              e.response!.data["error_code"], context,
              text: e.response!.data["error_note"]);
        }

        if (e.response!.data['error_code'] == 1027) {
          ErrorMessage.instance.erorAddCardAlert("1027", context);
          // ErrorMessage.instance.updateVersionAlert("version");
        }
      }
      throw e;
    }
  }

  RegistrationApi._init();
}
