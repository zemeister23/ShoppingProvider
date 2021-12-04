import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_farm/constants.dart';
import 'package:smart_farm/home/home_page.dart';
import 'package:smart_farm/login/sign_in.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
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
      home: SignIn(),
    );
  }
}
