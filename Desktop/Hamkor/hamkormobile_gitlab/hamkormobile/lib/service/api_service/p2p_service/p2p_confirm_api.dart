import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile/provider/3_sms_provider.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobile/core/constants/error/alert_error.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/p2p_confirm_model.dart';
import 'package:mobile/models/p2p_sucses_validate.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:provider/provider.dart';

class P2PConfirmApi {
  static final P2PConfirmApi _instance = P2PConfirmApi._init();
  static P2PConfirmApi get instance => _instance;
  Future postPaymentConfirm(BuildContext context,
      P2PValidateSucsesModel p2pValidateResponse, String smsCode,
      {bool? senAgain}) async {
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
        FirebaseCrashlytics.instance.log(e.response!.data.toString());

        if (e.response!.statusCode == 500) {
          if (smsCode != "") {
            context.smsPr.erorColor = true;
            context.smsPr.changeCapacity();
            context.smsPr.erorTextState(
              true,
            );
            if (context.smsPr.capacity <= 0) {
              ErrorMessage.instance.translationsEror(1019, context,
                  onTap: () async {
                await context.smsPr.senAgainButton(
                    smstranlationsPage: true,
                    addCardPage: false,
                    context: context,
                    isAlert: true);
              }, isDisable: true, isSmsScreen: true);
              context.smsPr.stopTimer();
              context.smsPr.startTimerBlock(minut: 15);
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
}
