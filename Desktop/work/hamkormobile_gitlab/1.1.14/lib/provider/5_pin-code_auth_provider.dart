import 'package:flutter/material.dart';

class PinCodeAuthProvider extends ChangeNotifier {
  int pinCodeCount = 0;

  List list = List.generate(10, (index) => false);
  List pinList = List.generate(10, (index) => true);
  List pinCode = [];

  init() {
    pinCodeCount = 0;
    list = List.generate(10, (index) => false);
    pinList = List.generate(10, (index) => true);
    pinCode = [];
  }

  onCompleted(int number) async {
    await stateNumber(number);
    await chageColorPin(number);
    await endEffect(false);
    await Future.delayed(const Duration(milliseconds: 500), () async {})
        .then((value) async {
      await chagePinNumber();
    });
  }

  stateNumber(int number) {
    if (pinCode.length >= 8) {
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

  endEffect(bool state) async {
    if (pinCode.length >= 8) {
    } else {
      int index = pinCode.length - 1;
      pinList[index] = state;
    }
    notifyListeners();
  }

  deleteItem(int state) {
    if (pinCode.isNotEmpty) {
      int index = pinCode.length - 1;
      list[index] = false;
      pinCode.removeAt(index);
      notifyListeners();
    }
  }

  chagePinNumber() {
    pinList = List.generate(10, (index) => true);
    notifyListeners();
  }
}
