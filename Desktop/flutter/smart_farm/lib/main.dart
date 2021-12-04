import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/constants.dart';
import 'package:smart_farm/home/home_page.dart';
import 'package:smart_farm/login/sign_in.dart';
import 'package:smart_farm/service/firebase_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Smart Farm',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColorLight: kPrimaryColor,
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kPrimaryBackgroundColor,
        appBarTheme: const AppBarTheme(backgroundColor: kPrimaryColor),
        textTheme: const TextTheme(
            bodyText1: TextStyle(color: Colors.black),
            bodyText2: TextStyle(color: Colors.black)),
      ),
      home: FirebaseService.auth.currentUser != null ? HomePage() : SignIn(),
    );
  }
}
