import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobile/core/base/view/base_view.dart';
import 'package:mobile/core/components/loading/loading_page.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/navigation/navigation_constant.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/provider/7_razvilka_provider.dart';
import 'package:mobile/provider/biometric_provider.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/views/10_home/container_decoration.dart';
import 'package:mobile/widgets/appbar/default_appbar.dart';
import 'package:mobile/widgets/gradient_button_widget.dart';
import 'package:mobile/widgets/outlined_buttun.dart';
import 'package:provider/provider.dart';

class AfterHomePageBiometricLast extends StatelessWidget {
  final String imagePath;

  const AfterHomePageBiometricLast({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BiometricProvider _myProvider =
        Provider.of<BiometricProvider>(context, listen: false);
    return BaseView(
        viewModal: AfterHomePageBiometricLast,
        onPageBuilder: (BuildContext context, value) {
          return WillPopScope(
            onWillPop: () async {
              NavigationService.instance.pushNamedRemoveUntil(
                routeName: NavigationConst.AFTER_HOME_PAGE_BIOMETRIC_FIRST,
              );
              return false;
            },
            child: Scaffold(
              body: _myProvider.isLoading
                  ? LoadingPage(true)
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: context.w * 0.08),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: context.w * 0.5,
                                  height: context.w * 0.62,
                                  padding: EdgeInsets.all(context.h * 0.012),
                                  decoration:
                                      ContainerDecorationComp.containerShadow2(
                                    context,
                                  ),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(context.h * 0.01),
                                    // TODO: Changeing Image
                                    child: Transform.scale(
                                      scaleX: -1,
                                      child: Image.file(
                                        File(imagePath),
                                        fit: BoxFit.cover,
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: context.h * 0.05),
                                Text(
                                  "is_all_okay_for_picture".locale,
                                  style: TextStyle(
                                    color: ColorConst.instance.kMainTextColor,
                                    fontSize: FontSizeConst.instance.large,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: context.h * 0.025),
                                Text(
                                  "make_sure_picture_is_okay".locale,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color:
                                        ColorConst.instance.kSecondaryTextColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: context.h * 0.22,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: context.h * 0.03),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                GradientButton(
                                  width: 340.w,
                                  height: context.h * 0.08,
                                  text: "confirm_biometry".locale,
                                  colorOpacity: true,
                                  onPressed: () async {
                                    int action = Provider.of<RazvilkaProvider>(
                                            context,
                                            listen: false)
                                        .action;
                                    context.loaderOverlay.show();
                                    String base64 =
                                        await convertImageToBase64();
                                    if (Provider.of<RazvilkaProvider>(context,
                                            listen: false)
                                        .isBioService) {
                                      if (action == 1) {
                                        context.biometricPr.isNavigateHomePage =
                                            false;
                                        _myProvider.postBioIdentification(
                                            base64, context);
                                      }
                                    } else if (action == 2) {
                                      context.biometricPr.isNavigateHomePage =
                                          true;
                                      _myProvider.postClientBioIdentification(
                                          base64, context);
                                    } else {
                                      context.biometricPr.isNavigateHomePage =
                                          false;
                                      _myProvider.postBioRegistration(
                                          base64, context);
                                    }
                                  },
                                ),
                                OutlinedButtonW(
                                  width: 335.w,
                                  height: context.h * 0.08,
                                  text: "try_again_biometry".locale,
                                  onPressed: () {
                                    if (Platform.isIOS) {
                                      NavigationService.instance
                                          .pushNamedRemoveUntil(
                                        routeName: NavigationConst
                                            .AFTER_HOME_PAGE_BIOMETRIC_CAMERA,
                                      );
                                      availableCameras().then((value) async {
                                        NavigationService.instance.pushNamed(
                                          routeName: NavigationConst
                                              .AFTER_HOME_PAGE_BIOMETRIC_CAMERA_ANDROID,
                                          data: value,
                                        );
                                      });
                                    } else {
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
                        ),
                      ],
                    ),
            ),
          );
        });
  }

  Future<String> convertImageToBase64() async {
    List<int> imageBytes = await File(imagePath).readAsBytesSync();
    return base64Encode(imageBytes);
  }
}
