import 'dart:io';
import 'package:catapiprovider/models/cats_model.dart';
import 'package:catapiprovider/models/users_model.dart';
import 'package:dio/dio.dart';

class DioService {
  Future<List<Cat>> getCats() async {
    Response response =
        await Dio().get('https://hwasampleapi.firebaseio.com/http.json');
    if (response.statusCode == HttpStatus.ok) {
      var data = (response.data as List).map((e) => Cat.fromJson(e)).toList();
      return data;
    } else {
      throw Exception('Network Error');
    }
  }

  Future<List<User>> getUsers() async {
    Response response =
        await Dio().get('https://jsonplaceholder.typicode.com/users');
    if (response.statusCode == HttpStatus.ok) {
      var data = (response.data as List).map((e) => User.fromJson(e)).toList();
      return data;
    } else {
      throw Exception('Network Dog Error');
    }
  }
}
