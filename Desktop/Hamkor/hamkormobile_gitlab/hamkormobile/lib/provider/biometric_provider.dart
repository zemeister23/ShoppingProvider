import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobile/core/constants/error/alert_error.dart';
import 'package:mobile/core/constants/navigation/navigation_constant.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/models/bio_identification_model.dart';
import 'package:mobile/models/bio_registration.dart';
import 'package:mobile/models/settings_bio.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/service/api_service/bio_information_service.dart';
import 'package:mobile/service/api_service/bioregistration_service.dart';
import 'package:mobile/service/api_service/hamkorstore_service/bio_identification_service.dart';
import 'package:mobile/service/api_service/hamkorstore_service/client_bio-identification_service.dart';
import 'package:mobile/service/api_service/refref_token_api.dart';
import 'package:mobile/service/auth_service/auth_class.dart';
class BiometricProvider extends ChangeNotifier {
  final TextEditingController seriyesController = TextEditingController();
  final TextEditingController seriyesNumberController = TextEditingController();
  final TextEditingController dateBirthController = TextEditingController();
  ValidationItem _seriyes = ValidationItem(null, null);
  ValidationItem get seriyes => _seriyes;
  ValidationItem _seriyesNumber = ValidationItem(null, null);
  ValidationItem get seriyesNumber => _seriyesNumber;
  ValidationItem _dateBirth = ValidationItem(null, null);
  ValidationItem get dateBirth => _dateBirth;

  bool isNavigateHomePage = true;
  bool isLoading = false;
  bool isErorColor = false;
  bool get isValid {
    if (_seriyesNumber.value != null &&
        _seriyes.value != null &&
        _dateBirth.value != null) {
      return true;
    } else {
      return false;
    }
  }

  bool isBioScreen = false;
  clearInputField() {
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      seriyesController.clear();
      seriyesNumberController.clear();
      dateBirthController.clear();
      // _seriyesNumber = ValidationItem(null, null);
      // _seriyes = ValidationItem(null, null);
      // _dateBirth = ValidationItem(null, null);
      
      
      notifyListeners();
    });
  }

  BuildContext? ctx;
  void changeErorColor(bool state) {
    isErorColor = state;
    notifyListeners();
  }

  void changeSeries(String value) {
    if (value.length == 2) {
      _seriyes = ValidationItem(value, null);
    } else {
      _seriyes = ValidationItem(null, null);
    }
    //  notifyListeners();
  }
  changeSeriesNumber(String value) {
    if (value.length == 7) {
      _seriyesNumber = ValidationItem(value, null);
    } else {
      _seriyesNumber = ValidationItem(null, null);
    }
    notifyListeners();
  }
  changeDateBirth(String value) {
    if (value.length >= 10) {
      String v = "";
      List list = [];
      list.add(value);
      String day = list[0][0].toString() + list[0][1].toString();
      String month = list[0][3].toString() + list[0][4].toString();
      String year = list[0][6].toString() +
          list[0][7].toString() +
          list[0][8].toString() +
          list[0][9].toString();
      if (int.parse(day) <= 31 &&
          int.parse(month) <= 12 &&
          int.parse(year) > 1900) {
        v = year + "-" + month + "-" + day;
        
        
        
        changeErorColor(false);
        
        _dateBirth = ValidationItem(v, null);
      } else {
        changeErorColor(true);
      }
    } else {
      if (value.length >= 10) {
        changeErorColor(true);
      }
      _dateBirth = ValidationItem(null, null);
    }
    notifyListeners();
  }
  changeisLoading(bool s) {
    isLoading = s;
    notifyListeners();
  }
  Future postBioRegistration(String image, BuildContext context) async {
    
    
    try {
      BioRigistration bioData =
          await BioRegistrationApi.instance.postBioRegistration(image, context);
      if (bioData.data!.accessToken!.isNotEmpty &&
          bioData.data!.refreshToken!.isNotEmpty) {
        await GetStorageService.instance.box.write(
            GetStorageService.instance.accessToken, bioData.data!.accessToken!);
        await GetStorageService.instance.box.write(
            GetStorageService.instance.refreshToken,
            bioData.data!.refreshToken!);
      }
      await GetStorageService.instance.box
          .write(GetStorageService.instance.isAuthenticated, true);
     
      await GetStorageService.instance.box
          .write(GetStorageService.instance.signId, bioData.data!.signId!)
          // .then((value) => print(GetStorageService.instance.box
          //         .read(GetStorageService.instance.signId) +
          //     " SIGN ID 2"))
              ;
      // print(GetStorageService.instance.box
      //         .read(GetStorageService.instance.accessToken) +
      //     "ACSES TOKEN ");
      // print(GetStorageService.instance.box
      //         .read(GetStorageService.instance.refreshToken) +
      //     "REFRESH TOKEN");
      context.loaderOverlay.hide();
      if (bioData.data!.confirmMethod == "NO_CONFIRM") {
        NavigationService.instance.pushNamedRemoveUntil(
          routeName: NavigationConst.HOME_PAGE_VIEW,
        );
      } else {
        NavigationService.instance.pushNamed(
          routeName: NavigationConst.ADD_CARD_SMS_CODE_REGISTRATION_PAGE_VIEW,
        );
      }
      
      
    } catch (e) {
      
      context.loaderOverlay.hide();
      if (e is DioError) {
      //  
        
      }
      throw  Exception(e);
    }
  }
  Future<SettingsBio> bioSettings() async {
    try {
      SettingsBio _data =
          await BioInformationService.instance.getBioInformation();
          
      return _data;
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == 401)
          return await RefreshTokenApi.instance
              .postRefreshToken()
              .then((value) async => await bioSettings());
      }
      throw Exception(e);
    }
  }
  
  Future postBioIdentification(String image, BuildContext context) async {
    
    late Uri toLaunch;
    try {
      BioIdentificationModel bioData = await BioIdentificationService.instance
          .postBioIdentification(
              image, _seriyes.value!, _seriyesNumber.value!, _dateBirth.value!);
await GetStorageService.instance.box.write(
          GetStorageService.instance.accessToken, bioData.data!.accessToken);
      await GetStorageService.instance.box.write(
          GetStorageService.instance.accessToken, bioData.data!.refreshToken);
      toLaunch = bioData.data!.url == null
          ? Uri.parse("")
          : Uri.parse(bioData.data!.url.toString());
      context.loaderOverlay.hide();
      NavigationService.instance.pushNamed(
          routeName: NavigationConst.VIEW_ADD_CARD_WEB_PAGE, data: toLaunch);
    } catch (e) {
      
      
      context.loaderOverlay.hide();
      if (e is DioError) {
        

        if (e.response!.statusCode == 401)
          return await RefreshTokenApi.instance.postRefreshToken().then(
              (value) async => await postBioIdentification(image, context));

        if (e.response!.statusCode == 500) {
          ErrorMessage.instance
              .translationsEror(e.response!.data["error_code"], context);
        }
      }
      throw e;
    }
  }

  Future postClientBioIdentification(String image, BuildContext context) async {
    late Uri toLaunch;
    try {
      BioIdentificationModel bioData = await ClientBioIdentificationService
          .instance
          .postClientBioIdentification(image);
      await GetStorageService.instance.box.write(
          GetStorageService.instance.accessToken, bioData.data!.accessToken);
      await GetStorageService.instance.box.write(
          GetStorageService.instance.accessToken, bioData.data!.refreshToken);
      toLaunch = bioData.data!.url == null
          ? Uri.parse("")
          : Uri.parse(bioData.data!.url.toString());
      context.loaderOverlay.hide();
      NavigationService.instance.pushNamed(
          routeName: NavigationConst.VIEW_ADD_CARD_WEB_PAGE, data: toLaunch);
    } catch (e) {
      context.loaderOverlay.hide();
      if (e is DioError) {
        

        if (e.response!.statusCode == 401)
          return await RefreshTokenApi.instance.postRefreshToken().then(
              (value) async => await postBioIdentification(image, context));

        if (e.response!.statusCode == 500) {
          

          ErrorMessage.instance
              .translationsEror(e.response!.data["error_code"], context);
        }
      }
      throw e;
    }
  }
}
