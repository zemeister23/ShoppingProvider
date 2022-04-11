import 'package:dio/dio.dart';
import 'package:expressfluttershopping/constants/const.dart';
import 'package:expressfluttershopping/models/product_model.dart';

class MarketService {
  Future<List<MarketModel>> getProducts() async {
    Response res = await Dio().get(ipAdress + '/market');
    return (res.data as List).map((e) => MarketModel.fromJson(e)).toList();
  }
}
