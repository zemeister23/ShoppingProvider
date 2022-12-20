import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:mobile/routes/router/i_navigation_service.dart';

class NavigationService implements INavigationService {
  static final NavigationService _instance = NavigationService._init();
  static NavigationService get instance => _instance;
  NavigationService._init();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Future pushNamed({
    required String routeName,
    Object? data,
   
  }) async {
    return await navigatorKey.currentState!.pushNamed(
      routeName,
      arguments: data,
    );
  }
  @override
  Future pushNamedRemoveUntil({required String routeName, Object? data}) async {
    return await navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: data,
    );
  }
   Future popUnitelNamedRemoveUntil({required String routeName, Object? data}) async {
    return await navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: data,
    );
  }
}
