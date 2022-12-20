import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_name_box.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_service.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:mobile/core/network/dio/dio_client.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/acounts_model.dart';
import 'package:mobile/models/client_cards_model.dart';
import 'package:mobile/service/api_service/refref_token_api.dart';
import 'package:mobile/core/extensions/context_extension.dart';

class AccountsApi {
  static final AccountsApi _instance = AccountsApi._init();
  static AccountsApi get instance => _instance;
  Future<AccountsModel> getAcounts(BuildContext context) async {
    try {
      final response = await DioClient.instance.get(
        Endpoints.baseUrl + Endpoints.accounts,
        options: Options(headers: Endpoints.headers()),
      );
     AccountsModel data =  AccountsModel.fromJson(response);
     AccountsModel hiveData = await HiveService.instance.writeData(encKey: Endpoints.accounts, boxName: HiveBoxName.ACCOUNTS, data: data) ;
      return  hiveData;
    } catch (e) {
      
      if (e is DioError) {
        FirebaseCrashlytics.instance.log(e.response!.data.toString());
        if (e.response!.statusCode == 401) {
          await RefreshTokenApi.instance
              .postRefreshToken()
              .then((value) => context.homePr.getAccounts(context));
        }
      }
      throw Exception("ERORE");
    }
  }

  AccountsApi._init();
}
