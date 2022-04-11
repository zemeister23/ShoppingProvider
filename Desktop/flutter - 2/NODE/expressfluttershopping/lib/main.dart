import 'package:expressfluttershopping/provider/market_provider.dart';
import 'package:expressfluttershopping/screens/constants/theme_const.dart';
import 'package:expressfluttershopping/screens/home/home_page_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MarketProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeConst.mainTheme,
      home: MyHomePage(),
    );
  }
}
