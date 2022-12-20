import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mobile/service/api_service/face_id_touch_id_service/face_id_touch_id_service.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/provider/5_pin-code_auth_provider.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:provider/provider.dart';

class CheckPinCodeProvider extends ChangeNotifier {
  int pinCodeCount = 0;
  bool pinErorColor = false;
  List list = List.generate(10, (index) => false);
  List pinList = List.generate(10, (index) => true);
  int capacity = 3;
  List pinCode = [];
  init() {
    pinCodeCount = 0;
    list = List.generate(10, (index) => false);
    pinList = List.generate(10, (index) => true);
    capacity = 3;
    pinCode = [];
  }

  bool isBiometric = false;
  bool isNavigateSettings = false;

  Color isGreen = ColorConst.instance.kPrimaryColor;
  late Function eq = const ListEquality().equals;
  pinColor(int index) {
    if (list[index] && capacity <= 3) {
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

  chageErorColorPinCode(bool state) {
    isGreen = state
        ? ColorConst.instance.kErrorColor
        : ColorConst.instance.kPrimaryColor;
    //  notifyListeners();
  }

  changeCaacity() {
    if (capacity < 0 || capacity <= 3) {
      capacity -= 1;
      chageErorColorPinCode(true);
    }
    if (capacity == 0) {
      pinErorColor = false;
      NavigationService.instance.pushNamedRemoveUntil(routeName: "/6_pincode");
    }
    //  notifyListeners();
  }

  onCompleted(int number, BuildContext context) async {
    var _myProvider = Provider.of<PinCodeAuthProvider>(context, listen: false);
    await stateNumber(number, context);
    await chageColorPin(number);
    await endEffect(false);
    if (await _myProvider.pinCode.length == pinCode.length) {
      if (await eq(_myProvider.pinCode, pinCode)) {
        await GetStorageService.instance.box.write("passcode", pinCode);
        pinErorColor = false;
         await NavigationService.instance
              .pushNamedRemoveUntil(routeName: "/8_razvilka");
     
      } else {
        pinErorColor = true;

        await _myProvider.pinCode.length == pinCode.length
            ? await changeCaacity()
            : null;
        notifyListeners();
      }
    } else {
      
      null;
    }
    await Future.delayed(const Duration(milliseconds: 500), () async {
      await chagePinNumber();
    });
  }

  stateNumber(int number, BuildContext context) {
    var _myProvider = Provider.of<PinCodeAuthProvider>(context, listen: false);

    if (pinCode.length > _myProvider.pinCode.length) {
      
    } else {
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

  endEffect(bool state) {
    if (pinCode.length >= 8) {
    } else {
      int index = pinCode.length - 1;
      pinList[index] = state;
    }
    notifyListeners();
  }

  chagePinNumber() {
    pinList = List.generate(10, (index) => true);
    notifyListeners();
  }

  deleteItem(int state) {
    if (pinCode.length == 1) {
      
      pinErorColor = false;
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
}
