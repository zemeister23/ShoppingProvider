import 'package:dars67/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

export 'package:flutter_secure_storage/flutter_secure_storage.dart';
export 'package:dars67/models/user_model.dart';
export 'package:flutter/material.dart';

abstract class ApiService {
  Future<List<User>> fetchUser();
  TextEditingController usernameController = TextEditingController();
  final usernameKey = GlobalKey<FormFieldState>();
  final storage = const FlutterSecureStorage();
  Future isLogin();
}

class GetUsers extends ApiService {
  @override
  Future<List<User>> fetchUser() async {
    String userUrl = 'http://jsonplaceholder.typicode.com/users';
    Response response = await Dio().get(userUrl);
    // print(response.data);
    return (response.data as List).map((e) => User.fromJson(e)).toList();
  }

  @override
  isLogin() async {
    String? value = await storage.read(key: 'judaMaxfiySoz');
    return value;
  }
}
