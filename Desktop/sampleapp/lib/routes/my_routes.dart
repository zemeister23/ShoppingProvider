import 'package:flutter/material.dart';
import 'package:sampleapp/screen/home/home_page.dart';

class MyRoutes {
  Route? myRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => HomePage(),
        );
    }
  }
}
