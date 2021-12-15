import 'package:flutter/material.dart';

class MyBottomProvider extends ChangeNotifier {
  int index = 0;

  changeIndex(int i) {
    index = i;
    notifyListeners();
  }
}
