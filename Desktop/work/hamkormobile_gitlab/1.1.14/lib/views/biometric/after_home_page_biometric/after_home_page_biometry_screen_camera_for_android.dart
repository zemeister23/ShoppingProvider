// A screen that allows users to take a picture using a given camera.
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/core/base/view/base_view.dart';
import 'package:mobile/core/components/loading/loading_page.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/navigation/navigation_constant.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/routes/router/router.dart';

class AfterHomePageBiometricCameraAndroid extends StatefulWidget {
  final List<CameraDescription>? cameras;
  AfterHomePageBiometricCameraAndroid({this.cameras});
  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState
    extends State<AfterHomePageBiometricCameraAndroid> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.cameras!.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
      ),
      ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _initCamera(CameraDescription description) async {
    _controller = CameraController(
      description,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    try {
      await _controller.initialize();
      setState(() {});
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModal: AfterHomePageBiometricCameraAndroid,
      onPageBuilder: (BuildContext context, value) => WillPopScope(
        onWillPop: () async {
          NavigationService.instance.pushNamedRemoveUntil(
              routeName: NavigationConst.AFTER_HOME_PAGE_BIOMETRIC_FIRST);
          return false;
        },
        child: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var scale =
                  context.mq.size.aspectRatio * _controller.value.aspectRatio;
              if (scale < 1) scale = 1 / scale;
              return Scaffold(
                backgroundColor: Colors.transparent,
                body: Stack(
                  children: [
                    Transform.scale(
                      scale: scale,
                      child: Center(
                        child: CameraPreview(_controller),
                      ),
                    ),
                    Positioned(
                      child: SizedBox(
                          height: context.h,
                          width: context.w,
                          child: SvgPicture.asset(
                            "assets/images/biometric/background_blur_face.svg",
                            fit: BoxFit.cover,
                          )),
                    ),
                  ],
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 80.h,
                      width: 80.w,
                      child: FloatingActionButton(
                        backgroundColor: ColorConst.instance.kButtonColor,
                        onPressed: () async {
                          try {
                            await _initializeControllerFuture;

                            XFile image = await _controller.takePicture();

                            await NavigationService.instance.pushNamed(
                              routeName: NavigationConst
                                  .AFTER_HOME_PAGE_BIOMETRIC_LAST,
                              data: image.path,
                            );
                          } catch (e) {}
                        },
                        child: Icon(
                          Icons.circle,
                          size: 70.r,
                          color: ColorConst.instance.kButtonColor,
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              offset: Offset(0, 0),
                              blurRadius: 10,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    SizedBox(
                      height: 50.h,
                      width: 50.w,
                      child: FloatingActionButton(
                        backgroundColor: ColorConst.instance.kMainTextColor,
                        child: Icon(
                          Icons.sync,
                          color: ColorConst.instance.kBackgroundColor,
                        ),
                        onPressed: () async {
                          final lensDirection =
                              _controller.description.lensDirection;
                          CameraDescription newDescription;
                          if (lensDirection == CameraLensDirection.front) {
                            newDescription = widget.cameras!.firstWhere(
                                (description) =>
                                    description.lensDirection ==
                                    CameraLensDirection.back);
                          } else {
                            newDescription = widget.cameras!.firstWhere(
                                (description) =>
                                    description.lensDirection ==
                                    CameraLensDirection.front);
                          }

                          if (newDescription != null) {
                            _initCamera(newDescription);
                          } else {}
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else if (!snapshot.hasData) {
              return Scaffold(
                body: LoadingPage(true),
              );
            } else {
              return Scaffold(
                body: LoadingPage(true),
              );
            }
          },
        ),
      ),
    );
  }
}
