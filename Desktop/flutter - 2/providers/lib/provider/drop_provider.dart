import 'package:flutter/material.dart';

class DropProvider extends ChangeNotifier {
  var value = '1';

  void changeValue(v) {
    value = v;
    notifyListeners();
  }
}
