import 'package:dio/dio.dart';
import 'package:smart_farm/constants.dart';

class CurrencyService {
  Future getCurrencies() async {
    var res = await Dio().get(ipAdress + '/currencies');
    return res.data;
  }
}
