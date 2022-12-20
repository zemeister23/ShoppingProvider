import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/error/alert_error.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/service/api_service/4_sms_service.dart';
import 'package:mobile/service/api_service/refref_token_api.dart';
import 'package:mobile/service/auth_service/auth_class.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import '../core/init/cache/get_storege.dart';

class SmsProvider extends ChangeNotifier {
  ValidationItem _smsNumber = ValidationItem(null, null);
  ValidationItem get telNumber => _smsNumber;
  Duration duration = const Duration(minutes: 1);
  bool isLoading = false;
  List list = [];
  String smsValues = "";
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
  bool _isEnabled = true;
  bool get isEnabled => _isEnabled;
  late bool sendMassageActiv;
  late DateTime dtm1;
  late DateTime dtm2;
  late int minute;

  bool get isValid {
    if (telNumber.value != null) {
      return true;
    } else {
      return false;
    }
  }

  Timer? _timer;

  int _seconds = 0;
  int _minut = 0;
  bool _startEnable = true;
  bool _stopEnable = false;
  bool _continueEnable = false;
  int get seconds => _seconds;
  int get minut => _minut;
  bool get startEnable => _startEnable;
  bool get stopEnable => _stopEnable;
  bool get continueEnable => _continueEnable;
  bool isSendAgainLoading = false;
  init() {
    _minut = 0;
    _seconds = 0;
  }

  onChanged(String v) {
    if (v.length == 0) {
      erorColor = false;
      activColor2();
    }
  }

  void starttTimer({
    required int secund,
  }) {
    _isEnabled = true;
    _seconds = secund;

    _startEnable = false;

    _continueEnable = false;

    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        _seconds--;
      } else if (_seconds == 0) {
        _isEnabled = false;

        _timer!.cancel();
      }
      notifyListeners();
    });
  }

  void startTimerBlock({
    required int minut,
  }) {
    _minut = minut;
    _isEnabled = false;
    _startEnable = false;
    _stopEnable = true;
    _continueEnable = false;

    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      if (_minut > 0) {
        _minut--;
      } else if (_minut == 0) {
        _isEnabled = true;
        _timer!.cancel();
      }
      notifyListeners();
    });
  }

  void stopTimer() async {
    if (_startEnable == false) {
      _startEnable = true;
      _continueEnable = true;
      _stopEnable = false;
      _timer!.cancel();
      _seconds = 0;
      _minut = 0;
    }
    _isEnabled = false;

    notifyListeners();
  }

  resumeApp() {
    if (stopEnable) {
      stopTimer();
      dtm1 = DateTime.fromMillisecondsSinceEpoch(
          Timestamp.now().millisecondsSinceEpoch);

      int mainMinute = minute >= (dtm1.difference(dtm2).inMinutes)
          ? minute - (dtm1.difference(dtm2).inMinutes)
          : 0;
      startTimerBlock(minut: mainMinute);
    }
  }

  pausedApp() {
    dtm2 = DateTime.fromMillisecondsSinceEpoch(
        Timestamp.now().millisecondsSinceEpoch);
    minute = minut;
  }

  void initState(BuildContext context, bool smsRegistrationPage) {
    starttTimer(secund: 60);
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

//  bool inputBlock(){
//     if(_seconds != 0 ||  _minut != 0){
//       _isEnabled = true;
//     return _isEnabled;
//     }
//     else{
//        _isEnabled = false;
//        return _isEnabled;

//     }

//   }
  textButtonActiv() {
    textCapasity -= 1;
  }

  activColor() {
    if (erorColor) {
      if (smsValues.isEmpty) {
        erorColor = false;
        return ColorConst.instance.kPrimaryColor;
      }
      return ColorConst.instance.kErrorColor;
    } else {
      return ColorConst.instance.kPrimaryColor;
    }
  }

  activColor2() {
    if (erorColor || seconds == 0) {
      capacity - 1;
      return ColorConst.instance.kErrorColor;
    } else {
      return ColorConst.instance.kPrimaryColor;
    }
  }

  invalidSmS() {
    if (capacity != 0) {
      if (smsValues.length == 6) {
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
    _minut = 0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      stopTimer();
    });

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
      erorText =
          "sms_code_invalid".locale.replaceAll("NUMBER", capacity.toString());
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
    smsValues = value;
    if (value == sms) {
      isRed = false;
      number = value;
      _smsNumber = ValidationItem(value, null);
      notifyListeners();
    } else {}
    notifyListeners();
  }

  Future<void> postSms(
      {required String code,
      required BuildContext context,
      required bool smsRegisterPage,
      required bool addCardPage}) async {
    if (_seconds != 0) {
      try {
        await SmsSerVice.instance.postSms(
            code: code,
            smsRegisterPage: smsRegisterPage,
            context: context,
            addCardPage: addCardPage);

        smsRegisterPage ? smsRegisterNavigate(context) : null;
      } catch (e) {
        context.loaderOverlay.hide();
        if (e is DioError) {
          FirebaseCrashlytics.instance.log(e.response!.data.toString());
          if (e.response!.statusCode == 401) {
            return await RefreshTokenApi.instance.postRefreshToken().then(
                  (value) async => await postSms(
                    code: code,
                    context: context,
                    smsRegisterPage: smsRegisterPage,
                    addCardPage: addCardPage,
                  ),
                );
          }
          ;
          if (e.response!.statusCode == 500) {
            erorColor = true;
            changeCapacity();
            erorTextState(true);
            outCapasity(capacity, e.response!.data["error_code"], context,
                addCardPage: addCardPage);
          }
        }
      }
    } else {
      context.loaderOverlay.hide();
    }
  }

  smsRegisterNavigate(BuildContext context) async {
    await context.ofertaPr.getOferta();
    if (context.ofertaPr.shortTitle) {
      context.loaderOverlay.hide();

      await NavigationService.instance
          .pushNamedRemoveUntil(routeName: "/5_alertoferta");
      stopTimer();
    } else {
      await NavigationService.instance
          .pushNamedRemoveUntil(routeName: "/4_oferta");
      stopTimer();
    }
  }

  Future senAgainButton(
      {required bool smstranlationsPage,
      required bool addCardPage,
      required BuildContext context,
      bool isAlert = false}) async {
    context.smsPr.isSendAgainLoading = true;
    isAlert ? Navigator.pop(context) : null;
    context.smsPr.textButtonActiv();

    if (smstranlationsPage) {
      context.transactionsPr.smsTranlationsPage = true;
      await context.transactionsPr.postP2pInit(context, isSendAgain: true);
      context.smsPr.isSendAgainLoading = false;
    } else if (addCardPage) {
      await context.addCardPr.postCard(context, true);
    } else {
      await context.phoneRegisterPr.postPhoneNumberSendAgain(
          GetStorageService.instance.box
              .read(GetStorageService.instance.uiTelNomer),
          context,
          sendAgain: true);
    }
  }

  void outCapasity(int capasit, int errorCode, BuildContext context,
      {required bool addCardPage}) {
    if (capasit <= 0) {
      stopTimer();
      startTimerBlock(minut: 15);

      ErrorMessage.instance.translationsEror(1019, context, onTap: () {
        senAgainButton(
            smstranlationsPage: false,
            addCardPage: addCardPage,
            context: context,
            isAlert: true);
      }, isDisable: true, isSmsScreen: true);
    }
  }
}

class ErrorBeckend extends SmsProvider {
  ErrorBeckend({required BuildContext context, state}) {
    changeCapacity();
    erorTextState(state);
    // outCapasity(capasity, errorCode, context, addCardPage: addCardPage)
  }

  void outCapasity(int capasity, int errorCode, BuildContext context,
      {required bool addCardPage}) {
    if (capacity <= 0) {
      stopTimer();
      startTimerBlock(minut: 15);

      ErrorMessage.instance.translationsEror(errorCode, context, onTap: () {
        senAgainButton(
            smstranlationsPage: false,
            addCardPage: addCardPage,
            context: context,
            isAlert: true);
      }, isDisable: true, isSmsScreen: true);
    }
  }
}
