import 'package:dio/dio.dart';
import 'package:expressfluttershopping/constants/const.dart';
import 'package:flutter/material.dart';

class MarketProvider with ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  void senData() async {
    await Dio().post(ipAdress + '/market', data: {
      "name": nameController.text,
      "price": int.parse(priceController.text),
      "image": imageController.text,
      "category": categoryController.text,
    });
  }

  void clear() async {
    nameController.clear();
    priceController.clear();
    imageController.clear();
    categoryController.clear();
  }
}
