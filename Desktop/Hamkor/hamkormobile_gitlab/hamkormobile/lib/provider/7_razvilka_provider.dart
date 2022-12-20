import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobile/core/constants/error/alert_error.dart';
import 'package:mobile/models/razvilka_model.dart';
import 'package:mobile/models/store_action_model.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/service/api_service/6_razvilka_online_service.dart';
import 'package:mobile/service/api_service/hamkorstore_service/store_action_service.dart';
import 'package:mobile/service/api_service/refref_token_api.dart';
import 'package:provider/provider.dart';

class RazvilkaProvider extends ChangeNotifier {
  StoreActionModel? _storeActionData;
  StoreActionModel get storeActionData => _storeActionData!;
  int action = 0;
  bool isBioService = false;
  Future<StoreActionModel> getStoreAction(BuildContext context) async {
    try {
      StoreActionModel storeActionData =
          await StoreActionService.instance.getStoreAction(context);
      action = await storeActionData.data!.action!;

      return storeActionData;
    } catch (e) {
      if (e is DioError) {
        FirebaseCrashlytics.instance.log(e.response!.data.toString());
        if (e.response!.statusCode == 500) {
          ErrorMessage.instance
              .translationsEror(e.response!.data["error_code"], context);
        }
      }
      return throw e;
    }
  }
}
