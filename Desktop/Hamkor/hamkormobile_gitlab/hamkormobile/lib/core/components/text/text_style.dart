import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';

class TextStyleCompanents extends TextStyle {
  static TextStyleCompanents? _instance;
  static TextStyleCompanents get instance => TextStyleCompanents._init();
  TextStyleCompanents._init();
  final hineTextStyle = TextStyle(
    color: ColorConst.instance.kElementsColor,
    fontSize: FontSizeConst.instance.large,
    fontWeight: FontWeight.w400,
  );
 final alertTextStyle =   TextStyle(
           fontWeight: FontWeight.w400,
              fontSize: FontSizeConst.instance.small,
              color: ColorConst.instance.kSecondaryTextColor,
            );
 final alertErrorTextStyle =   TextStyle(
           fontWeight: FontWeight.w400,
              fontSize: FontSizeConst.instance.small,
              color: ColorConst.instance.kErrorColor,
            );
            final historyEmtyText =   TextStyle(
           fontWeight: FontWeight.w400,
           fontStyle: FontStyle.normal,
              fontSize: FontSizeConst.instance.bottom,
              color: ColorConst.instance.kSecondaryTextColor,
            );
                     
                       
}
