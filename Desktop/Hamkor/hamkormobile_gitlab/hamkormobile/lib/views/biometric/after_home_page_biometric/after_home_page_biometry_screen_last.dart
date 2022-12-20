import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
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
import 'package:mobile/models/settings_bio.dart';
import 'package:mobile/provider/7_razvilka_provider.dart';
import 'package:mobile/provider/biometric_provider.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/views/10_home/container_decoration.dart';
import 'package:mobile/views/biometric/after_home_page_biometric/after_home_page_biometry_screen_camera_for_android.dart';
import 'package:mobile/widgets/appbar/default_appbar.dart';
import 'package:mobile/widgets/gradient_button_widget.dart';
import 'package:mobile/widgets/outlined_buttun.dart';
import 'package:provider/provider.dart';
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
import 'package:mobile/provider/7_razvilka_provider.dart';
import 'package:mobile/provider/biometric_provider.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/views/biometric/after_razvilka_biometric/after_razvilka_biometry_screen_first.dart';
import 'package:mobile/widgets/gradient_button_widget.dart';
import 'package:mobile/widgets/outlined_buttun.dart';
import 'package:provider/provider.dart';
import 'package:camera_process/camera_process.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class AfterHomePageBiometricLast extends StatelessWidget {
  final String imagePath;
  final String resolution;
  final bool isSmile;

  const AfterHomePageBiometricLast(
      {Key? key,
      required this.imagePath,
      required this.isSmile,
      required this.resolution})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BiometricProvider _myProvider =
        Provider.of<BiometricProvider>(context, listen: false);
    return SwipeInGoBack(
        onWillPop: () async {
          NavigationService.instance.pushNamed(
            routeName: NavigationConst.AFTER_HOME_PAGE_BIOMETRIC_FIRST_AD,
          );

          return false;
        },
        child: LastView(
          imagePath: imagePath,
          isSmile: isSmile,
          resolution: resolution,
        ));
  }

  Future<String> convertImageToBase64() async {
    List<int> imageBytes = File(imagePath).readAsBytesSync();

    return base64Encode(imageBytes);
  }
}

class LastView extends StatefulWidget {
  String? sizeinKb;
  String? resolution;
  final bool isSmile;
  final String imagePath;

  LastView({
    Key? key,
    required this.imagePath,
    this.sizeinKb = "1500",
    required this.resolution,
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
    // minFaceSize: 1,
  ));
  bool? isOK;

  Future<SettingsBio?>? bioData;

  @override
  void initState() {
    super.initState();
    checkFace(widget.imagePath, widget.isSmile);
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
                                  height: 260.w,
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
                                              AfterHomePageBiometricCameraAndroid(
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
                                              AfterHomePageBiometricCameraAndroid(
                                                isSmile: isSmile,
                                                resolution: resolution,
                                                cameras: value,
                                              )),
                                      (r) => false);
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
    bool isChecked = false;
    String sdkInt = GetStorageService.instance.box
        .read(GetStorageService.instance.sdkInt)
        .toString();

    if (Platform.isAndroid) {
      if (double.parse(sdkInt) <= 24) {
        await Future.delayed(Duration(milliseconds: 400), () async {});
        isChecked = true;
      } else {
        await Future.delayed(Duration.zero, () async {
          for (var i = 0; i < 10; i++) {
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

              break;
            }
          }
        });
      }
    } else {
      await Future.delayed(Duration.zero, () async {
        for (var i = 0; i < 10; i++) {
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

            break;
          }
        }
      });
    }

    isOK = isChecked;
    setState(() {});
  }

  // Future<String> resizeImage(String sizeinKb, String filePath, String resolution) async {
  //   img.Image? image = img.decodeImage(File(filePath).readAsBytesSync());
  //   Size imageSize = fullResolutions(resolution);
  //   img.Image resizedImage = img.copyResize(image!,
  //       width: imageSize.width.toInt(), height: imageSize.height.toInt());

  // Directory appDocDir = await getApplicationDocumentsDirectory();
  //   String appDocPath = appDocDir.path;
  //   File myImage = await File(appDocPath + '/out/image-resized.jpg').create(recursive: true)
  //     ..writeAsBytesSync(img.encodeJpg(resizedImage, quality: 100));

  //   // resizedImage.data.buffer.asByteData().;
  //   getFileSize(myImage.path);

  //   return myImage.path;
  // }

  // Future<int> getFileSize(String filePath) async {
  //   int bytes = await File(filePath).length();
  //
  //   return (bytes ~/ 1024);
  // }

  Future<String> convertImageToBase64(String filePath) async {
    List<int> imageBytes = File(filePath).readAsBytesSync();
    //
    return base64Encode(imageBytes);
  }

  // Size fullResolutions(String resolution) {
  //   switch (resolution) {
  //     case "480":
  //       return Platform.isIOS ? Size(640, 480) : Size(720, 480);

  //     case "720":
  //       return Size(1280, 720);
  //     case "1080":
  //       return Size(1920, 1080);
  //     default:
  //       return Platform.isIOS ? Size(640, 480) : Size(720, 480);
  //   }
  // }
}

//  Scaffold(
//         body: _myProvider.isLoading
//             ? LoadingPage(true)
//             : Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   Expanded(
//                     child: Padding(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: context.w * 0.08),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           Container(
//                             width: context.w * 0.5,
//                             height: context.w * 0.62,
//                             padding: EdgeInsets.all(context.h * 0.012),
//                             decoration:
//                                 ContainerDecorationComp.containerShadow2(
//                                     context),
//                             child: ClipRRect(
//                               borderRadius:
//                                   BorderRadius.circular(context.h * 0.01),

//                               child: Transform.scale(
//                                 scaleX: -1,
//                                 child: Image.file(
//                                   File(imagePath),
//                                   fit: BoxFit.cover,
//                                   alignment: Alignment.center,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: context.h * 0.05),
//                           Text(
//                             "is_all_okay_for_picture".locale,
//                             style: TextStyle(
//                               color: ColorConst.instance.kMainTextColor,
//                               fontSize: FontSizeConst.instance.large,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(height: context.h * 0.025),
//                           Text(
//                             "make_sure_picture_is_okay".locale,
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: ColorConst.instance.kSecondaryTextColor,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: context.h * 0.22,
//                     child: Padding(
//                       padding: EdgeInsets.only(bottom: context.h * 0.03),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: <Widget>[
//                           GradientButton(
//                             width: 340.w,
//                             height: context.h * 0.08,
//                             text: "confirm_biometry".locale,
//                             colorOpacity: true,
//                             onPressed: () async {
//                               int action = Provider.of<RazvilkaProvider>(context,listen: false).action;

//                               context.loaderOverlay.show();
//                               String base64 = await convertImageToBase64();
//                               if (Provider.of<RazvilkaProvider>(context,
//                                       listen: false)
//                                   .isBioService) {
//
//                                 if (action == 1) {
//                                   context.biometricPr.isNavigateHomePage =
//                                       false;
//                                   _myProvider.postBioIdentification(
//                                       base64, context);
//                                 }
//                               } else if (action == 2) {
//                                 context.biometricPr.isNavigateHomePage = true;
//                                 _myProvider.postClientBioIdentification(
//                                     base64, context);
//                               } else {
//                                 context.biometricPr.isNavigateHomePage = false;
//                                 _myProvider.postBioRegistration(
//                                     base64, context);
//                               }
//                             },
//                           ),
//                           OutlinedButtonW(
//                             width: 335.w,
//                             height: context.h * 0.08,
//                             text: "try_again_biometry".locale,
//                             onPressed: () {
//                               if (Platform.isIOS) {
//                                 NavigationService.instance.pushNamedRemoveUntil(
//                                   routeName: NavigationConst
//                                       .AFTER_RAZVILKA_BIOMETRIC_CAMERA,
//                                 );
//                                 availableCameras().then((value) async {
//                                   NavigationService.instance.pushNamed(
//                                     routeName: NavigationConst
//                                         .AFTER_RAZVILKA_BIOMETRIC_CAMERA_ANDROID,
//                                     data: value,
//                                   );
//                                 });
//                               } else {
//                                 availableCameras().then((value) async {
//                                   NavigationService.instance.pushNamed(
//                                     routeName: NavigationConst
//                                         .AFTER_RAZVILKA_BIOMETRIC_CAMERA_ANDROID,
//                                     data: value,
//                                   );
//                                 });
//                               }
//                             },
//                           ),

//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//       ),

//  GradientButton(
//                         width: 340.w,
//                         height: context.h * 0.08,
//                         text: "confirm_biometry".locale,
//                         colorOpacity: true,
//                         onPressed: () async {
//                           int action = Provider.of<RazvilkaProvider>(context,listen: false).action;

//                           context.loaderOverlay.show();

//                           String base64 = await convertImageToBase64();
//                           if (Provider.of<RazvilkaProvider>(context,
//                                   listen: false)
//                               .isBioService) {
//
//                             if (action == 1) {
//                               context.biometricPr.isNavigateHomePage =
//                                   false;
//                               context.biometricPr.postBioIdentification(
//                                   base64, context);
//                             }
//                           } else if (action == 2) {
//                             context.biometricPr.isNavigateHomePage = true;
//                             context.biometricPr.postClientBioIdentification(
//                                 base64, context);
//                           } else {
//                             context.biometricPr.isNavigateHomePage = false;
//                             context.biometricPr.postBioRegistration(
//                                 base64, context);
//                           }
//                         },
//                       ),
//                       OutlinedButtonW(
//                         width: 335.w,
//                         height: context.h * 0.08,
//                         text: "try_again_biometry".locale,
//                         onPressed: () {
//                           if (Platform.isIOS) {
//                             NavigationService.instance.pushNamedRemoveUntil(
//                               routeName: NavigationConst
//                                   .AFTER_RAZVILKA_BIOMETRIC_CAMERA,
//                             );
//                             availableCameras().then((value) async {
//                               NavigationService.instance.pushNamed(
//                                 routeName: NavigationConst
//                                     .AFTER_RAZVILKA_BIOMETRIC_CAMERA_ANDROID,
//                                 data: value,
//                               );
//                             });
//                           } else {
//                             availableCameras().then((value) async {
//                               NavigationService.instance.pushNamed(
//                                 routeName: NavigationConst
//                                     .AFTER_RAZVILKA_BIOMETRIC_CAMERA_ANDROID,
//                                 data: value,
//                               );
//                             });
//                           }
//                         },
//                       ),
