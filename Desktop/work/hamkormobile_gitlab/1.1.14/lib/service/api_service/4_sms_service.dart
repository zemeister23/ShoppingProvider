import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobile/core/constants/error/alert_error.dart';
import 'package:mobile/core/constants/navigation/navigation_constant.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/core/network/dio/dio_client.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/sms_post_model.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/service/api_service/refref_token_api.dart';
import 'package:provider/provider.dart';

import '../../provider/3_sms_provider.dart';
import '../../widgets/dialogs/error_dialog.dart';
import 'package:mobile/core/extensions/context_extension.dart';

class SmsSerVice {
  static final SmsSerVice _instance = SmsSerVice._init();
  static SmsSerVice get instance => _instance;
  Future<SmsPostModel> postSms(
      String code, bool smsRegisterPage, BuildContext context) async {
    var _data = {
      "code": code,
      "device_id": GetStorageService.instance.box
          .read(GetStorageService.instance.deviceInfo),
      "device_info":
          GetStorageService.instance.box.read(GetStorageService.instance.model),
      "lang_id": GetStorageService.instance.box
          .read(GetStorageService.instance.language),
      "sign_id": GetStorageService.instance.box
          .read(GetStorageService.instance.signId),
    };
    if (!smsRegisterPage) {
      try {
        var response = await Dio().post(
          Endpoints.baseUrl + Endpoints.clientRegistration,
          data: _data,
          options: Options(
            headers: Endpoints.headers(),
          ),
        );
        if (response.statusCode == 200) {
          await GetStorageService.instance.box
              .write(GetStorageService.instance.isAuthenticated, true);
          context.smsPr.stopTimer();
          await context.introPr.changeLoadingState(false);
          context.loaderOverlay.hide();
          await NavigationService.instance
              .pushNamedRemoveUntil(routeName: "/home"); //  return;
        }
      } catch (e) {
        context.loaderOverlay.hide();
        if (e is DioError) {
          if (e.response!.statusCode == 401) {
            return await RefreshTokenApi.instance.postRefreshToken().then(
                (value) async => await postSms(code, smsRegisterPage, context));
          }
        }
      }
    }
    try {
      final response = await DioClient.instance.post(
        '${Endpoints.baseUrl}${Endpoints.finishRegistration}',
        data: _data,
      );
      SmsPostModel _response = await SmsPostModel.fromJson(response);
      if (_response.data!.refreshToken!.isEmpty) {
        NavigationService.instance
            .pushNamedRemoveUntil(routeName: NavigationConst.INTRO_PAGE_VIEW);
      }
      await GetStorageService.instance.box
          .write(GetStorageService.instance.accessToken,
              "${_response.data!.accessToken}")
          .then((value) async {
        await GetStorageService.instance.box
            .write(GetStorageService.instance.refreshToken,
                "${_response.data!.refreshToken}")
            .then((value) => print(""))
            .then((value) async {
          context.loaderOverlay.hide();
          return await _response;
        });
      });
      context.loaderOverlay.hide();
      return await _response;
    } catch (e) {
      context.loaderOverlay.hide();
      if (e is DioError) {}
      throw e;
    }
  }

  _dialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const ErrorDialog(
            positionTopContainer: 3.23,
            sizeHeightPainer: 3.5,
            title: "",
            subtitle:
                "Превышено количество запросов. Повторите попытку через 15 минут.",
            buttonTextBottom: "Понятно");
      },
    );
  }

  SmsSerVice._init();
}
