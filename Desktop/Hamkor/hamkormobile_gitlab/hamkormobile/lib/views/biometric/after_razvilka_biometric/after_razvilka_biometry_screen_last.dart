import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobile/core/components/loading/loading_page.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/navigation/navigation_constant.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/models/settings_bio.dart';
import 'package:mobile/provider/7_razvilka_provider.dart';
import 'package:mobile/provider/biometric_provider.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/views/biometric/after_razvilka_biometric/after_razvilka_biometry_screen_first.dart';
import 'package:mobile/widgets/gradient_button_widget.dart';
import 'package:mobile/widgets/outlined_buttun.dart';
import 'package:provider/provider.dart';
import 'package:camera_process/camera_process.dart';
import 'package:image/image.dart' as img;

import 'after_razvilka_biometry_screen_camera_for_android.dart';

class AfterRazvilkaBiometricLast extends StatelessWidget {
  final String imagePath;
  final bool isSmile;

  const AfterRazvilkaBiometricLast({
    Key? key,
    required this.imagePath,
    required this.isSmile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BiometricProvider _myProvider =
        Provider.of<BiometricProvider>(context, listen: false);
    return SwipeInGoBack(
        onWillPop: () async {
          NavigationService.instance.pushNamed(
            routeName: NavigationConst.AFTER_RAZVILKA_ABIOMETRIC_FIRST,
          );

          return false;
        },
        child: LastView(
          imagePath: imagePath,
          isSmile: isSmile,
        ));
  }

  Future<String> convertImageToBase64() async {
    List<int> imageBytes = await File(imagePath).readAsBytesSync();
    //
    return base64Encode(imageBytes);
  }
}

class LastView extends StatefulWidget {
  String? sizeinKb;
  String? resolution;
  bool isSmile;
  final String imagePath;

  LastView({
    Key? key,
    required this.imagePath,
    this.sizeinKb = "1500",
    this.resolution = "720",
    required this.isSmile,
  }) : super(key: key);

  @override
  State<LastView> createState() => _LastViewState();
}

class _LastViewState extends State<LastView> {
  FaceDetector faceDetector =
      CameraProcess.vision.faceDetector(FaceDetectorOptions(
    enableClassification: true,
    enableTracking: true,
    // enableLandmarks: true,
    mode: FaceDetectorMode.fast,
  ));
  bool? isOK;
  Future<SettingsBio>? bioData;

  @override
  void initState() {
    super.initState();

    checkFace(widget.imagePath, widget.isSmile).then((value) {
      setState(() {});
    });
    bioData = context.biometricPr.bioSettings();
  }

  @override
  Widget build(BuildContext context) {
    return SwipeInGoBack(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => AfterRazvilkaBiometricFirst(),
            ),
            ((route) => false));
        return false;
      },
      child: isOK == null
          ? Scaffold(
              body: LoadingPage(true),
            )
          : Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: context.w * 0.08),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.zero,
                            decoration: BoxDecoration(
                                color: isOK! ? Colors.white : Color(0xffFE6666),
                                border: Border.all(
                                  color:
                                      isOK! ? Colors.white : Color(0xffFE6666),
                                  width: 10.w,
                                ),
                                borderRadius: BorderRadius.circular(
                                  12.r,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12, blurRadius: 7.r)
                                ]),
                            child: Transform.scale(
                              scaleX: -1,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.r),
                                // implement image
                                child: Image.file(
                                  File(widget.imagePath),
                                  height: 260.h,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: context.h * 0.05),
                          Row(
                            mainAxisAlignment: isOK!
                                ? MainAxisAlignment.start
                                : MainAxisAlignment.center,
                            children: [
                              Container(
                                width: context.w * 0.8,
                                child: Text(
                                  isOK!
                                      ? "is_all_okay_for_picture".locale
                                      : "take_another_picture".locale,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ColorConst.instance.kMainTextColor,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: context.h * 0.025),
                          Row(
                            children: [
                              Container(
                                width: context.w * 0.8,
                                child: Text(
                                  isOK!
                                      ? "make_sure_picture_is_okay".locale
                                      : "face_trust".locale,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color:
                                        ColorConst.instance.kSecondaryTextColor,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 54.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          GradientButton(
                            width: 343.w,
                            height: 56.h,
                            text: isOK!
                                ? "confirm_biometry".locale
                                : "try_again_biometry".locale,
                            colorOpacity: true,
                            color: isOK!
                                ? ColorConst.instance.kPrimaryColor
                                : const Color(0xffFE6666),
                            onPressed: () async {
                              if (!isOK!) {
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
                                              AfterRazvilkaBiometricCameraAndroid(
                                                isSmile: isSmile,
                                                resolution: resolution,
                                                cameras: value,
                                              )),
                                      (r) => false);
                                });
                              } else {
                                int action = Provider.of<RazvilkaProvider>(
                                        context,
                                        listen: false)
                                    .action;

                                context.loaderOverlay.show();

                                print(Provider.of<RazvilkaProvider>(context,
                                        listen: false)
                                    .isBioService);

                                String base64 = await convertImageToBase64(
                                    widget.imagePath);
                                if (Provider.of<RazvilkaProvider>(context,
                                        listen: false)
                                    .isBioService) {
                                  if (action == 1) {
                                    context.biometricPr.isNavigateHomePage =
                                        false;
                                    context.biometricPr
                                        .postBioIdentification(base64, context);
                                  }
                                } else if (action == 2) {
                                  context.biometricPr.isNavigateHomePage = true;
                                  context.biometricPr
                                      .postClientBioIdentification(
                                          base64, context);
                                } else {
                                  context.biometricPr.isNavigateHomePage =
                                      false;
                                  context.biometricPr
                                      .postBioRegistration(base64, context);
                                }
                              }
                            },
                          ),
                          SizedBox(
                            height: 17.h,
                          ),
                          if (isOK!)
                            OutlinedButtonW(
                              width: 337.w,
                              height: 52.h,
                              text: "try_again_biometry".locale,
                              onPressed: () async {
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
                                            AfterRazvilkaBiometricCameraAndroid(
                                              isSmile: isSmile,
                                              resolution: resolution,
                                              cameras: value,
                                            )),
                                    (r) => false,
                                  );
                                });
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
  }

  Future checkFace(String filePath, bool isSmile) async {
    print("Is Function Worked -------");
    bool isChecked = false;
    String sdkInt = GetStorageService.instance.box
        .read(GetStorageService.instance.sdkInt)
        .toString();

    if (Platform.isAndroid) {
      print("Is Android -------");
      if (double.parse(sdkInt) <= 24) {
        await Future.delayed(Duration(milliseconds: 400), () async {});
        isChecked = true;
      } else {
        await Future.delayed(Duration.zero, () async {
          for (var i = 0; i < 10; i++) {
            print(i);
            List<Face> faces = await faceDetector
                .processImage(InputImage.fromFilePath(filePath));
            if (faces.length == 1) {
              Face myFace = faces[0];
              double height = myFace.boundingBox.height;
              bool myisSmile = isSmile && myFace.smilingProbability! < 0.01;

              if (height > 400.h &&
                  height < 750.h &&
                  myFace.boundingBox.top > 270.h &&
                  myFace.boundingBox.bottom < height + 540.h &&
                  (myFace.headEulerAngleY ?? 0) < 8 &&
                  (myFace.headEulerAngleY ?? 0) > -8 &&
                  (myFace.leftEyeOpenProbability! > 0.7 &&
                      myFace.rightEyeOpenProbability! > 0.7 &&
                      !myisSmile)) {
                isChecked = true;
              }
              print("BREAK FACE CHECKING LOOP");
              break;
            }
          }
        });
      }
    } else {
      print("Isn't Android -------");
      await Future.delayed(Duration.zero, () async {
        for (var i = 0; i < 10; i++) {
          print(i);
          try {
            List<Face> faces = await faceDetector
                .processImage(InputImage.fromFilePath(filePath));
            if (faces.length == 1) {
              Face myFace = faces[0];
              double height = myFace.boundingBox.height;
              bool myisSmile = isSmile && myFace.smilingProbability! < 0.01;

              if (height > 350 &&
                  height < 930 &&
                  (myFace.headEulerAngleY ?? 0) < 8 &&
                  (myFace.headEulerAngleY ?? 0) > -8 &&
                  (myFace.leftEyeOpenProbability! > 0.7 &&
                      myFace.rightEyeOpenProbability! > 0.7 &&
                      !myisSmile)) {
                isChecked = true;
              }
              print("BREAK FACE CHECKING LOOP ISNT ADNROID");
              break;
            }
          } catch (e) {
            print("Error inside for while sending last screen: $e");
          }
        }
      });
    }

    isOK = isChecked;
    setState(() {
      print("SET STATE WHILE CHECKING FACE");
    });
  }

  Future<String> convertImageToBase64(String filePath) async {
    List<int> imageBytes = File(filePath).readAsBytesSync();
    //
    return base64Encode(imageBytes);
  }
}
