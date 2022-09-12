import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/network/dio/dio_client.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/bancomates_model.dart';
import 'package:mobile/models/branches_model.dart';
import 'package:mobile/models/regions_model.dart';
import 'package:mobile/service/api_service/refref_token_api.dart';
import 'package:mobile/core/extensions/context_extension.dart';

class RegionsApi {
  static final RegionsApi _instance = RegionsApi._init();
  static RegionsApi get instance => _instance;
  Future<RegionsModel> getRegions(BuildContext context) async {
    try {
      final response = await DioClient.instance.get(
        Endpoints.baseUrl + Endpoints.regions,
        options: Options(headers: Endpoints.headers()),
      );
      return RegionsModel.fromJson(response);
    } catch (e) {
      if (e is DioError) {}
      throw e;
    }
  }

  RegionsApi._init();
}
