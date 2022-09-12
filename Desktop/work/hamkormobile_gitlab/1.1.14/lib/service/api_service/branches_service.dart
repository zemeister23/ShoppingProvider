import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/network/dio/dio_client.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/bancomates_model.dart';
import 'package:mobile/models/branches_model.dart';
import 'package:mobile/service/api_service/refref_token_api.dart';
import 'package:mobile/core/extensions/context_extension.dart';

class BranchesApi {
  static final BranchesApi _instance = BranchesApi._init();
  static BranchesApi get instance => _instance;
  Future<BranchesModel> getBranches(BuildContext context) async {
    try {
      final response = await DioClient.instance.get(
        Endpoints.baseUrl + Endpoints.branches,
        options: Options(headers: Endpoints.headers()),
      );
      return BranchesModel.fromJson(response);
    } catch (e) {
      if (e is DioError) {}
      throw e;
    }
  }

  BranchesApi._init();
}
