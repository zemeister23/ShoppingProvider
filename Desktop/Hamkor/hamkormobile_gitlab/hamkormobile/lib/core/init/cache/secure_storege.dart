import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorege {
 
  static final SecureStorege _instance = SecureStorege._init();
  static SecureStorege get instance => _instance;
  
  SecureStorege._init();

final storage = new FlutterSecureStorage();
 
static const String getClientCards = 'get_client_cards';
 

}