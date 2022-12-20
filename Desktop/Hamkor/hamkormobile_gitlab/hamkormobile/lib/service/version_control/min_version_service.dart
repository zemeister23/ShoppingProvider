import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/core/network/dio/dio_client.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/language_model.dart';
import 'package:mobile/service/device_service/pacage_service.dart';

import '../../core/constants/error/alert_error.dart';
import '../../models/min_version_model.dart';

class MinVersionService {
  static final MinVersionService _instance = MinVersionService._init();
  static MinVersionService get instance => _instance;
  Future<MinVersionModel> getLanguageModel() async {
    final packageInfo = await PackageInfoApi.getInfo();
    await GetStorageService.instance.box.write(
        GetStorageService.instance.version, packageInfo["version"].toString());
    try {
      final response = await DioClient.instance.get(Endpoints.minVersion);

      return MinVersionModel.fromJson(response);
    } catch (e) {
      if (e is DioError) {
        FirebaseCrashlytics.instance.log(e.response!.data.toString());
        
      }
      throw e;
    }
  }

  Future<void> checkVersion(BuildContext context) async {
    try {
      MinVersionModel version =
          await MinVersionService.instance.getLanguageModel();
      String minVersion =
          // "1.1.1";
          version.data![0].appMinVersion!;
      String mobileCurrentVersion =
          // "1.1.1";
          GetStorageService.instance.box
              .read(GetStorageService.instance.version);
      // print(
      //     "VERSIONNNNNNNNNNN: ${GetStorageService.instance.box.read(GetStorageService.instance.version)}");
      var min = minVersion.split(".");
      var newv = mobileCurrentVersion.split(".");
      if (int.parse(min[0]) < int.parse(newv[0])) {
        
      } else if (int.parse(min[0]) == int.parse(newv[0])) {
        if (int.parse(min[1]) < int.parse(newv[1])) {
          
        } else if (int.parse(min[1]) == int.parse(newv[1])) {
          if (int.parse(min[2]) <= int.parse(newv[2])) {
            
          } else {
            
            ErrorMessage.instance.translationsEror(1027, context);
          }
        } else {
          
          ErrorMessage.instance.translationsEror(1027, context);
        }
      } else {
        
        ErrorMessage.instance.translationsEror(1027, context);
      }

      // if (int.parse(min[0]) <= int.parse(newv[0]) &&
      //     int.parse(min[1]) <= int.parse(newv[1]) &&
      //     int.parse(min[2]) <= int.parse(newv[2])) {
      //   
      // } else {
      //   
      //   ErrorMessage.instance.erorAddCardAlert("1027", context);
      // }
    } catch (e) {}
  }

  MinVersionService._init();
}
