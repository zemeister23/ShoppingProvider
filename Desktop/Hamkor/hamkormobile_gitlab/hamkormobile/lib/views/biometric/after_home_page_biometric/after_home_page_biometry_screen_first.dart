import 'dart:io';
import 'package:camera/camera.dart';
import 'package:camera_process/camera_process.dart';
import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/core/base/view/base_view.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/images/image_const.dart';
import 'package:mobile/core/constants/navigation/navigation_constant.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/models/settings_bio.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/views/biometric/after_home_page_biometric/after_home_page_biometry_screen_camera_for_android.dart';
import 'package:mobile/widgets/appbar/default_appbar.dart';
import 'package:mobile/widgets/gradient_button_widget.dart';
import 'package:permission_handler/permission_handler.dart';

List<CameraDescription> cameras = [];
double dl = 0.0, dr = 0.0, dt = 0.0, db = 0;
double height = 0.0;
double width = 0.0;
Color paintColor = Colors.white;
bool isIos = Platform.isIOS;
List<Face> myfaces = [];
double scale = 1;
bool openEyes = true;

class AfterHomePageBiometricFirst extends StatefulWidget {
  AfterHomePageBiometricFirst({
    Key? key,
  }) : super(key: key);

  @override
  State<AfterHomePageBiometricFirst> createState() =>
      _AfterHomePageBiometricFirstState();
}

class _AfterHomePageBiometricFirstState
    extends State<AfterHomePageBiometricFirst> {
  Future<SettingsBio?>? bioData;
  @override
  void initState() {
    super.initState();
    givePermissionStorage();
    bioData = context.biometricPr.bioSettings();
  }

  Future<void> givePermissionStorage() async {
    var status = await Permission.storage;
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      onPageBuilder: (BuildContext context, value) => SwipeInGoBack(
        onWillPop: () async {
          context.biometricPr.isBioScreen
              ? NavigationService.instance.pushNamedRemoveUntil(
                  routeName: NavigationConst.AFTER_HOME_PAGE_BIOMETRIC_PAGE)
              : NavigationService.instance.pushNamedRemoveUntil(
                  routeName: NavigationConst.HOME_PAGE_VIEW);

          return true;
        },
        child: Scaffold(
            appBar: DefaultAppbar.getAppBar(
              "",
              () {
                // print(
                //     "000000000 -------> : ${context.biometricPr.isBioScreen}");
                context.biometricPr.isBioScreen
                    ? NavigationService.instance.pushNamedRemoveUntil(
                        routeName:
                            NavigationConst.AFTER_HOME_PAGE_BIOMETRIC_PAGE)
                    : NavigationService.instance.pushNamedRemoveUntil(
                        routeName: NavigationConst.HOME_PAGE_VIEW);
              },
              context,
              true,
            ),
            body: FirstView(
              onPressed: () async {
                cameras = await availableCameras();
                SettingsBio? mySettignsBio = await bioData;
                bool isSmile = mySettignsBio == null
                    ? false
                    : mySettignsBio.data!.isSmile!;
                String resolution = mySettignsBio == null
                    ? "720"
                    : mySettignsBio.data!.resolution!;
                availableCameras().then((value) async {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AfterHomePageBiometricCameraAndroid(
                              cameras: value,
                              isSmile: isSmile,
                              resolution: resolution,
                            )),
                    (r) => false,
                  );
                });
            
              },
            )),
      ),
      viewModal: AfterHomePageBiometricFirst,
    );
  }
}

class FirstView extends StatefulWidget {
  final VoidCallback? onPressed;

  FirstView({
    required this.onPressed,
  });
  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<FirstView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.w * 0.04),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "confirm_face".locale,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorConst.instance.kMainTextColor,
                      fontSize: FontSizeConst.instance.extraLarge,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: context.h * 0.02),
                  Text(
                    "biometry_text".locale,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorConst.instance.kSecondaryTextColor,
                      fontSize: FontSizeConst.instance.medium,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: context.h * 0.03),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Lottie.asset(
                    ImageConst.instance.face_scan,
                    height: context.h * 0.35,
                  ),
                  GradientButton(
                      color: ColorConst.instance.kPrimaryColor,
                      width: context.w * 0.9,
                      height: context.h * 0.07,
                      text: "start".locale,
                      colorOpacity: true,
                      onPressed: widget.onPressed),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
