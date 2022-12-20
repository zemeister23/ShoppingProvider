import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FontSizeConst {
  static final FontSizeConst _instance = FontSizeConst._init();
  static FontSizeConst get instance => _instance;
  FontSizeConst._init();

  double extraSmall = 12.0.sp;
  double small = 15.0.sp;
  double medium = 17.0.sp;
  double small2 = 13.sp;
  double bottom = 15.sp;
  double large = 18.0.sp;
  double maptext = 16.0.sp;
  double inputnumber = 20.0.sp;
  double extraLarge = 22.0.sp;
  double pinNumberSize = 32.0.sp;
  double maxSize = 34.0.sp;
  double mainPageUZSSize = 25.0.sp;
  double maxSmall = 11.0.sp;
  double buttonSize2 = 11.0.sp;
}

class FontstyleText {
  static final FontstyleText _instance = FontstyleText._init();
  static FontstyleText get instance => _instance;
// header text style
  final TextStyle headline1TextStyle = TextStyle(
    color: ColorConst.instance.kMainTextColor,
    fontSize: FontSizeConst.instance.maxSize,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
  );

  final TextStyle profilePageListTile = TextStyle(
    color: ColorConst.instance.kButtonColor.withOpacity(0.86),
    fontSize: FontSizeConst.instance.inputnumber,
    fontWeight: FontWeight.w600,
  );
  // pin code number style,
  final TextStyle headline2TextStyle = TextStyle(
    color: ColorConst.instance.kMainTextColor,
    fontSize: FontSizeConst.instance.pinNumberSize,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );

  final TextStyle headline3TextStyle = TextStyle(
    color: ColorConst.instance.kMainTextColor,
    fontSize: FontSizeConst.instance.inputnumber,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );
  final TextStyle headline4TextStyle = TextStyle(
    color: ColorConst.instance.kMainTextColor,
    fontSize: FontSizeConst.instance.inputnumber,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
  );
  // input number form style
  final TextStyle headline5TextStyle = TextStyle(
    color: ColorConst.instance.kMainTextColor,
    fontSize: FontSizeConst.instance.inputnumber,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );
  final TextStyle headline6TextStyle = TextStyle(
    color: ColorConst.instance.kMainTextColor,
    fontSize: 25,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );
// subttle auth
  final TextStyle subtytle2 = TextStyle(
    color: ColorConst.instance.kSecondaryTextColor,
    fontSize: FontSizeConst.instance.medium,
    fontWeight: FontWeight.w600,
  );
// button text style
  final buttonTextStyle = TextStyle(
    color: ColorConst.instance.kButtonColor,
    fontSize: FontSizeConst.instance.medium,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
  );
// eror text auth
  final TextStyle body2TextStyle = TextStyle(
    color: ColorConst.instance.kSecondaryTextColor,
    fontSize: FontSizeConst.instance.small2,
    fontWeight: FontWeight.w600,
  );
  final TextStyle appBarTextStyle = TextStyle(
    color: ColorConst.instance.kMainTextColor,
    fontSize: FontSizeConst.instance.medium,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
  );
  final TextStyle bodyText1 = TextStyle(
    color: ColorConst.instance.kMainTextColor,
    fontSize: FontSizeConst.instance.medium,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );

  final TextStyle mainPageCheck = TextStyle(
      color: ColorConst.instance.kButtonColor,
      fontSize: FontSizeConst.instance.maxSize,
      fontWeight: FontWeight.w600,
      fontFamily: "OpenSans");

  final TextStyle mainPageUZS = TextStyle(
    color: ColorConst.instance.kButtonColor,
    fontSize: FontSizeConst.instance.mainPageUZSSize,
    //fontWeight: ,
  );

  final TextStyle mainPageLeading = TextStyle(
    color: ColorConst.instance.kButtonColor,
    fontSize: FontSizeConst.instance.small,
    fontWeight: FontWeight.w600,
  );

  final TextStyle mainPageMultiWithUzcard = TextStyle(
    color: ColorConst.instance.kSecondaryTextColor,
    fontSize: FontSizeConst.instance.small,
    fontWeight: FontWeight.w400,
  );

  final TextStyle subsText = TextStyle(
    color: ColorConst.instance.kSecondaryTextColor,
    fontSize: FontSizeConst.instance.small,
    fontWeight: FontWeight.w600,
  );

  final TextStyle mainPageCurrencyText = TextStyle(
    color: ColorConst.instance.kGreenColor,
    fontSize: FontSizeConst.instance.large,
    fontWeight: FontWeight.w600,
  );

  final TextStyle bottomNavBarDisableText = TextStyle(
    color: ColorConst.instance.kSecondaryTextColor,
    fontSize: FontSizeConst.instance.extraSmall,
    fontWeight: FontWeight.w400,
  );

  final TextStyle bottomNavBarAbleText = TextStyle(
    color: ColorConst.instance.kGreenColor,
    fontSize: FontSizeConst.instance.extraSmall,
    fontWeight: FontWeight.w400,
  );
  final TextStyle smsErorTextStyle = TextStyle(
    color: ColorConst.instance.kErrorColor,
    fontSize: FontSizeConst.instance.small2,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );

  FontstyleText._init();
}
