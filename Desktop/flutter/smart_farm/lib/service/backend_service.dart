import 'package:dio/dio.dart';
import 'package:smart_farm/constants.dart';
import 'package:smart_farm/service/firebase_service.dart';

class BackendService {
  String? name;

  Future getMyAnimals() async {
    String phone =
        FirebaseService.auth.currentUser!.phoneNumber.toString().split("+")[1];
    var response = await Dio().get(ipAdress + '/users?slug=$phone');
    return response.data;
  }

  Future getAllFarms() async {
    var allFarms = await Dio().get(ipAdress + '/categories');
    return allFarms.data;
  }

  Future getCategorizedAnimals(String type) async {
    var allFarms = await Dio().get(ipAdress + '/' + type + 's');
    return allFarms.data;
  }

  Future getFarmAnimals(String farm) async {
    var allFarms = await Dio().get(
        ipAdress + '/categories/' + farm.split(' ').join('-').toLowerCase());

    return allFarms.data;
  }
}
