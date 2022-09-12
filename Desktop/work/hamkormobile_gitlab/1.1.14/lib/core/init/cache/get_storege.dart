import 'package:get_storage/get_storage.dart';

class GetStorageService {
 
  static final GetStorageService _instance = GetStorageService._init();
  static GetStorageService get instance => _instance;
  
  GetStorageService._init();

  final box = GetStorage();

 final String signId = 'sign_id';
 final String deviceInfo = 'device_info';
 final String model = 'model';
 final String systemName = 'system_name';
 final String version = 'version';
 final String telNomer  = "tel_nomer";
 final String accessToken  = "access_token" ;
 final String refreshToken  = "refresh_token" ;
 final String ofertaText  = "oferta_text" ;
 final String language  = "language" ;
final String blockCapacity  = "bloc_capasity";
final String blockState  = "bloc_state";
final String pageState  = "page_state";
final String uiTelNomer  = "ui_telnomer";
final String cardidList  = "card_id_list";
final String name  = "user_name";
final String isLockScreenShowed  = "isLockScreenShowed";
final String isLocked = "isLocked";
final String isAuthenticated= "isAuthenticated";
final String toLaunch= "to_launch";
final String afterPageContext = "afterPageContext";













}