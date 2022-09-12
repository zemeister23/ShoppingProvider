import 'package:flutter/material.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';

class TextStyleCompanents extends TextStyle{
     static TextStyleCompanents? _instance;
  static TextStyleCompanents get instance => TextStyleCompanents._init();
  TextStyleCompanents._init();
 final hineTextStyle = TextStyle(
              color: ColorConst.instance.kElementsColor,
              fontSize: FontSizeConst.instance.large,
              fontWeight: FontWeight.w400,
              );

}