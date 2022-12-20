import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_name_box.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_service.dart';
import 'package:mobile/core/init/cache/secure_storege.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/widgets/new_dialog/alerty_dialog_2.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:mobile/core/constants/error/alert_error.dart';
import 'package:mobile/core/constants/navigation/navigation_constant.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/models/language_model.dart';
import 'package:mobile/models/operators_model.dart';
import 'package:mobile/provider/2_registration_provider.dart';
import 'package:mobile/provider/9_home_provider.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/service/api_service/1_language_api.dart';
import 'package:mobile/service/api_service/2_operators_api.dart';
import 'package:provider/provider.dart';

class IntroProvider extends ChangeNotifier {
  bool status = false;
  late LanguageModel _language;
  LanguageModel get langugage => _language;
  late OperatorsModel _operators;
  OperatorsModel get operators => _operators;
  var intirnetStatus;
  bool loading = false;
  bool isOnTap = true;
  bool _isButtonPressed = false;
  int currentView = 0;

  bool sentRequest = false;
  //  isRequest(Future request)async{
  //   sentRequest = false;
  //  await request.then((value){
  //   sentRequest = true;
  //   });
  
  // }

  changeOnTap(bool state) {
    isOnTap = state;
    notifyListeners();
  }

  changeLoadingState(bool state) {
    loading = state;
    notifyListeners();
  }

  Future<void> getLanguage({String? username, BuildContext? ctx}) async {
    try {
      final LanguageModel response =
          await LanguageApi.instance.getLanguageModel();
      _language = response;
    } catch (e) {
      if (e is DioError) {
        FirebaseCrashlytics.instance.log(e.response!.data.toString());
      }
    }
  }

  Future<void> getOperators(BuildContext context) async {
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
      if (e is DioError) {
        if (e.response!.statusCode == 500) {
          ErrorMessage.instance
              .translationsEror(e.response!.data["error_code"], context);
        }
        FirebaseCrashlytics.instance.log(e.response!.data.toString());
      }
    }
  }

  Future exitApp(BuildContext context) async {
    await HiveService.instance.deleteBox();

    int lang() {
      if (GetStorageService.instance.box
              .read(GetStorageService.instance.language) ==
          "ru") {
        context.setLocale(const Locale("ru", "RU"));
        return 1;
      } else if (GetStorageService.instance.box
              .read(GetStorageService.instance.language) ==
          "uz") {
        context.setLocale(const Locale("uz", "UZ"));
        return 0;
      } else {
        context.setLocale(const Locale("uz", "UZ"));
        return 0;
      }
    }

    Provider.of<RegistrationProvider>(context, listen: false).value = lang();
    Provider.of<HomeProvider>(context, listen: false).cardList = [];

    await GetStorageService.instance.box
        .write(GetStorageService.instance.isLockScreenShowed, false);
    await GetStorageService.instance.box
        .write(GetStorageService.instance.isLocked, false);
    await GetStorageService.instance.box.erase();

    await NavigationService.instance
        .pushNamedRemoveUntil(routeName: NavigationConst.INTRO_PAGE_VIEW);
  }
}
