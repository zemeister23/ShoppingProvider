import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/network/dio/dio_client.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/loans_model.dart';
import 'package:mobile/service/api_service/refref_token_api.dart';
import 'package:mobile/core/extensions/context_extension.dart';

class LoansApi {
  static final LoansApi _instance = LoansApi._init();
  static LoansApi get instance => _instance;
  Future<LoansModel> getLoans(BuildContext context) async {
    try {
      final response =
          await DioClient.instance.get(Endpoints.baseUrl + Endpoints.loans,
              options: Options(
                headers: Endpoints.headers(),
              ));
      LoansModel data = await LoansModel.fromJson(response);
      return data;
    } catch (e) {
      throw e;
    }
  }

  LoansApi._init();
}
