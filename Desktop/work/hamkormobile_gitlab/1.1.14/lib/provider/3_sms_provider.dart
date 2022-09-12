import 'dart:async';
import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/error/alert_error.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/service/api_service/4_sms_service.dart';
import 'package:mobile/service/api_service/refref_token_api.dart';
import 'package:mobile/service/auth_service/auth_class.dart';
import 'package:mobile/widgets/dialogs/error_dialog.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import '../core/init/cache/get_storege.dart';

class SmsProvider with ChangeNotifier {
  ValidationItem _smsNumber = ValidationItem(null, null);
  ValidationItem get telNumber => _smsNumber;
  Duration duration = const Duration(minutes: 1);
  List list = [];
  String values = "";
  late bool isShortTitle;
  bool erorColor = false;
  String sms = '111111';
  int capacity = 3;
  String errorMessage = '';
  bool isRed = false;
  String number = "";
  String erorText = "";
  Timer? timerTick;
  int textCapasity = 3;
  bool get isValid {
    if (telNumber.value != null) {
      return true;
    } else {
      return false;
    }
  }

  late Timer _timer;

  int _seconds = 0;
  bool _startEnable = true;
  bool _stopEnable = false;
  bool _continueEnable = false;
  int get seconds => _seconds;
  bool get startEnable => _startEnable;
  bool get stopEnable => _stopEnable;
  bool get continueEnable => _continueEnable;
  void starttTimer() {
    _seconds = 60;
    _startEnable = false;
    _stopEnable = true;
    _continueEnable = false;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        _seconds--;
      } else if (_seconds == 0) {
        _timer.cancel();
      }
      notifyListeners();
    });
  }

  void stopTimer() async {
    if (_startEnable == false) {
      _startEnable = true;
      _continueEnable = true;
      _stopEnable = false;
      _timer.cancel();
    }
    //   notifyListeners();
  }

  void initState(BuildContext context, bool smsRegistrationPage) {
    starttTimer();
    capacity = smsRegistrationPage ? capacity : 3;
    capacity = smsRegistrationPage ? textCapasity : 3;

    erorText = "";
    erorColor = false;
    if (smsRegistrationPage) {
      GetStorageService.instance.box.write(
          GetStorageService.instance.uiTelNomer,
          context.phoneRegisterPr.telNumber.value);
      if (context.phoneRegisterPr.telNumber.value !=
          GetStorageService.instance.box
              .read(GetStorageService.instance.telNomer)) {
        capacity = 3;
        textCapasity = 3;
      }
    }
    ;
  }

  textButtonActiv() {
    textCapasity -= 1;

    notifyListeners();
  }

  activColor() {
    if (erorColor) {
      if (values.isEmpty) {
        erorColor = false;
        return ColorConst.instance.kPrimaryColor;
      }
      return ColorConst.instance.kErrorColor;
    } else {
      return ColorConst.instance.kPrimaryColor;
    }
  }

  invalidSmS() {
    if (capacity != 0) {
      if (values.length == 6) {
        return erorText.toString();
      } else {
        return "";
      }
    } else if (capacity == 0) {
      return erorText = '';
    } else {
      return "";
    }
  }

  disposee() {
    erorColor = false;
    stopTimer();
    erorColor = false;
    isRed = false;
  }

  changeCapacity() {
    if (capacity <= 3 && capacity > 0) {
      capacity -= 1;
    } else {}
    notifyListeners();
  }

  erorTextState(bool state) {
    if (state) {
      erorText = "sms_code_invalid".locale + " " + "${capacity}";
    } else {
      erorText = "";
    }
    notifyListeners();
  }

  void erorColorState(String v) {
    if (v.isEmpty) {
      if (list.isEmpty) {
        erorColor = false;
      }
    } else {
      //  erorColor = false;
    }
    notifyListeners();
  }

  void changsSms(String value) {
    values = value;
    if (value == sms) {
      isRed = false;
      number = value;
      _smsNumber = ValidationItem(value, null);
      notifyListeners();
    } else {}
    notifyListeners();
  }

  Future<void> postSms(
      String code, BuildContext context, bool smsRegisterPage) async {
    if (_seconds != 0) {
      try {
        await SmsSerVice.instance.postSms(code, smsRegisterPage, context);

        smsRegisterPage ? smsRegisterNavigate(context) : null;
      } catch (e) {
        context.loaderOverlay.hide();
        if (e is DioError) {
          if (e.response!.statusCode == 401) {
            return await RefreshTokenApi.instance.postRefreshToken().then(
                  (value) async => await postSms(
                    code,
                    context,
                    smsRegisterPage,
                  ),
                );
          }
          ;
          if (e.response!.statusCode == 500) {
            erorColor = true;
            changeCapacity();
            erorTextState(
              true,
            );
            if (capacity <= 0) {
              context.smsPr.stopTimer();
              ErrorMessage.instance
                  .translationsEror(e.response!.data["error_code"], context);
            }
          }
        }
      }
    } else {
      context.loaderOverlay.hide();
      ErrorMessage.instance.translationsEror(111, context, onTap: () async {
        smsRegisterPage
            ? await context.phoneRegisterPr.postPhoneNumberSendAgain(
                GetStorageService.instance.box
                    .read(GetStorageService.instance.uiTelNomer),
                context,
              )
            : await context.addCardPr.postCard(context, true);
        Navigator.pop(context);
      });
    }
  }

  smsRegisterNavigate(BuildContext context) async {
    await context.ofertaPr.getOferta();
    if (context.ofertaPr.shortTitle) {
      context.loaderOverlay.hide();
      stopTimer();
      NavigationService.instance
          .pushNamedRemoveUntil(routeName: "/5_alertoferta");
    } else {
      NavigationService.instance.pushNamedRemoveUntil(routeName: "/4_oferta");
    }
  }
}
