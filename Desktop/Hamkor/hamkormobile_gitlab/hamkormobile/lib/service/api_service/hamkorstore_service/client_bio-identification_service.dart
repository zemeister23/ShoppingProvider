import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/core/constants/error/alert_error.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/core/network/dio/dio_client.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/bio_identification_model.dart';
import 'package:mobile/models/phone_registration.dart';

class ClientBioIdentificationService {
  static final ClientBioIdentificationService _instance = ClientBioIdentificationService._init();
  static ClientBioIdentificationService get instance => _instance;
  Future<BioIdentificationModel> postClientBioIdentification(String image,) async {
  
    var _data = {
  "doc_type": 1,
  "photo": {
    "front": "data:image/png;base64," + image
  }
  
}; 
  
   try {
      final response = await DioClient.instance.post(
        '${Endpoints.baseUrl}${Endpoints.clientBioIdentification}',
        data: _data,
        options: Options(
          headers: Endpoints.headers(),
        )
      ); return BioIdentificationModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  ClientBioIdentificationService._init();
}
