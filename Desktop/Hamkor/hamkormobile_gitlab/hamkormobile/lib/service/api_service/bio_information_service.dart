import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/core/network/dio/dio_client.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/offerta_model.dart';
import 'package:mobile/models/settings_bio.dart';
import 'package:mobile/service/api_service/refref_token_api.dart';

import '../../models/refresh_token_model.dart';

class BioInformationService {
  static final BioInformationService _instance = BioInformationService._init();
  static BioInformationService get instance => _instance;
  Future<SettingsBio> getBioInformation() async {
    try {
      final response = await DioClient.instance
          .get('${Endpoints.baseUrl}${Endpoints.bioInformation}',
              options: Options(
                headers: Endpoints.headers(),
              ));
      return SettingsBio.fromJson(response);
    } catch (e) {
      if (e is DioError) {
        FirebaseCrashlytics.instance.log(e.response!.data.toString());
        if (e.response!.statusCode == 401) {
          return await RefreshTokenApi.instance
              .postRefreshToken()
              .then((value) async => await getBioInformation());
        }
         if (e.response!.statusCode == 404) {
          
         }

      }
      throw e;
    }
  }

  BioInformationService._init();
}
// is_smail
// size
// resolution