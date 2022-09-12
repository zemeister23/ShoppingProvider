import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/core/base/view/base_view.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/images/image_const.dart';
import 'package:mobile/core/constants/navigation/navigation_constant.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/widgets/appbar/default_appbar.dart';
import 'package:mobile/widgets/gradient_button_widget.dart';
import 'package:permission_handler/permission_handler.dart';

class AfterHomePageBiometricFirstAd extends StatefulWidget {
  AfterHomePageBiometricFirstAd({
    Key? key,
  }) : super(key: key);

  @override
  State<AfterHomePageBiometricFirstAd> createState() =>
      _AfterHomePageBiometricFirstState();
}

class _AfterHomePageBiometricFirstState
    extends State<AfterHomePageBiometricFirstAd> {
  @override
  void initState() {
    super.initState();
    givePermissionStorage();
  }

  Future<void> givePermissionStorage() async {
    var status = await Permission.storage;
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      onPageBuilder: (BuildContext context, value) => WillPopScope(
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
              context.biometricPr.isBioScreen
                  ? NavigationService.instance.pushNamedRemoveUntil(
                      routeName: NavigationConst.AFTER_HOME_PAGE_BIOMETRIC_PAGE)
                  : Navigator.pop(context);
              Navigator.pop(context);
              context.homePr.changeIndex(0);
            },
            context,
            true,
          ),
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
                        style: TextStyle(
                          color: ColorConst.instance.kMainTextColor,
                          fontSize: FontSizeConst.instance.extraLarge,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: context.h * 0.02),
                      Text(
                        "confirm_face_text".locale,
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
                flex: 8,
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
                        width: context.w * 0.9,
                        height: context.h * 0.07,
                        text: "start".locale,
                        colorOpacity: true,
                        onPressed: () async {
                          if (Platform.isIOS) {
                            // NavigationService.instance.pushNamed(
                            //   routeName: NavigationConst.BIOMETRIC_CAMERA,
                            // );
                            availableCameras().then((value) async {
                              NavigationService.instance.pushNamed(
                                routeName: NavigationConst
                                    .AFTER_HOME_PAGE_BIOMETRIC_CAMERA_ANDROID,
                                data: value,
                              );
                            });
                          } else {
                            //  var a = (await availableCameras())..firstWhere((camera) => camera.lensDirection == CameraLensDirection.front);
                            availableCameras().then((value) async {
                              NavigationService.instance.pushNamed(
                                routeName: NavigationConst
                                    .AFTER_HOME_PAGE_BIOMETRIC_CAMERA_ANDROID,
                                data: value,
                              );
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      viewModal: AfterHomePageBiometricFirstAd,
    );
  }
}
