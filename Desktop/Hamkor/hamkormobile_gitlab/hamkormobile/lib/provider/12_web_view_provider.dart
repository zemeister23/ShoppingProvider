import 'package:flutter/widgets.dart';
import 'package:mobile/models/bio_identification_model.dart';
import 'package:mobile/models/web_view_bio_public_identify_model.dart';
import 'package:mobile/service/api_service/web_view_service/biometric_public_%20identify_service.dart';
import 'package:provider/provider.dart';

class WebViewProvider extends ChangeNotifier{
  String cToken = "";
 // String get cToken => _cToken;
   String oauth = "";
 // String get oauth => _oauth;
   String failureUrl = "";
 // String get failureUrl => _failureUrl;
Future<BioPublicIdentifyModel> bioPublicIdentify(BuildContext context,String image)async{
 try {
   BioPublicIdentifyModel data = await BioPublicIdentify.instance.biometricPublicIdentify(context, image);
  return data;
 } catch (e) {
  
   return throw e;
 }
}

}