import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/models/offerta_model.dart';

import 'package:mobile/service/api_service/5_oferta_service.dart';

class OfertaProvider extends ChangeNotifier {
  late OffertaModel _offertaData;
  OffertaModel get oferta => _offertaData;
  bool checkbox = false;
  bool shortTitle = true;
  changeCheckBox(bool state) {
    checkbox = state;
    notifyListeners();
  }

  changeShortTitle(bool state) {
    shortTitle = state;
    notifyListeners();
  }

  Future<OffertaModel> getOferta() async {
    try {
      final response = await OfertaService.instance.getOferta();
      _offertaData = response;

      shortTitle = _offertaData.data!.isShortTitle!;
      GetStorageService.instance.box.write(
          GetStorageService.instance.ofertaText, _offertaData.data!.text);
      return _offertaData;
    } catch (e) {
      if (e is DioError) {}
    }
    return OffertaModel();
  }
}
