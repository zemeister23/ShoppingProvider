import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobile/core/constants/error/alert_error.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/models/phone_registration.dart';
import 'package:mobile/provider/1_intro_provider.dart';
import 'package:mobile/provider/3_sms_provider.dart';
import 'package:mobile/service/api_service/3_registration_api.dart';
import 'package:mobile/service/auth_service/auth_class.dart';
import 'package:provider/provider.dart';
import '../routes/router/router.dart';

class RegistrationProvider with ChangeNotifier {
  final GetStorage _getStorage = GetStorage();
  late PhoneRegistation _phoneRegistation;
  PhoneRegistation get phoneRegistation => _phoneRegistation;
  ValidationItem _telNumber = ValidationItem(null, null);
  ValidationItem get telNumber => _telNumber;
  final TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController get phoneNumberController => _phoneNumberController;
  String errorMessage = '';
  bool isRed = false;
  String number = "";
  String userNumber = "998";
  String inputMask = " #";

  int value = GetStorageService.instance.box
              .read(GetStorageService.instance.language) ==
          null
      ? Platform.localeName.contains("ru")
          ? 1
          : 0
      : GetStorageService.instance.box
                  .read(GetStorageService.instance.language) ==
              "ru"
          ? 1
          : 0;

  bool get isValid {
    if (_telNumber.value != null && !isRed) {
      if (_telNumber.value!.length == 12 && phoneNumberController.text.length != 0) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  clearPhoneNumber() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _telNumber = ValidationItem(null, null);
      _phoneNumberController.clear();
      notifyListeners();
    });
  }

  void changeRadioButton(int v, BuildContext context) async {
    value = v;
    if (value == 0) {
      context.setLocale(const Locale("uz", "UZ"));
      GetStorageService.instance.box
          .write(GetStorageService.instance.language, "uz");
    } else if (value == 1) {
      context.setLocale(const Locale("ru", "RU"));
      GetStorageService.instance.box
          .write(GetStorageService.instance.language, "ru");
    }

    notifyListeners();
  }

  void changePassword(String value, BuildContext context) {
    List listInput = [];
    bool control = false;
    var mask =
        Provider.of<IntroProvider>(context, listen: false).operators.data;
    if (value.length == 12) {
      listInput = [];
      listInput.add(value);
      for (var i = 0; i < mask!.length; i++) {
        String inputMask = "${listInput[0][0]}${listInput[0][1]}";
        if (mask[i].mask.toString() == inputMask) {
          control = true;
          isRed = false;
          number = value;
          _telNumber = ValidationItem(value, null);
          notifyListeners();
        } else {
          if (!control) {
            isRed = true;
            notifyListeners();
          }
        }
      }
    } else {}
  }

  void changeTest(String value, BuildContext context) {
    List listInput = [];
    bool control = false;
    var mask =
        Provider.of<IntroProvider>(context, listen: false).operators.data;
    listInput = [];
    listInput.add(value);
    for (var i = 0; i < mask!.length; i++) {
      String? inputMask;
      if (listInput[0].length > 1) {
        inputMask = "${listInput[0][0]}${listInput[0][1]}";
      }
      if (mask[i].mask.toString() == inputMask) {
        control = true;
        isRed = false;
        number = value;
        _telNumber = ValidationItem(value, null);
        notifyListeners();
      } else {
        if (!control) {
          isRed = true;
          notifyListeners();
        }
        if (value.length == 0) {
          isRed = false;
        }
      }
    }
  }

  Future<void> postPhoneNumber(String phoneNumber, BuildContext context) async {
    
    userNumber = "998";
    var s;
    await Future.delayed(Duration.zero, () async {
      s = await phoneNumber.split(" ");
      s.forEach(((e) {
        userNumber += e;
      }));
    }).then((valu) async {
      try {
        final PhoneRegistation response = await RegistrationApi.instance
            .postNumber(userNumber, value, context);
        _phoneRegistation = response;
        _getStorage.write(
            GetStorageService.instance.signId, _phoneRegistation.data!.signId);
        context.loaderOverlay.hide();
        await NavigationService.instance.pushNamed(routeName: "/3_smscode");
      } catch (e) {
        context.loaderOverlay.hide();
        if (e is DioError) {
          if (e.response!.statusCode == 500) {
            // ErrorMessage.instance.translationsEror(
            //     e.response!.data["error_code"], context);
          }
          if (e.response!.statusCode == 422) {
            ErrorMessage.instance
                .translationsEror(e.response!.data["error_code"], context);
          }
          FirebaseCrashlytics.instance.log(e.response!.data.toString());
        }
      }
    });
  }

  Future<void> postPhoneNumberSendAgain(
    String phoneNumber,
    BuildContext context,
    {bool? sendAgain}
  ) async {
    SmsProvider myProvider = Provider.of<SmsProvider>(context, listen: false);
    bool state = false;
    var s = phoneNumber.split(" ");
    String _number = "998";
    s.forEach(((e) {
      _number += e;
    }));
    
    try {
      final PhoneRegistation response =
          await RegistrationApi.instance.postNumber(_number, value, context,sendAgain: sendAgain);
      GetStorageService.instance.box
          .write(GetStorageService.instance.signId, response.data!.signId);

      myProvider.duration.inSeconds == 00 ? state = true : state = false;
      myProvider.stopTimer();
      myProvider.starttTimer(secund: 60);
      myProvider.capacity = 3;
      
      myProvider.erorText = '';
      myProvider.isSendAgainLoading = false;
      // 
    } on DioError catch (e) {
      if (e.response!.statusCode == 500) {
 
        //   ErrorMessage.instance
        //       .translationsEror(e.response!.data['error_code'], context);
      }
      FirebaseCrashlytics.instance.log(e.response!.data.toString());
    } catch (e) {
      
    }
  }
}
