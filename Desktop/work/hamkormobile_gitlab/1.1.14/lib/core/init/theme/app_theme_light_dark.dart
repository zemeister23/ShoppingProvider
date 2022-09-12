import 'package:flutter/material.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/core/init/theme/app_theme.dart';

class AppThemeLightDark extends AppTheme {
  static AppThemeLightDark? _instance;
  static AppThemeLightDark get instance {
    _instance ??= AppThemeLightDark._init();
    return _instance!;
  }

  AppThemeLightDark._init();

  ThemeData get dark => ThemeData();

  ThemeData get light => ThemeData(
        fontFamily: "Segoe",
        // fontFamily: FONT_FAMILY, // ! FONT_FAMILY
        colorScheme: ColorScheme(
          background: ColorConst.instance.kBackgroundColor,
          brightness: Brightness.light,
          error: ColorConst.instance.kErrorColor,
          onBackground: ColorConst.instance.kBackgroundColor,
          onError: ColorConst.instance.kErrorColor,
          onPrimary: ColorConst.instance.kPrimaryColor,
          onSecondary: ColorConst.instance.kSecondaryTextColor,
          onSurface: ColorConst.instance.kBackgroundColor,
          primary: ColorConst.instance.kPrimaryColor,
          secondary: ColorConst.instance.kSecondaryTextColor,
          surface: ColorConst.instance.kBackgroundColor,
        ),
        scaffoldBackgroundColor: ColorConst.instance.kBackgroundColor, //xx
        bottomAppBarColor: ColorConst.instance.kBottomBarColor,
        cardColor: Color(0xffffffff),
        dividerColor: Color(0xffffffff), //XX
        highlightColor: Color(0x66bcbcbc),
        splashColor: Color(0xffE8E8E8),
        selectedRowColor: Color(0xfff5f5f5),
        unselectedWidgetColor: Color(0x8a000000),
        disabledColor: Color(0x61000000), //xx
        toggleableActiveColor: Color(0xffe53935),
        secondaryHeaderColor: Color(0xffffebee),
        toggleButtonsTheme: const ToggleButtonsThemeData(
            fillColor: Color(0xffC20003),
            textStyle: TextStyle(color: Colors.white),
            selectedColor: Colors.white),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: ColorConst.instance.kPrimaryColor,
          splashColor: ColorConst.instance.kPrimaryColor.withOpacity(0.7),
        ),
        dialogBackgroundColor: const Color(0xffffffff),
        indicatorColor: const Color(0xffC20003), //XX
        hintColor: const Color(0x8a000000), //xx
        errorColor: const Color(0xffd32f2f),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: ColorConst.instance.kBackgroundColor,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: ColorConst.instance.kMainTextColor,
          ),
        ),

        textTheme: TextTheme(
          headline1: FontstyleText.instance.headline1TextStyle,
          headline2: FontstyleText.instance.headline2TextStyle,
          headline3: FontstyleText.instance.headline3TextStyle,
          headline4: FontstyleText.instance.headline4TextStyle,
          headline5: FontstyleText.instance.headline5TextStyle,
          headline6: FontstyleText.instance.headline6TextStyle,
          subtitle1: TextStyle(
            color: ColorConst.instance.kSecondaryTextColor,
            fontSize: 17,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
          ),
          bodyText1: FontstyleText.instance.bodyText1,
          bodyText2: FontstyleText.instance.body2TextStyle,
          caption: FontstyleText.instance.appBarTextStyle,
          button: FontstyleText.instance.buttonTextStyle,
          subtitle2: FontstyleText.instance.subtytle2,
          overline: TextStyle(
            color: ColorConst.instance.kMainTextColor,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
        ),
        primaryTextTheme: const TextTheme(
          headline1: TextStyle(
            color: Color(0xfffafafa),
            fontSize: 35,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
          ),
          headline2: TextStyle(
            color: Color(0xfffafafa),
            fontSize: 30,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          headline3: TextStyle(
            color: Color(0xfffafafa),
            fontSize: 25,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          headline4: TextStyle(
            color: Color(0xfffafafa),
            fontSize: 20,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          headline5: TextStyle(
            color: Color(0xfffafafa),
            fontSize: 15,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          headline6: TextStyle(
            color: Color(0xfffafafa),
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          subtitle1: TextStyle(
            color: Color(0xfffafafa),
            fontSize: 15,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          bodyText1: TextStyle(
            color: Color(0xfffafafa),
            fontSize: null,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          bodyText2: TextStyle(
            color: Color(0xffffffff),
            fontSize: null,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          caption: TextStyle(
            color: Color(0xb3ffffff),
            fontSize: null,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            overflow: TextOverflow.ellipsis
          ),
          button: TextStyle(
            color: Color(0xffffffff),
            fontSize: 17,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
          ),
          subtitle2: TextStyle(
            color: Colors.green,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
          ),
          overline: TextStyle(
            color: Color(0xffffffff),
            fontSize: null,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
        ),

        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(
            color: Color(0xdd000000),
            fontSize: null,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          helperStyle: TextStyle(
            color: Color(0xdd000000),
            fontSize: null,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          hintStyle: TextStyle(
            color: Color(0xdd000000),
            fontSize: null,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          errorStyle: TextStyle(
            color: Color(0xdd000000),
            fontSize: null,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          errorMaxLines: null,
          isDense: false,
          contentPadding:
              EdgeInsets.only(top: 12, bottom: 12, left: 0, right: 0),
          isCollapsed: false,
          prefixStyle: TextStyle(
            color: Color(0xdd000000),
            fontSize: null,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          suffixStyle: TextStyle(
            color: Color(0xdd000000),
            fontSize: null,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          counterStyle: TextStyle(
            color: Color(0xdd000000),
            fontSize: null,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          filled: false,
          fillColor: Color(0x00000000),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff000000),
              width: 1,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff000000),
              width: 1,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff000000),
              width: 1,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff000000),
              width: 1,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff000000),
              width: 1,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff000000),
              width: 1,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
        ),
        iconTheme: IconThemeData(
          color: ColorConst.instance.kMainTextColor,
          opacity: 1,
          size: 24,
        ),
        primaryIconTheme: const IconThemeData(
          color: Color(0xffffffff),
          opacity: 1,
          size: 24,
        ),

        sliderTheme: const SliderThemeData(
          activeTrackColor: null,
          inactiveTrackColor: null,
          disabledActiveTrackColor: null,
          disabledInactiveTrackColor: null,
          activeTickMarkColor: null,
          inactiveTickMarkColor: null,
          disabledActiveTickMarkColor: null,
          disabledInactiveTickMarkColor: null,
          thumbColor: null,
          disabledThumbColor: null,
          thumbShape: null,
          overlayColor: null,
          valueIndicatorColor: null,
          valueIndicatorShape: null,
          showValueIndicator: null,
          valueIndicatorTextStyle: TextStyle(
            color: Color(0xffffffff),
            fontSize: null,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
        ),
        tabBarTheme: const TabBarTheme(
          //xx
          labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontSize: 10),
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Color(0xffffffff),
          unselectedLabelColor: Color(0xb2ffffff),
        ),
        chipTheme: const ChipThemeData(
          backgroundColor: Color(0x1f000000),
          brightness: Brightness.light,
          deleteIconColor: Color(0xde000000),
          disabledColor: Color(0x0c000000),
          labelPadding: EdgeInsets.only(top: 0, bottom: 0, left: 8, right: 8),
          labelStyle: TextStyle(
            color: Color(0xde000000),
            fontSize: null,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          padding: EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
          secondaryLabelStyle: TextStyle(
            color: Color(0x3d000000),
            fontSize: null,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          secondarySelectedColor: Color(0x3df44336),
          selectedColor: Color(0x3d000000),
          shape: StadiumBorder(
              side: BorderSide(
            color: Color(0xff000000),
            width: 0,
            style: BorderStyle.none,
          )),
        ),
        dialogTheme: const DialogTheme(
            shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Color(0xff000000),
            width: 0,
            style: BorderStyle.none,
          ),
          borderRadius: BorderRadius.all(Radius.circular(0.0)),
        )),
      );
}
