import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/models/bancomates_model.dart';
import 'package:mobile/models/branches_model.dart';
import 'package:mobile/models/regions_model.dart';
import 'package:mobile/service/api_service/bancomates_service.dart';
import 'package:mobile/service/api_service/branches_service.dart';
import 'package:mobile/service/api_service/refref_token_api.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/service/api_service/regions_service.dart';
import 'package:mobile/models/bancomates_model.dart' as bancomate;
import 'package:mobile/models/branches_model.dart' as branche;
import 'package:mobile/models/bancomates_model.dart';

class MapProvider extends ChangeNotifier {
  late BancomatesModel _responseBancomates;
  BancomatesModel get responseBancomates => _responseBancomates;
  late BranchesModel _responseBranches;
  BranchesModel get responseBranches => _responseBranches;
  String _language = GetStorageService.instance.box
          .read(GetStorageService.instance.language) ??
      "ru";

  bool isMapScreen = false;

  String regionCode = "26";
  int indexButton = 0;
  int bancomateIndex = 0;
  int brancheIndex = 0;
  int bottomSheetIndex = 0;
  bool isExpanded = false;
  int regionIndex = -1;

  @override
  void dispose() {
    isMapScreen = false;
    super.dispose();
  }

  void changeBottomSheetIndex(int index) {
    bottomSheetIndex = index;
    notifyListeners();
  }

  void changeisExpanded() {
    isExpanded = !isExpanded;

    notifyListeners();
  }

  void changeButtonState(int index) {
    indexButton = index;
    notifyListeners();
  }

  static String cardLogo(String logoName) {
    logoName == "UZCARD" ? "uzcard_rectangle" : "humo_rectangle";
    return logoName == "UZCARD" ? "uzcard_rectangle" : "humo_rectangle";
  }

  void changeRegionCode(String _regionCode, int index) {
    regionCode = _regionCode;
    regionIndex = index;
    notifyListeners();
  }

  textBancomates(List<bancomate.Datum> list, index) {
    if (_language == "ru")
      return list[index].address!.ru.toString();
    else if (_language == "uz")
      return list[index].address!.uz.toString();
    else if (_language == "en")
      return list[index].address!.en.toString();
    else
      return list[index].address!.uz.toString();
  }

  textBranches(List<branche.Datum> list, index) {
    if (_language == "ru")
      return list[index].address!.ru.toString();
    else if (_language == "uz")
      return list[index].address!.uz.toString();
    else if (_language == "en")
      return list[index].address!.en.toString();
    else
      return list[index].address!.uz.toString();
  }

  textOpenTimeBranches(List<branche.Datum> list, index) {
    if (_language == "ru")
      return list[index].statusText!.ru.toString();
    else if (_language == "uz")
      return list[index].statusText!.uz.toString();
    else if (_language == "en")
      return list[index].statusText!.en.toString();
    else
      return list[index].statusText!.uz.toString();
  }

  timeBranches(List<branche.Datum> list, index) {
    if (_language == "ru")
      return list[index].workTime!.ru.toString();
    else if (_language == "uz")
      return list[index].workTime!.uz.toString();
    else if (_language == "en")
      return list[index].workTime!.en.toString();
    else
      return list[index].workTime!.uz.toString();
  }

  timeBancomes(List<bancomate.Datum> list, index) {
    if (_language == "ru")
      return list[index].workTime!.ru.toString();
    else if (_language == "uz")
      return list[index].workTime!.uz.toString();
    else if (_language == "en")
      return list[index].workTime!.en.toString();
    else
      return list[index].workTime!.uz.toString();
  }

  workDaysBancomes(List<bancomate.Datum> list, index) {
    if (_language == "ru")
      return list[index].workDays!.ru.toString();
    else if (_language == "uz")
      return list[index].workDays!.uz.toString();
    else if (_language == "en")
      return list[index].workDays!.en.toString();
    else
      return list[index].workDays!.uz.toString();
  }

  weekendsBranches(List<branche.Datum> list, index) {
    if (_language == "ru")
      return list[index].weekends!.ru.toString();
    else if (_language == "uz")
      return list[index].weekends!.uz.toString();
    else if (_language == "en")
      return list[index].weekends!.en.toString();
    else
      return list[index].weekends!.uz.toString();
  }

  serviceBranches(List<branche.Datum> list, index) {
    if (_language == "ru")
      return list[index].services!.ru.toString();
    else if (_language == "uz")
      return list[index].services!.uz.toString();
    else if (_language == "en")
      return list[index].services!.en.toString();
    else
      return list[index].services!.uz.toString();
  }

  serviceBancomates(List<bancomate.Datum> list, index) {
    if (_language == "ru")
      return list[index].atmType!.ru.toString();
    else if (_language == "uz")
      return list[index].atmType!.uz.toString();
    else if (_language == "en")
      return list[index].atmType!.en.toString();
    else
      return list[index].atmType!.uz.toString();
  }

  orienterBancomates(List<bancomate.Datum> list, index) {
    if (_language == "ru")
      return list[index].orienter!.ru.toString();
    else if (_language == "uz")
      return list[index].orienter!.uz.toString();
    else if (_language == "en")
      return list[index].orienter!.en.toString();
    else
      return list[index].orienter!.uz.toString();
  }

  List regionLocation(String regionCode) {
    List list = [];
    list.add(regionLatLong[regionCode]["lat"]);
    list.add(regionLatLong[regionCode]["long"]);
    return list;
  }

  Map<String, dynamic> regionLatLong = {
    //andijon
    "03": {"lat": "40.77408090036615", "long": "72.5355339"},
    // buxoro
    "06": {"lat": "40.22936600029793", "long": "63.54705839999999"},
    // jizzax
    "08": {"lat": "40.33190950031129", "long": "67.4551198"},
    // qashqadaryo
    "10": {"lat": "38.563939700062676", "long": "65.5311095"},
    // navoi
    "12": {"lat": "42.00000000048624", "long": "63.999999999999986"},
    // namangan
    "14": {"lat": "41.00362870039255", "long": "71.26119519999999"},
    // samarqand
    "18": {"lat": "39.73370230023066", "long": "66.12828889999999"},
    // surhandaryo
    "22": {"lat": "37.95208429997525", "long": "67.12659959999999"},
    // sirdaryo
    "24": {"lat": "40.50184730033293", "long": "68.7426643"},
    // toshkent shaxar
    "26": {"lat": "41.04968150039766", "long": "69.3711365"},
    // toshkent viloyati
    "27": {"lat": "41.04968150039766", "long": "69.3711365"},
    // farg'ona
    "30": {"lat": "40.5000000003327", "long": "71.24999999999999"},
    // xorazm
    "33": {"lat": "41.29028350042324", "long": "60.542853699999995"},
    // qoraqalpoq
    "35": {"lat": "43.77388410053869", "long": "57.6234617"},
  };

  Future<BancomatesModel> getBancomates(BuildContext context) async {
    try {
      _responseBancomates = await BancomatesApi.instance.getBancomates(context);
      return _responseBancomates;
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == 401)
          return await RefreshTokenApi.instance
              .postRefreshToken()
              .then((value) async => await getBancomates(context));
      }
      throw e;
    }
  }

  Future<BranchesModel> getBranches(BuildContext context) async {
    try {
      _responseBranches = await BranchesApi.instance.getBranches(context);

      return _responseBranches;
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == 401)
          return await RefreshTokenApi.instance
              .postRefreshToken()
              .then((value) async => await getBranches(context));
      }
      throw e;
    }
  }

  Future<RegionsModel> getRegions(BuildContext context) async {
    try {
      final _responseBranches = await RegionsApi.instance.getRegions(context);
      return _responseBranches;
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == 401)
          return await RefreshTokenApi.instance
              .postRefreshToken()
              .then((value) async => await getRegions(context));
      }
      throw e;
    }
  }
}
