import 'dart:convert';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_name_box.dart';
import 'package:mobile/core/init/cache/secure_storege.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:path_provider/path_provider.dart';

class HiveService<T>{

 static final HiveService _instance = HiveService._init();
  static HiveService get instance => _instance;
  
 Future<T> writeData({required String encKey,required String boxName,required T data}) async {
 try {
    final encryptionKey = await SecureStorege.instance.storage.read(key: encKey,);
  if (encryptionKey == null) {
    final key = Hive.generateSecureKey();
    await SecureStorege.instance.storage.write(
      key: encKey,
      value: base64UrlEncode(key),
    );
  }
 var dir  = await getApplicationDocumentsDirectory();
   Hive.init(dir.path);
  final key = await SecureStorege.instance.storage.read(key: encKey);
  final  e = base64Url.decode(key!);
  final encryptedBox= await Hive.openBox<T>(boxName, encryptionCipher: HiveAesCipher(e));
  encryptedBox.put(encKey, data);
  T? hiveData  = await encryptedBox.get(encKey);
  return  hiveData!;

 } catch (e) {
   
   
   throw e;
 }

}
 
Future<T> readBox({required String encKey,required String boxName})async{
   final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
    try {
      final encryptionKey = await SecureStorege.instance.storage.read(key: encKey,);
      
  if (encryptionKey == null) {
    final key = Hive.generateSecureKey();
    await SecureStorege.instance.storage.write(
      key: encKey,
      value: base64UrlEncode(key),
    );
  }
  final key = await SecureStorege.instance.storage.read(key: encKey);
  final  e = base64Url.decode(key!);
  

  final encryptedBox= await Hive.openBox<T>(boxName, encryptionCipher: HiveAesCipher(e));
  if(encryptedBox.get(encKey)  != null){
    return await encryptedBox.get(encKey)!;
  }
  else{
    throw T;
  }
    } catch (e) {
      
      
      
      return throw "Null";
    }
 }
 Future deleteBox()async{
   final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
    try {
await SecureStorege.instance.storage.deleteAll();
var hiveDb = await Directory('${appDocumentDirectory.path}');
hiveDb.delete();
await Hive.deleteFromDisk().then((value)async {
  
 await readBox(encKey: Endpoints.clientCards, boxName: HiveBoxName.CLIENT_CARDS);
 
});
await Hive.close();

 await readBox(encKey: Endpoints.clientCards, boxName: HiveBoxName.CLIENT_CARDS).then((value){
  
 }).catchError((v){
  
 });
    } catch (e) {
     
      
     
    }
  
 }


  HiveService._init();

}