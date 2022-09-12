import 'package:flutter/material.dart';
import 'package:mobile/screens/home/home_page_view.dart';

class MyRoute {
  Route? routes(RouteSettings settings) {
    var args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => HomePage(),
        );
    }
  }
}
