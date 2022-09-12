import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobile/core/constants/error/alert_error.dart';
import 'package:mobile/core/network/dio/dio_client.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/p2p_confirm_model.dart';
import 'package:mobile/models/p2p_sucses_validate.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/widgets/dialogs/error_dialog.dart';

class P2PConfirmApi {
  static final P2PConfirmApi _instance = P2PConfirmApi._init();
  static P2PConfirmApi get instance => _instance;
  Future postPaymentConfirm(BuildContext context,
      P2PValidateSucsesModel p2pValidateResponse, String smsCode) async {
    var data = {
      "confirm_code": smsCode.toString(),
      "sign_id": context.transactionsPr.signId,
      "transact_id": p2pValidateResponse.data!.transactId.toString()
    };
    try {
      final response = await Dio().post(
        Endpoints.baseUrl + Endpoints.p2pConfirm,
        options: Options(headers: Endpoints.headers()),
        data: data,
      );
      context.loaderOverlay.hide();
      return P2PConfirmModel.fromJson(response.data);
    } catch (e) {
      context.loaderOverlay.hide();
      if (e is DioError) {
        if (e.response!.statusCode == 500) {
          Navigator.pop(context);
          if (smsCode != "") {
            context.smsPr.erorColor = true;
            context.smsPr.changeCapacity();
            context.smsPr.erorTextState(
              true,
            );
            if (context.smsPr.capacity == 0) {
              context.smsPr.stopTimer();
              _dialog(context);
            }
          } else {
            await ErrorMessage.instance
                .translationsEror(e.response!.data!["error_code"], context);
          }
        }

        throw e;
      }
    }
  }

  P2PConfirmApi._init();

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
          buttonTextBottom: "Понятно",
        );
      },
    );
  }
}
