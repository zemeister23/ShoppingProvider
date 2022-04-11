import 'package:flutter/material.dart';
import 'package:hive_app/screens/home.dart';
import 'package:hive_app/screens/profile.dart';

class RouteManager {
  static generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      case '/profile':
        return MaterialPageRoute(
          builder: (_) => ProfilePage(data: args),
        );
    }
  }
}
