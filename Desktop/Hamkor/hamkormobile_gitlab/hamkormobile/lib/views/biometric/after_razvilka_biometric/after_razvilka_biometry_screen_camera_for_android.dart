// A screen that allows users to take a picture using a given camera.
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/core/constants/navigation/navigation_constant.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/routes/router/router.dart';
import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera_process/camera_process.dart';
import 'package:mobile/views/biometric/after_home_page_biometric/after_home_page_biometry_screen_first.dart';
import 'package:mobile/views/biometric/after_razvilka_biometric/after_razvilka_biometry_screen_last.dart';

// Format File Size
// static String getFileSizeString({required int bytes, int decimals = 0}) {
//   if (bytes <= 0) return "0 Bytes";
//   const suffixes = [" Bytes", "KB", "MB", "GB", "TB"];
//   var i = (log(bytes) / log(1024)).floor();
//   return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
// }

double extraYValue = 0;
double extraZValue = 0;
bool isShowed = true;
bool isTakePictureButton = false;

class AfterRazvilkaBiometricCameraAndroid extends StatefulWidget {
  String? resolution;
  String? sizeinKb;
  bool? isSmile;
  List<CameraDescription> cameras;
  AfterRazvilkaBiometricCameraAndroid(
      {required this.resolution,
      this.sizeinKb = "1500",
      required this.isSmile,
      required this.cameras});
  @override
  _FaceCheckerViewState createState() => _FaceCheckerViewState();
}

class _FaceCheckerViewState extends State<AfterRazvilkaBiometricCameraAndroid> {
  FaceDetector faceDetector = CameraProcess.vision.faceDetector(
    const FaceDetectorOptions(
      enableContours: true,
      enableClassification: true,
      enableTracking: true,
      enableLandmarks: false,
      mode: FaceDetectorMode.fast,
    ),
  );
  bool isBusy = false;
  CustomPaint? customPaint;
  int countOfSuccess = 0;
  Timer? _timer;
  checkPermission() async {
    PermissionStatus status1 = await Permission.storage.status;

    if (PermissionStatus.granted == status1) {
    } else {
      if (PermissionStatus.granted != status1) {
        await Permission.storage.request();
        if (await Permission.storage.isGranted) {
        } else {
          NavigationService.instance.pushNamedRemoveUntil(
              routeName: NavigationConst.AFTER_RAZVILKA_ABIOMETRIC_FIRST,
              data: true);
        }
      }
    }
  }

  @override
  void initState() {
    checkPermission();
    isTakePictureButton = false;
    isShowed = true;
    _timer = Timer(const Duration(seconds: 10), () {
      if (Platform.isAndroid) {
        if (isShowed) {
          String sdkInt = GetStorageService.instance.box
              .read(GetStorageService.instance.sdkInt)
              .toString();
          if (double.parse(sdkInt) <= 26) {
            isTakePictureButton = true;
            setState(() {});
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                dismissDirection: DismissDirection.horizontal,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height - 100.h,
                    right: 20.w,
                    left: 20.w),
                content: Text(
                  'no_foto'.locale,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            );
          }
        }
      }
    });

    dl = 0.0;
    dr = 0.0;
    dt = 0.0;
    db = 0;
    height = 0.0;
    width = 0.0;
    paintColor = Colors.white;
    isIos = Platform.isIOS;
    myfaces = [];
    scale = 1;
    countOfSuccess = 0;
    super.initState();
  }

  @override
  void dispose() {
    isTakePictureButton = false;
    isShowed = false;
    _timer!.cancel();
    dl = 0.0;
    dr = 0.0;
    dt = 0.0;
    db = 0;
    height = 0.0;
    width = 0.0;
    paintColor = Colors.red;
    isIos = Platform.isIOS;
    myfaces = [];
    scale = 1;
    faceDetector.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SwipeInGoBack(
      onWillPop: () async {
        NavigationService.instance.pushNamedRemoveUntil(
            routeName: NavigationConst.AFTER_RAZVILKA_ABIOMETRIC_FIRST,
            data: true);
        return false;
      },
      child: Scaffold(
        body: CameraView(
          cameras: widget.cameras,
          resolution: widget.resolution,
          isSmile: widget.isSmile,
          title: 'Face Detector',
          customPaint: customPaint,
          onImage: (inputImage) {
            processImage(inputImage);
          },
          initialDirection: CameraLensDirection.front,
        ),
      ),
    );
  }

  Future<void> processImage(InputImage inputImage) async {
    if (isBusy) return;
    isBusy = true;

    final faces = await faceDetector.processImage(inputImage);

    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      FaceDetectorPainter painter = FaceDetectorPainter(
        faces,
        inputImage.inputImageData!.size,
        inputImage.inputImageData!.imageRotation,
        context,
        isSmile: widget.isSmile!,
      );
      customPaint = CustomPaint(painter: painter);
    } else {
      customPaint = null;
    }

    isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}

class CameraView extends StatefulWidget {
  CameraView({
    Key? key,
    required this.title,
    required this.customPaint,
    required this.onImage,
    this.initialDirection = CameraLensDirection.back,
    required this.resolution,
    required this.isSmile,
    required this.cameras,
  }) : super(key: key);
  String? resolution;
  bool? isSmile;
  List<CameraDescription> cameras;
  XFile? image;
  final String title;
  final CustomPaint? customPaint;
  final Function(InputImage inputImage) onImage;
  final CameraLensDirection initialDirection;

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  CameraController? _controller;
  File? _image;
  ImagePicker? _imagePicker;
  int _cameraIndex = 0;
  int _countOfSuccess = 0;

  //  CameraController _takecontroller=CameraController(description, ResolutionPreset.low) ;
  Timer? _timerSuccess;

  //  CameraController _takecontroller=CameraController(description, ResolutionPreset.low) ;
  @override
  void initState() {
    Future.microtask(() {
      _startLiveFeed();
    });
    _timerSuccess = Timer.periodic(Duration(milliseconds: 100), (v) {
      double w = 1.sw;
      double h = 1.sh;

      bool myisSmile = true;

      if (widget.isSmile! && myfaces.isNotEmpty) {
        if (myfaces[0].smilingProbability! < 0.01) {
          myisSmile = false;
        }
      }
      if (myfaces.isNotEmpty) {
        // print(">>>>>myfaces[0].smilingProbability! " +
        //     myfaces[0].smilingProbability!.toString());
      }

      //

      if (height > 400.h &&
          height < 750.h &&
          dt > 270.h &&
          db < height + 540.h &&
          openEyes &&
          !(extraYValue > 8 || extraYValue < -8) &&
          !(extraZValue > 8 || extraZValue < -8) &&
          myisSmile) {
        paintColor = Colors.green;
        _countOfSuccess += 1;

        if (_countOfSuccess == 29) {
          try {
            _controller?.initialize().then((value) async {
              Future.delayed(Duration(milliseconds: 700), () {
                _controller?.takePicture().then((takeimage) async {
                  widget.image = takeimage;
                  paintColor = Colors.white;
                  setState(() {});
                  Future.delayed(
                      const Duration(
                        milliseconds: 700,
                      ), () {
                    _controller!.stopImageStream().then((_) {
                      _controller!.dispose();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AfterRazvilkaBiometricLast(
                            imagePath: takeimage.path,
                            isSmile: widget.isSmile!,
                            // resolution: widget.resolution!,
                          ),
                        ),
                        (r) => false,
                      );
                    });
                  });
                  isShowed = false;
                  dt = 0;
                  db = 0;
                  dl = 0;
                  dr = 0;
                  width = 0;
                  height = 0;
                });
              });
            });
          } catch (e) {
            widget.image = null;
          }
        }
      } else {
        widget.image = null;
        dt = 0;
        db = 0;
        dl = 0;
        dr = 0;
        width = 0;
        height = 0;
        paintColor = Colors.red;
        _countOfSuccess = 0;

        //
        //
      }
      //
    });

    super.initState();
    extraYValue = 0;
    extraZValue = 0;
    _imagePicker = ImagePicker();

    for (var i = 0; i < cameras.length; i++) {
      if (cameras[i].lensDirection == widget.initialDirection) {
        _cameraIndex = i;
      }
    }
  }

  @override
  void dispose() {
    _stopLiveFeed();
    _timerSuccess!.cancel();
    _countOfSuccess = 0;

    _controller!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _liveFeedBody(),
    );
  }

  Widget _liveFeedBody() {
    if (_controller?.value.isInitialized == false || _controller == null) {
      return Container();
    }

    scale = 1.sh / 1.sw / _controller!.value.aspectRatio;
    if (scale < 1) scale = 1 / scale;
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned(
            left: 0,
            right: 0,
            // left: -0.5 * (scale - 1) * 1.sw,
            // right: -0.5 * (scale - 1) * 1.sw,
            top: 0,
            bottom: 0,
            child: Transform.scale(
              scale: scale,
              child: Center(
                child: CameraPreview(_controller!),
              ),
            ),
          ),
          if (widget.image == null)
            Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              left: 0,
              child: Opacity(
                opacity: 0.3,
                child: Container(
                  height: 1.sh,
                  width: 1.sw,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.15),
                      image: const DecorationImage(
                        image: ExactAssetImage(
                          "assets/images/blur.png",
                        ),
                        fit: BoxFit.fill,
                      )),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 0.8, sigmaY: 0.8),
                    child: Container(),
                  ),
                ),
              ),
            ),

          //  Opacity(
          //   opacity: 1,
          //    child: Transform.scale(
          //       scale: scale,
          //       child: Center(
          //         child: CameraPreview(_controller!),
          //       ),
          //     ),
          //  ),
          // Positioned(top: 100, left: 100, child: Text("okeeeeeeeeee")),
          if (widget.image == null)
            Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                width: 1.sw,
                height: 1.sh,
                padding: EdgeInsets.only(
                  left: 41.5.w,
                  right: 41.5.w,
                  top: 162.5.h,
                  bottom: 132.5.h,
                ),
                // height: MediaQuery.of(context).size.height,
                // width: MediaQuery.of(context).size.width,
                child: SvgPicture.asset(
                  "assets/images/face.svg",
                  color: paintColor == Colors.red
                      ? const Color(0xffFE6666)
                      : Colors.white,
                  height: 507.h,
                  width: 287.w,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          Positioned(
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (widget.customPaint != null) widget.customPaint!,
              ],
            ),
          ),
          Positioned(
            top: 54.h,
            right: 0,
            left: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Text(
                    widget.isSmile!
                        ? "is_smile_true".locale
                        : "camera_move".locale,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // if (paintColor == Colors.green)
          //   Positioned(
          //     top: MediaQuery.of(context).size.height * 0.1,
          //     right: 0,
          //     left: 0,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         SizedBox(
          //           width: MediaQuery.of(context).size.width * 0.8,
          //           child: Text(
          //             "Смотрите в камеру и не\n двигайтесь",
          //             textAlign: TextAlign.center,
          //             style: TextStyle(
          //               color: Colors.white,
          //               fontSize: 18.sp,
          //               fontWeight: FontWeight.w400,
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),

          if (paintColor == Colors.red)
            Positioned(
              top: MediaQuery.of(context).size.height * 0.13,
              right: 0,
              left: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      openEyes ? "" : "open_eye".locale,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xffFE6666),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          if (paintColor == Colors.green && (39 - _countOfSuccess) ~/ 10 != 0)
            Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              left: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    ((39 - _countOfSuccess) ~/ 10).toString(),
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 150.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
          if (isTakePictureButton)
            Positioned(
              bottom: 49.h,
              right: 0,
              left: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      if (widget.image == null) {
                        _controller?.initialize().then((value) async {
                          Future.delayed(const Duration(milliseconds: 800), () {
                            _controller?.takePicture().then((takeimage) async {
                              widget.image = takeimage;
                              paintColor = Colors.white;
                              setState(() {});
                              Future.delayed(
                                  const Duration(
                                    milliseconds: 700,
                                  ), () {
                                _controller!.stopImageStream().then((_) {
                                  _controller!.dispose();
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          AfterRazvilkaBiometricLast(
                                        imagePath: takeimage.path,
                                        isSmile: widget.isSmile!,
                                      ),
                                    ),
                                    (r) => false,
                                  );
                                });
                              });
                              isShowed = false;
                              dt = 0;
                              db = 0;
                              dl = 0;
                              dr = 0;
                              width = 0;
                              height = 0;
                            });
                          });
                        });
                      }
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Container(
                      width: 70.h,
                      height: 70.h,
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 5.h,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(
                            35.h,
                          )),
                      alignment: Alignment.center,
                      child: Container(
                        width: 46.h,
                        height: 46.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            23.h,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Future _startLiveFeed() async {
    ResolutionPreset res = ResolutionPreset.high;
    switch (widget.resolution) {
      case "480":
        res = ResolutionPreset.medium;
        break;
      case "720":
        res = ResolutionPreset.high;
        break;
      case "1080":
        res = ResolutionPreset.veryHigh;
        break;
      default:
        res = ResolutionPreset.high;
    }

    // final camera = cameras[_cameraIndex];
    _controller = CameraController(
      widget.cameras.firstWhere(
        (cameraa) => cameraa.lensDirection == CameraLensDirection.front,
      ),
      res,
      enableAudio: false,
      imageFormatGroup: Platform.isIOS ? ImageFormatGroup.bgra8888 : null,
    );
    _controller?.initialize().then((_) async {
      await _controller!.lockCaptureOrientation(DeviceOrientation.portraitUp);
      if (!mounted) {
        return;
      }

      _controller?.startImageStream(_processCameraImage);
      setState(() {});
    });
    setState(() {});
  }

  Future _stopLiveFeed() async {
    if (mounted &&
        _controller!.value.isStreamingImages &&
        _controller != null) {
      _controller?.stopImageStream();
    }
    _controller?.dispose();
    _controller = null;
  }

  Future _switchLiveCamera() async {
    if (_cameraIndex == 0) {
      _cameraIndex = 1;
    } else {
      _cameraIndex = 0;
    }
    await _stopLiveFeed();
    await _startLiveFeed();
  }

  Future _processPickedFile(PickedFile pickedFile) async {
    setState(() {
      _image = File(pickedFile.path);
    });
    final inputImage = InputImage.fromFilePath(pickedFile.path);
    widget.onImage(inputImage);
  }

  Future _processCameraImage(CameraImage image) async {
    // double w = MediaQuery.of(context).size.width;
    // double h = MediaQuery.of(context).size.height;
    //
    //
    //
    //
    //
    //
    //
    //
    // bool myisSmile = true;
    // for (Face i in myfaces)
    //
    // if (widget.isSmile! && myfaces.isNotEmpty) {
    //   if (myfaces[0].smilingProbability! < 0.01) {
    //     myisSmile = false;
    //   }
    // }
    //

    // if (myfaces.isNotEmpty) {
    //
    // }
    //
    //
    // print(height > 350 &&
    //     height < 930 &&
    //     // (height / scale >= 1.sh * 0.48 && height / scale <= 1.sh * 0.69) &&
    //     openEyes &&
    //     !(extraYValue > 8 || extraYValue < -8) &&
    //     !(extraZValue > 8 || extraZValue < -8) &&
    //     myisSmile);

    // if (height > 350 &&
    //         height < 930 &&
    //         // (height / scale >= 1.sh * 0.48 && height / scale <= 1.sh * 0.69) &&
    //         openEyes &&
    //         !(extraYValue > 8 || extraYValue < -8) &&
    //         !(extraZValue > 8 || extraZValue < -8)
    //          &&
    //         myisSmile
    // (1.sh * 0.2 < dt / scale && (1.sh * 0.9) > db / scale)

    // (w * 0.05 < dl / scale) && w * 0.95 > dr / scale
    // &&

    // ) {
    // paintColor = Colors.green;
    // _countOfSuccess += 1;

    // if (_countOfSuccess == 51) {
    //   try {
    //     _controller?.initialize().then((value) async {
    //       Future.delayed(Duration(milliseconds: 500), () {
    //         _controller?.takePicture().then((image) async {
    //           widget.image = image;
    //           paintColor = Colors.white;
    //           setState(() {});
    //           Future.delayed(
    //               const Duration(
    //                 milliseconds: 400,
    //               ), () {
    //             Navigator.pushAndRemoveUntil(
    //               context,
    //               MaterialPageRoute(
    //       builder: (_) => AfterRazvilkaBiometricLast(
    //         imagePath: widget.image!.path,
    //         isSmile: widget.isSmile!,
    //       ),
    //     ),
    //     (r) => false,
    //   );
    // });
    // isShowed = false;
    // dt = 0;
    // db = 0;
    // dl = 0;
    // dr = 0;
    // width = 0;
    // height = 0;
    //           });
    //         });
    //       });
    //     } catch (e) {
    //       //
    //       widget.image = null;
    //     }
    //   }
    // } else {
    //   widget.image = null;
    //   dt = 0;
    //   db = 0;
    //   dl = 0;
    //   dr = 0;
    //   width = 0;
    //   height = 0;
    //   if (myfaces.isEmpty) {
    //     paintColor = Colors.white;
    //   } else {
    //     paintColor = Colors.red;
    //   }
    //   _countOfSuccess = 0;
    //   //
    //   //
    // }
    //
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();
    final Size imageSize =
        Size(image.width.toDouble(), image.height.toDouble());

    final camera = cameras[_cameraIndex];
    final imageRotation =
        InputImageRotationMethods.fromRawValue(camera.sensorOrientation) ??
            InputImageRotation.Rotation_0deg;

    final inputImageFormat =
        InputImageFormatMethods.fromRawValue(image.format.raw) ??
            InputImageFormat.NV21;

    final planeData = image.planes.map(
      (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    final inputImage =
        InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

    widget.onImage(inputImage);
  }
}

class FaceDetectorPainter extends CustomPainter {
  FaceDetectorPainter(
    this.faces,
    this.absoluteImageSize,
    this.rotation,
    this.context, {
    required this.isSmile,
  });

  final List<Face> faces;
  final Size absoluteImageSize;
  final InputImageRotation rotation;
  final BuildContext context;
  final bool isSmile;

  @override
  void paint(Canvas canvas, Size size) {
    myfaces = faces;
    //
    //
    if (myfaces.isEmpty) {
      paintColor = Colors.red;
      dt = 0;
      db = 0;
      dl = 0;
      dr = 0;
      height = 0;
      width = 0;
    } else {
      extraYValue = myfaces[0].headEulerAngleY ?? 0;
      extraZValue = myfaces[0].headEulerAngleZ ?? 0;
      dt = myfaces[0].boundingBox.top;
      db = myfaces[0].boundingBox.bottom;
      dl = myfaces[0].boundingBox.left;
      dr = myfaces[0].boundingBox.right;
      height = myfaces[0].boundingBox.height;
      width = myfaces[0].boundingBox.width;

      if ((myfaces[0].headEulerAngleY! > 8 ||
              myfaces[0].headEulerAngleY! < -8) &&
          (myfaces[0].headEulerAngleZ! > 8 ||
              myfaces[0].headEulerAngleZ! < -8)) {
        paintColor = Colors.red;
        openEyes = true;
      }
      //

      if (isSmile) {
        if (myfaces[0].smilingProbability! < 0.01) {
          paintColor = Colors.red;
        }
      }
      if ((myfaces[0].leftEyeOpenProbability! < 0.7 ||
          myfaces[0].rightEyeOpenProbability! < 0.7)) {
        paintColor = Colors.red;
        openEyes = false;
      } else {
        openEyes = true;
      }
    }
  }

  @override
  bool shouldRepaint(FaceDetectorPainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.faces != faces;
  }
}
