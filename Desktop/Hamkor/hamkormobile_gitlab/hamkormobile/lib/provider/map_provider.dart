import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
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
  dynamic newbottomsheetData;
  late BancomatesModel _responseBancomates;
  BancomatesModel get responseBancomates => _responseBancomates;
  late BranchesModel _responseBranches;
  BranchesModel get responseBranches => _responseBranches;

  bool isMapScreen = false;
    bool isMapScreenForBaseView = false;

  bool stateBottmSheet = false;
  String regionCode = "26";
  int indexButton = 0;
  int bancomateIndex = 0;
  int brancheIndex = 0;
  int bottomSheetIndex = 0;
  bool isExpanded = false;
  int regionIndex = -1;
  String? language = GetStorageService.instance.box
          .read(GetStorageService.instance.language) ??
      "ru";
  @override
  void dispose() {
    isMapScreen = false;
    super.dispose();
  }

  changeNewBottomSheetData(data) {
    newbottomsheetData = data;
    notifyListeners();
  }
  
  

  

  
  
  
  
  changeLogo() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      
    });
  }

  void changeStateBottomShet() {
    stateBottmSheet = !stateBottmSheet;
    notifyListeners();
  }

  void changeBottomSheetIndex(int index) {
    bottomSheetIndex = index;
    notifyListeners();
  }

  void changeisExpanded() {
    isExpanded = !isExpanded;

    notifyListeners();
    
  }

  void changeExpandedwithValue(bool value) {
    isExpanded = value;

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

  void changeRegionIndex(int index) {
    regionIndex = index;
    notifyListeners();
  }

  textBancomates(List<bancomate.Datum> list, index) {
    if (language == "ru")
      return list[index].address!.ru.toString();
    else if (language == "uz")
      return list[index].address!.uz.toString();
    else if (language == "en")
      return list[index].address!.en.toString();
    else
      return list[index].address!.uz.toString();
  }

  textBranches(List<branche.Datum> list, index) {
    if (language == "ru")
      return list[index].address!.ru.toString();
    else if (language == "uz")
      return list[index].address!.uz.toString();
    else if (language == "en")
      return list[index].address!.en.toString();
    else
      return list[index].address!.uz.toString();
  }

  textOpenTimeBranches(List<branche.Datum> list, index) {
    if (language == "ru")
      return list[index].statusText!.ru.toString();
    else if (language == "uz")
      return list[index].statusText!.uz.toString();
    else if (language == "en")
      return list[index].statusText!.en.toString();
    else
      return list[index].statusText!.uz.toString();
  }

  timeBranches(List<branche.Datum> list, index) {
    if (language == "ru")
      return list[index].workTime!.ru.toString();
    else if (language == "uz")
      return list[index].workTime!.uz.toString();
    else if (language == "en")
      return list[index].workTime!.en.toString();
    else
      return list[index].workTime!.uz.toString();
  }

  timeBancomes(List<bancomate.Datum> list, index) {
    
    if (language == "ru")
      return list[index].workTime!.ru.toString();
    else if (language == "uz")
      return list[index].workTime!.uz.toString();
    else if (language == "en")
      return list[index].workTime!.en.toString();
    else
      return list[index].workTime!.uz.toString();
  }

  workDaysBancomes(List<bancomate.Datum> list, index) {
    
    if (language == "ru")
      return list[index].workDays!.ru.toString();
    else if (language == "uz")
      return list[index].workDays!.uz.toString();
    else if (language == "en")
      return list[index].workDays!.en.toString();
    else
      return list[index].workDays!.uz.toString();
  }

  weekendsBranches(List<branche.Datum> list, index) {
    if (language == "ru")
      return list[index].weekends!.ru.toString();
    else if (language == "uz")
      return list[index].weekends!.uz.toString();
    else if (language == "en")
      return list[index].weekends!.en.toString();
    else
      return list[index].weekends!.uz.toString();
  }

  serviceBranches(List<branche.Datum> list, index) {
    if (language == "ru")
      return list[index].services!.ru.toString();
    else if (language == "uz")
      return list[index].services!.uz.toString();
    else if (language == "en")
      return list[index].services!.en.toString();
    else
      return list[index].services!.uz.toString();
  }

  serviceBancomates(List<bancomate.Datum> list, index) {
    if (language == "ru")
      return list[index].atmType!.ru.toString();
    else if (language == "uz")
      return list[index].atmType!.uz.toString();
    else if (language == "en")
      return list[index].atmType!.en.toString();
    else
      return list[index].atmType!.uz.toString();
  }

  orienterBancomates(List<bancomate.Datum> list, index) {
    if (language == "ru")
      return list[index].orienter!.ru.toString();
    else if (language == "uz")
      return list[index].orienter!.uz.toString();
    else if (language == "en")
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
    
    "03": {"lat": "40.783138", "long": "72.350502"},
    
    "06": {"lat": "39.767966", "long": "64.421728"},
    
    "08": {"lat": "40.120295", "long": "67.828517"},
    
    "10": {"lat": "38.841654", "long": "65.790015"},
    
    "12": {"lat": "40.103093", "long": "65.373970"},
    
    "14": {"lat": "41.000085", "long": "71.672579"},
    
    "18": {"lat": "39.654404", "long": "66.975827"},
    
    "22": {"lat": "37.229019", "long": "67.276754"},
    
    "24": {"lat": "40.838844", "long": "68.664229"},
    
    "26": {"lat": "41.311158", "long": "69.279737"},
    
    "27": {"lat": "41.042709", "long": "69.357612"},
    
    "30": {"lat": "40.389420", "long": "71.783009"},
    
    "33": {"lat": "41.549689", "long": "60.631377"},
    
    "35": {"lat": "42.460341", "long": "59.617996"},
  };
		

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  

  Future<BancomatesModel> getBancomates(BuildContext context) async {
    try {
      
      _responseBancomates = await BancomatesApi.instance.getBancomates(context);
      return _responseBancomates;
    } catch (e) {
      if (e is DioError) {
        FirebaseCrashlytics.instance.log(e.response!.data.toString());
        if (e.response!.statusCode == 401)
          return await RefreshTokenApi.instance
              .postRefreshToken()
              .then((value) async => await getBancomates(context));
      }
      return throw e;
    }
  }

  Future<BranchesModel> getBranches(BuildContext context) async {
    try {
      _responseBranches = await BranchesApi.instance.getBranches(context);
      
      

      return _responseBranches;
    } catch (e) {
      
      if (e is DioError) {
        
        FirebaseCrashlytics.instance.log(e.response!.data.toString());
        if (e.response!.statusCode == 401)
          return await RefreshTokenApi.instance
              .postRefreshToken()
              .then((value) async => await getBranches(context));
      }
      return throw e;
    }
  }

  Future<RegionsModel> getRegions(BuildContext context) async {
    try {
      final _responseBranches = await RegionsApi.instance.getRegions(context);
      return _responseBranches;
    } catch (e) {
      if (e is DioError) {
        FirebaseCrashlytics.instance.log(e.response!.data.toString());
        if (e.response!.statusCode == 401)
          return await RefreshTokenApi.instance
              .postRefreshToken()
              .then((value) async => await getRegions(context));
      }
      return throw e;
    }
  }
}
