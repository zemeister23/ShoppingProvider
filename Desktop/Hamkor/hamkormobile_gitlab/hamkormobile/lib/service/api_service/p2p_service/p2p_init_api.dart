import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:mobile/core/constants/error/alert_error.dart';
import 'package:mobile/core/network/dio/dio_client.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/p2p_confirm_model.dart';
import 'package:mobile/models/p2p_init_model.dart';
import 'package:mobile/models/p2p_sucses_validate.dart';
import 'package:mobile/core/extensions/context_extension.dart';

class P2pInitApi {
  static final P2pInitApi _instance = P2pInitApi._init();
  static P2pInitApi get instance => _instance;
  Future postP2pInit(
    BuildContext context,
  ) async {
    
    Map<String, dynamic> data = {
      "action": "approve",
      "transact_id": context.transactionsPr.transactId,
    };
    try {
      
      final response = await DioClient.instance.post(
        Endpoints.baseUrl + Endpoints.p2pInit,
        options: Options(headers: Endpoints.headers()),
        data: data,
      );
      
      //context.smsPr.duration.inSeconds == 00 ? state = true : state = false;

      return P2PInitModel.fromJson(response);
    } catch (e) {
      
      if (e is DioError) {
        
        
        FirebaseCrashlytics.instance.log(e.response!.data.toString());
        
      
      }
      return throw e;
    }
  }

  P2pInitApi._init();
}
