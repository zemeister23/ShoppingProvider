import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:mobile/core/constants/error/alert_error.dart';
import 'package:mobile/core/network/dio/dio_client.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/p2p_info_model.dart';

class P2pInfoApi {
  static final P2pInfoApi _instance = P2pInfoApi._init();
  static P2pInfoApi get instance => _instance;
  Future<P2PInfoModel> getP2pInfo(
      String cardNumber, BuildContext context) async {
    var s = cardNumber.split(" ");
    String _cardNumber = "";
    s.forEach(((e) {
      _cardNumber += e;
    }));
    try {
      final response = await DioClient.instance
          .get('${Endpoints.baseUrl}${Endpoints.p2pInfo + _cardNumber}',
              options: Options(
                headers: Endpoints.headers(),
              ));
      return P2PInfoModel.fromJson(response);
    } catch (e) {
      if (e is DioError) {
        FirebaseCrashlytics.instance.log(e.response!.data.toString());

        if (e.response!.statusCode == 500) {
          print("---${e.response!.data["error_code"]}---");
          ErrorMessage.instance
              .translationsEror(e.response!.data["error_code"], context);
        }
      }
      throw e;
    }
  }

  P2pInfoApi._init();
}
