import 'package:flutter/material.dart';
import 'package:sampleprovider/model/mock/list.dart';

class HomeProvider extends ChangeNotifier {
  String valueOfColor = 'red';
  Color colorOfAppbar = Colors.red;
  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController textController = TextEditingController();
  List<MyList> myList = [];

  void changeColor(String newColor) {
    valueOfColor = newColor;
    if (valueOfColor == 'red') {
      colorOfAppbar = Colors.red;
    } else if (valueOfColor == 'yellow') {
      colorOfAppbar = Colors.yellow;
    } else {
      colorOfAppbar = Colors.green;
    }
    notifyListeners();
  }

  void addToList(MyList ml) {
    if (formKey.currentState!.validate()) {
      myList.add(ml);
      textController.clear();
      notifyListeners();
    }
  }
}
