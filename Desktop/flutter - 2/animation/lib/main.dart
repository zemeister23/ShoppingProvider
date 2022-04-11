import 'package:animation/pages/home/my_home_page.dart';
import 'package:animation/pages/introduction/intro_view_page.dart';
import 'package:animation/services/get_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: GetService.box.read('isDone') ?? false
          ? MyHomePage()
          : const IntroViewPage(),
    );
  }
}
