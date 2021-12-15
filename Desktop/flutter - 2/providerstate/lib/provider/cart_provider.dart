import 'package:flutter/material.dart';
import 'package:providerstate/models/mock/product_mock.dart';

class CartProvider extends ChangeNotifier {
  int _countProduct = 0;
  List<ProductMock> listProduct = [];

  int get countProduct => _countProduct;

  void addProduct(ProductMock product) {
    _countProduct += 1;
    listProduct.add(product);
    notifyListeners();
  }

  void removeProduct() {
    if (_countProduct > 0) {
      _countProduct -= 1;
    }
    notifyListeners();
  }
}
