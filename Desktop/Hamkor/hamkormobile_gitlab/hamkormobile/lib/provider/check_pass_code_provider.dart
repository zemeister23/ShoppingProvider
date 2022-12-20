import 'dart:async';
import 'package:collection/collection.dart';

import 'package:flutter/material.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_service.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/navigation/navigation_constant.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/provider/map_provider.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/service/firebase/performance/performance_service.dart';
import 'package:provider/provider.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';

class CheckPassCodeProvider extends ChangeNotifier {
  int pinCodeCount = 0;

  bool pinErorColor = false;
  List list = List.generate(10, (index) => false);
  List pinList = List.generate(10, (index) => true);
  List pinCode = [];
  late Timer _timer;
  bool isPopPr = false;
  bool isPop = false;
  Color isGreen = ColorConst.instance.kPrimaryColor;

  int _seconds = 0;
  bool _startEnable = true;
  bool _stopEnable = false;
  bool _continueEnable = false;
  int get seconds => _seconds;
  bool get startEnable => _startEnable;
  bool get stopEnable => _stopEnable;
  bool get continueEnable => _continueEnable;
  int deleteCount = 0;
  int capacity = 5;
  String passCode = "";
  String storegePasCode = "";
  bool timerCansel = false;
  bool isErrorTextCapasity = false;

  void startTimer(
    BuildContext context,
  ) {
    _seconds = 30;
    _startEnable = false;
    _stopEnable = true;
    _continueEnable = false;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        _seconds--;
      } else if (_seconds == 0) {
        _timer.cancel();

        pinErorColor = false;

        NavigationService.instance
            .pushNamedRemoveUntil(routeName: NavigationConst.PASS_CODE_VIEW);
     
     
      }
      notifyListeners();
    });
  }

  changeIsPopToTrue() {
    isPop = true;
    notifyListeners();
  }

  changeIsPopToFalse() {
    isPop = false;
    notifyListeners();
  }

  void stopTimer() {
    if (_startEnable == false) {
      _startEnable = true;
      _continueEnable = true;
      _stopEnable = false;
      _timer.cancel();
    }
  }

  init() {
    capacity = GetStorageService.instance.box
                .read(GetStorageService.instance.capacity) ==
            null
        ? 5
        : int.parse(GetStorageService.instance.box
            .read(GetStorageService.instance.capacity));

    list = List.generate(10, (index) => false);
    pinList = List.generate(10, (index) => true);
    pinCode = [];
    pinErorColor = false;
  }

  pinColor(int index) {
    if (list[index] && capacity <= 5) {
      if (pinCodeCount == 1) {
        isGreen = ColorConst.instance.kPrimaryColor;
        return isGreen;
      } else {
        return isGreen;
      }
    } else {
      return ColorConst.instance.kElementsColor;
    }
  }

  changeCaacity() {
    if (capacity < 0 || capacity <= 5) {
      capacity -= 1;
      GetStorageService.instance.box
          .write(GetStorageService.instance.capacity, capacity.toString());
      chageErorColorPinCode(true);
    }
    if (capacity == 0) {
      NavigationService.instance.pushNamedRemoveUntil(routeName: "/6_pincode");
    }
    notifyListeners();
  }

  onCompleted(int number, BuildContext context, bool isPop,
      {VoidCallback? onPressed}) async {
      try {
          
      
    capacity = await GetStorageService.instance.box
                .read(GetStorageService.instance.capacity) ==
            null
        ? 5
        : int.parse(GetStorageService.instance.box
            .read(GetStorageService.instance.capacity));
    late Function eq = const ListEquality().equals;
    isPopPr = isPop;

    await stateNumber(number, context);
    await chageColorPin(number);
    await endEffect(false);
    notifyListeners();

    if (storegePasCode.length.toString() == pinCode.length.toString()) {
    
      if (await eq(GetStorageService.instance.box.read("passcode"), pinCode)) {
          
        await GetStorageService.instance.box
            .write(GetStorageService.instance.isLocked, false);

        await GetStorageService.instance.box
            .write(GetStorageService.instance.capacity, "5");

        pinErorColor = false;

        if (onPressed != null) {
          onPressed();
        } else {
         if (isPop) {
          
            Navigator.pop(context);
            
            
          } else {
            NavigationService.instance.pushNamedRemoveUntil(
                routeName: NavigationConst.HOME_PAGE_VIEW, data: true);
          }
        }
        notifyListeners();
      } else {
        isErrorTextCapasity = true;
        pinErorColor = true;
        capacity == -1 ? capacity = 5 : capacity;
        capacity -= 1;
        await GetStorageService.instance.box
            .write(GetStorageService.instance.capacity, capacity.toString());

        if (capacity == 0) {
          await chageErorColorPinCode(true);
          await context.introPr.exitApp(context);
        NavigationService.instance
              .pushNamedRemoveUntil(routeName: NavigationConst.INTRO_PAGE_VIEW);


        } else {
          await chageErorColorPinCode(true);
        }
      }
    }
    await Future.delayed(const Duration(milliseconds: 500), () async {
      await chagePinNumber();
    });
    await Future.delayed(const Duration(milliseconds: 500), () async {})
        .then((value) async {
      await chagePinNumber();
    });
      } catch (e) {
        
        
      }
  }

  storegePassCodeLength() {
    storegePasCode = "";

    List listCode = GetStorageService.instance.box.read("passcode");
    for (var i = 0; i < listCode.length; i++) {
      storegePasCode += listCode[i].toString();
    }
  }

  stateNumber(int number, BuildContext context) {
    if (pinCode.length > storegePasCode.length) {
    } else {
      if (pinCode.length == 0) {
        pinErorColor = false;
      }
      pinCode.add(number);

      pinCodeCount += 1;
    }
    notifyListeners();
  }
  chageColorPin(int state) {
    int index = pinCode.length - 1;
    list[index] = true;
    notifyListeners();
  }

  endEffect(bool state) async {
    if (pinCode.length >= 8) {
    } else {
      int index = pinCode.length - 1;
      pinList[index] = state;
    }
    notifyListeners();
  }

  deleteItem(int state) {
    if (pinCode.isEmpty) {
      pinErorColor = true;
      notifyListeners();
    }
    if (pinCode.isNotEmpty) {
      pinCodeCount -= 1;

      int index = pinCode.length - 1;
      list[index] = false;
      pinCode.removeAt(index);

      if (pinCode.isEmpty) {
        chageErorColorPinCode(false);
      }
      notifyListeners();
    }
  }

  chagePinNumber() {
    pinList = List.generate(10, (index) => true);
    notifyListeners();
  }

  chageErorColorPinCode(bool state) {
    isGreen = state
        ? ColorConst.instance.kErrorColor
        : ColorConst.instance.kPrimaryColor;
    notifyListeners();
  }

  dialogEror(
      bool viewSeconds, BuildContext context, CheckPassCodeProvider provider) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: Container(
            child: Text(
              viewSeconds
                  ? "wrong_pass_code"
                      .locale
                      .replaceAll(
                          "TIMER",
                          context
                              .watch<CheckPassCodeProvider>()
                              .seconds
                              .toString())
                      .replaceAll(
                        "ATTEMPTCOUNT",
                        (5 - context.watch<CheckPassCodeProvider>().capacity ==
                                    4
                                ? 5
                                : 5 -
                                    context
                                        .watch<CheckPassCodeProvider>()
                                        .capacity)
                            .toString(),
                      )
                  : "wrong_pass_code_first".locale.replaceAll(
                        "ATTEMPTCOUNT",
                        (5 - context.watch<CheckPassCodeProvider>().capacity ==
                                    4
                                ? 5
                                : 5 -
                                    context
                                        .watch<CheckPassCodeProvider>()
                                        .capacity)
                            .toString(),
                      ),
              textAlign: TextAlign.center,
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  init();
                  Navigator.pop(context);
                },
                child: Text(
                  "cancel_passcode_alert".locale,
                  style: TextStyle(color: Colors.black26),
                )),
            TextButton(
              onPressed: () async {
                await GetStorageService.instance.box
                    .write(GetStorageService.instance.isAuthenticated, false);
                await GetStorageService.instance.box.write(
                    GetStorageService.instance.isLockScreenShowed, false);
                context.smsPr.stopTimer();
                await context.introPr.exitApp(context).then((value) {
                  NavigationService.instance
                      .pushNamedRemoveUntil(routeName: "/1_intro")
                      .then(
                        (value) => provider.startTimer(context),
                      );
                });
              },
              child: Text("registration_passcode_alert".locale),
            ),
          ],
        );
      },
    );
  }
}
