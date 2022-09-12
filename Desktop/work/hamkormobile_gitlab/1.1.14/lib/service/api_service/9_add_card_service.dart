import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobile/core/constants/error/alert_error.dart';
import 'package:mobile/core/constants/navigation/navigation_constant.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/core/network/dio/dio_client.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/add_card_model.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/service/api_service/refref_token_api.dart';
import 'package:mobile/widgets/dialogs/error_dialog.dart';
import 'package:mobile/widgets/new_dialog/alerty_dialog_2.dart';

class AddCardApi {
  static final AddCardApi _instance = AddCardApi._init();
  AddCardApi._init();
  static AddCardApi get instance => _instance;
  Future<AddCardModel> postCard(TextEditingController cardNumber,
      TextEditingController cardExpire, BuildContext context) async {
    var s = cardNumber.text.split(" ");
    String _cardNumber = "";
    s.forEach(((e) {
      _cardNumber += e;
    }));

    var v = cardExpire.text.split("/");
    String _cardExpire = "";
    v.forEach(((e) {
      _cardExpire += e;
    }));
    var _data = {
      "card_number": _cardNumber,
      "date_expire": _cardExpire,
      "device_info":
          GetStorageService.instance.box.read(GetStorageService.instance.model),
      "device_os": GetStorageService.instance.box
          .read(GetStorageService.instance.systemName),
      "app_version": GetStorageService.instance.box
          .read(GetStorageService.instance.version),
    };
    try {
      final response = await DioClient.instance.post(
        '${Endpoints.baseUrl}${Endpoints.addCard}',
        data: _data,
        options: Options(headers: await Endpoints.headers()),
      );
      context.loaderOverlay.hide();
      return AddCardModel.fromJson(response);
    } catch (e) {
      context.loaderOverlay.hide();
      if (e is DioError) {
        if (e.response!.statusCode == 401) {
          return await RefreshTokenApi.instance.postRefreshToken().then(
              (value) async => await postCard(cardNumber, cardExpire, context));
        }
        List _erorList = [];
        _erorList.add(e.response!.data);
        if (e.response!.statusCode == 500) {
          await ErrorMessage.instance
              .erorAddCardAlert(_erorList[0]["error_code"].toString(), context);
        }
      }
      throw e;
    }
  }
}
