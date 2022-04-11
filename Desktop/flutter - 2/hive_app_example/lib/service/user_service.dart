import 'package:dio/dio.dart';
import 'package:hive_app_example/model/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ServiceUser {
  late Box<UserModel> userBox;
  Future<List<UserModel>> getUsers() async {
    Response res =
        await Dio().get('https://jsonplaceholder.typicode.com/users');

    return (res.data as List).map((e) {
      Hive.box('usersBox').add(UserModel.fromJson(e));
      return UserModel.fromJson(e);
    }).toList();
  }
}
