import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/constants/navigation/navigation_constant.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/models/language_model.dart';
import 'package:mobile/models/operators_model.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/service/api_service/1_language_api.dart';
import 'package:mobile/service/api_service/2_operators_api.dart';

class IntroProvider extends ChangeNotifier {
  bool status = false;
  late LanguageModel _language;
  LanguageModel get langugage => _language;
  late OperatorsModel _operators;
  OperatorsModel get operators => _operators;
  var intirnetStatus;
  bool loading = false;

  changeLoadingState(bool state) {
    loading = state;
    notifyListeners();
  }

  Future<void> getLanguage({String? username, BuildContext? ctx}) async {
    try {
      final LanguageModel response =
          await LanguageApi.instance.getLanguageModel(username: username);
      _language = response;
    } catch (e) {
      if (e is DioError) {}
    }
  }

  Future<void> getOperators() async {
    try {
      final response = await OperatorsApi.instance.getOperators();
      _operators = response;

      NavigationService.instance.pushNamedRemoveUntil(
          routeName: (await GetStorageService.instance.box
                          .read(GetStorageService.instance.isAuthenticated) !=
                      null &&
                  await GetStorageService.instance.box
                      .read(GetStorageService.instance.isAuthenticated))
              ? "/home"
              : "/2_registration");
    } catch (e) {
      if (e is DioError) {}
    }
  }

  Future exitApp() async {
    await GetStorageService.instance.box
        .write(GetStorageService.instance.isLockScreenShowed, false);
    await GetStorageService.instance.box
        .write(GetStorageService.instance.isLocked, false);
    await GetStorageService.instance.box.erase();

    await NavigationService.instance
        .pushNamedRemoveUntil(routeName: NavigationConst.INTRO_PAGE_VIEW);
  }
}
