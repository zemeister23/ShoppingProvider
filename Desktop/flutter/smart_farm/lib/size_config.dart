import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData? _mediaQuery;
  static double? screenWidth;
  static double? screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQuery = MediaQuery.of(context);
    screenHeight = _mediaQuery!.size.height;
    screenWidth = _mediaQuery!.size.width;
    orientation = _mediaQuery!.orientation;
  }
}

double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight!;

  return (inputHeight / 640.0) * screenHeight;
}

double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth! ;

  return (inputWidth / 360.0) * screenWidth;
}
