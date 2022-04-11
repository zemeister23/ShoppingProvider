import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:providers/provider/drop_provider.dart';
import 'package:providers/provider/sign_in_provider.dart';
import 'package:providers/provider/theme_mode_provider.dart';
import 'package:providers/screen/home/my_home_page.dart';

void main() async {
  await GetStorage.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignInProvider()),
        ChangeNotifierProvider(create: (context) => ThemeChangerProvider()),
        ChangeNotifierProvider(create: (context) => DropProvider()),
      ],
      child: const MyApp(),
    ),
    // MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: MyHomePage(),
      themeMode: context.watch<ThemeChangerProvider>().themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.orange,
        primaryColor: Colors.orange,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.orange),
      ),
    );
  }
}
//  JIT AOT - JUST IN TIME , AHAED OF TIME