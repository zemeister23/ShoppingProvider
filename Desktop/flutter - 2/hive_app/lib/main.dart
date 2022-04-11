import 'package:flutter/material.dart';
import 'package:hive_app/model/user_model.dart';
import 'package:hive_app/routes.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<User>(UserAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: '/profile',
      onGenerateRoute: (settings) => RouteManager.generateRoute(settings),
    );
  }
}
