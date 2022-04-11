import 'package:dio/dio.dart';
import 'package:strapiappflutter/models/product_models.dart';

class ServiceProduct {
  static Future<List<ProductModel>> getProducts() async {
    Response res = await Dio().get('http://localhost:1337/products');
    return (res.data as List).map((e) => ProductModel.fromJson(e)).toList();
  }

  static postToProduct({String? title, String? description, int? price}) async {
    await Dio().post(
      'http://localhost:1337/products',
      data: {
        "title": "C",
        "description": "C is C",
        "price": 34,
        "users_permissions_users": {
          "id": 1,
        }
      },
    );
  }
}
