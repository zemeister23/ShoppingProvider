import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobile/core/constants/error/alert_error.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/core/network/dio/dio_client.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/bio_registration.dart';
import 'package:mobile/service/api_service/refref_token_api.dart';

class BioRegistrationApi {
  static final BioRegistrationApi _instance = BioRegistrationApi._init();
  static BioRegistrationApi get instance => _instance;
  Future<BioRigistration> postBioRegistration(
    String image,
    BuildContext context,
  ) async {
    print("POST ${GetStorageService.instance.box
          .read(GetStorageService.instance.signId)
          .toString()}");
    var data = {
      "device_id": GetStorageService.instance.box
          .read(GetStorageService.instance.deviceInfo),
      "device_info":
          GetStorageService.instance.box.read(GetStorageService.instance.model),
      "photo": {
        "front": "data:image/png;base64," + image,
      },
      "sign_id": GetStorageService.instance.box
          .read(GetStorageService.instance.signId)
          .toString(),
    };
    try {
      final response = await DioClient.instance.post(
        Endpoints.baseUrl + Endpoints.bioRegistration,
        data: data,
        options: Options(
          headers: Endpoints.headers(),
        ),
      );
     
      context.loaderOverlay.hide();
      return BioRigistration.fromJson(response);
    } catch (e) {
 

      context.loaderOverlay.hide();
      if (e is DioError) {
 FirebaseCrashlytics.instance.log(e.response!.data.toString());
        
        if (e.response!.statusCode == 500) {
          ErrorMessage.instance
              .translationsEror(e.response!.data["error_code"], context);
        }
        if (e.response!.statusCode == 401)
          return await RefreshTokenApi.instance.postRefreshToken().then(
                (value) async => await postBioRegistration(
                  image,
                  context,
                ),
              );
        if (e.response!.statusCode == 422) {
          ErrorMessage.instance
              .translationsEror(e.response!.data["error_code"], context);
        }
        }
      throw e;
    }
  }
  BioRegistrationApi._init();
}
