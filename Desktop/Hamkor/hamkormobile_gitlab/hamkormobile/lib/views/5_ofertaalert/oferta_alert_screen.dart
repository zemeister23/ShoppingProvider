import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/widgets/new_dialog/hamkor_dialog_2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';

class OfertaAlertScreen extends StatefulWidget {
  const OfertaAlertScreen({Key? key}) : super(key: key);
  @override
  State<OfertaAlertScreen> createState() => _OfertaAlertScreenState();
}

class _OfertaAlertScreenState extends State<OfertaAlertScreen> {
  @override
  void initState() {
    _showDialog();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SwipeInGoBack(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: context.h,
          width: context.w,
          color: Colors.white,
        ),
      ),
    );
  }

  alertText() {
    return AutoSizeText.rich(
      TextSpan(
        text: "oferta_alert_text_1".locale,
        style: TextStyle(
          fontSize: FontSizeConst.instance.small,
          color: ColorConst.instance.kSecondaryTextColor,
          fontWeight: FontWeight.w400
        ),
        children: [
          TextSpan(
            text: " " + "oferta_alert_text_2".locale,
            style: TextStyle(
              fontSize: FontSizeConst.instance.small,
              color: ColorConst.instance.kPrimaryColor,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                
                NavigationService.instance.pushNamed(routeName: "/4_oferta");
              },
          ),
        ],
      ),
      textAlign: TextAlign.center,
      minFontSize: 1,
      maxFontSize: 17,
    );
  }

  _showDialog() async {
    await Future.delayed(const Duration(milliseconds: 50));
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return SwipeInGoBack(
            onWillPop: () async => false,
            child: HamkorDialog2(
              shadowColor:Colors.transparent,
              titleDone: false,
              title: "",
              subtitle: alertText(),
              buttonTextBottom: "accept".locale,
              onPressedTop: () {
                NavigationService.instance.pushNamed(routeName: "/6_pincode");
              },
            ),
          );
        });
  }
}
