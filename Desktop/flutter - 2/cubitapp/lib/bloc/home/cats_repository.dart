import 'dart:convert';

import 'package:cubitapp/bloc/home/cats_model.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

abstract class CatsRepository {
  Future<List<Cats>> getCatsFromApi();
}

class SampleCatRepository implements CatsRepository {
  final baseUrl = Uri.parse('https://hwasampleapi.firebaseio.com/http.jsons');
  @override
  Future<List<Cats>> getCatsFromApi() async {
    final response = await http.get(baseUrl);
    return (jsonDecode(response.body) as List)
        .map((e) => Cats.fromJson(e))
        .toList();
  }
}
