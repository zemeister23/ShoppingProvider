import 'dart:async';
import 'dart:math';
import 'package:app_settings/app_settings.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile/core/components/loading/loading_page.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/images/image_const.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/models/bancomates_model.dart';
import 'package:mobile/models/bancomates_model.dart' as bancomate;
import 'package:mobile/models/branches_model.dart' as branche;
import 'package:mobile/models/branches_model.dart';
import 'package:mobile/models/regions_model.dart';
import 'package:mobile/provider/map_provider.dart';
import 'package:mobile/views/map/bankomats_screen.dart';
import 'package:mobile/views/map/fillials_screen.dart';
import 'package:mobile/widgets/listTile/map_bottom_list_tile.dart';
import 'package:provider/provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import '../../core/init/cache/get_storege.dart';
import '../../provider/lock_timer_provider.dart';

enum getcoordinata { initial, loading, error, success }

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

enum BottomSheetStates { intial, top, center, bottom }

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  // AnimationController? _animationController;
  AnimationController? _animationController1;
  AnimationController? newbottomsheetAnimation;
  AnimationController? newbottomsheetAnimatio322;
  Future<BancomatesModel>? getBancomates;
  Future<RegionsModel>? getRegions;
  Future<branche.BranchesModel>? getBranches;
  int placeMarkerIndex = -1;
  Completer<YandexMapController> _completer = Completer();
  late YandexMapController yController;
  List<MapObject> _mapObjects = [];
  getcoordinata state = getcoordinata.initial;
  Map fulldata = {};
  Timer? _timer;
  BottomSheetStates _bottomSheetState = BottomSheetStates.intial;
  double yCOORDINATE = 0.0;
  Position _currPosition = Position(
      longitude: 69.3711365,
      latitude: 41.04968150039766,
      timestamp: DateTime.now(),
      accuracy: 1,
      altitude: 1,
      heading: 1,
      speed: 1,
      speedAccuracy: 1);
  Timer? _animationTimer;
  bool isForward = true;

  @override
  void initState() {
context.mapPr.isMapScreenForBaseView = true;
    super.initState();
    context.mapPr.language = GetStorageService.instance.box
            .read(GetStorageService.instance.language) ??
        "ru";

    context.mapPr.changeNewBottomSheetData(null);
    context.mapPr.changeRegionIndex(-1);
    newbottomsheetAnimation = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: 1.sh - 322.h,
      duration: Duration(
        milliseconds: (1.sh - 322.h) ~/ 2.h,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {})
      // ignore: invalid_use_of_protected_member
      ..notifyListeners();

    newbottomsheetAnimatio322 = AnimationController(
        vsync: this,
        upperBound: 322.h,
        lowerBound: 0,
        duration: Duration(
          milliseconds: 131,
        ))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        setState(() {});
      })
      ..notifyListeners();
    ;

    _animationTimer = Timer.periodic(Duration(microseconds: 500), (V) {
      if (isForward) {
        if (yCOORDINATE.toInt() < _animationController1!.value.toInt()) {
          _animationController1!.stop();
        }
      } else {
        if (yCOORDINATE.toInt() > _animationController1!.value.toInt()) {
          _animationController1!.stop();
        }
      }
    });
    _timer = Timer.periodic(Duration(seconds: 6), (v) {
      _changePointToCurrent();
    });
    AndroidYandexMap.useAndroidViewSurface = false;

    refreshdata().then((value) => () async {
          setState(() {});
        });
    _animationController1 = AnimationController(
      animationBehavior: AnimationBehavior.preserve,
      vsync: this,
      upperBound: 571.h,
      lowerBound: 0,
      duration: Duration(
        milliseconds: 571,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        setState(() {});
      });
  }

  void dispose() {
    super.dispose();
context.mapPr.isMapScreenForBaseView= false;
    context.mapPr.changeNewBottomSheetData(null);
    context.mapPr.changeRegionIndex(-1);
    _animationTimer!.cancel();
    _timer!.cancel();
    // _animationController!.removeListener(() {});
    _animationController1!.removeListener(() {});

    // _animationController!.dispose();
    _animationController1!.dispose();
  }

  _onMapCreated(YandexMapController controller) async {
    _completer.complete(controller);
    yController = controller;
    Position? position = await _determinePosition(true);
    if (position != null) {
      _currPosition = position;
    }
    controller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: _currPosition.latitude,
            longitude: _currPosition.longitude,
          ),
          zoom: 10,
        ),
      ),
    );
  }

  GlobalKey globalKey1 = GlobalKey();
  GlobalKey globalKey2 = GlobalKey();

  double getWidgetInfo(GlobalKey _widgetKey) {
    if (_widgetKey.currentContext == null) {
      return 0;
    }
    RenderBox? renderBox =
        _widgetKey.currentContext?.findRenderObject() as RenderBox?;

    if (renderBox == null) {
      final Size size = renderBox!.size;

      return 0;
    } else {
      final Size size = renderBox.size;

      return size.height;
    }

    // final Offset offset = renderBox.localToGlobal();
    // (Offset.zero);
    //
    // print(
    //     'Position: ${(offset.dx + size.width) / 2}, ${(offset.dy + size.height) / 2}');
  }

  Future<void> _changePointToCurrent() async {
    context.read<LockProvider>().initializeTimer();
    List<MapObject<dynamic>> _list = [];
    Position? position = await _determinePosition(true);
    _mapObjects.forEach((element) {
      if (element.mapId.value != "myId") {
        _list.add(element);
      }
    });
    _mapObjects = _list;

    if (position != null) {
      _currPosition = position;
      _mapObjects.add(
        PlacemarkMapObject(
          opacity: 1,
          icon: PlacemarkIcon.single(
            PlacemarkIconStyle(
              scale: 0.4.r,
              rotationType: RotationType.noRotation,
              image: BitmapDescriptor.fromAssetImage(
                "assets/images/location.png",
              ),
            ),
          ),
          mapId: MapObjectId("myId"),
          point: Point(
              latitude: _currPosition.latitude,
              longitude: _currPosition.longitude),
        ),
      );
    }
    setState(() {});
  }

  _changePointToCurrentMove() async {
    context.mapPr.changeExpandedwithValue(false);
    setState(() {});
    context.read<LockProvider>().initializeTimer();

    List<MapObject<dynamic>> _list = [];

    _mapObjects.forEach((element) {
      if (element.mapId.value != "myId") {
        _list.add(element);
      }
    });
    _mapObjects = _list;
    Position? position = await _determinePosition(false);
    if (position != null) {
      _currPosition = position;
      yController.moveCamera(
        animation: MapAnimation(
          duration: 0.5,
          type: MapAnimationType.linear,
        ),
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: Point(
              latitude: _currPosition.latitude,
              longitude: _currPosition.longitude,
            ),
            zoom: 15,
          ),
        ),
      );
    }
  }

  _changePoint(double lat, double long, {int? zoom}) async {
    zoom = zoom ?? 10;
    context.mapPr.changeExpandedwithValue(false);
    context.read<LockProvider>().initializeTimer();
    // var _currPosition = await _determinePosition();
    yController.moveCamera(
      animation: MapAnimation(
        duration: 0.5,
        type: MapAnimationType.linear,
      ),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: lat,
            longitude: long,
          ),
          zoom: zoom.toDouble(),
        ),
      ),
    );
  }

  Future<Position?> _determinePosition(bool isInit) async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (!isInit) {
        await AppSettings.openLocationSettings();
      }
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.whileInUse) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (!isInit) {
        await AppSettings.openLocationSettings();
      }
      return null;
    }
    return await Geolocator.getCurrentPosition(
        forceAndroidLocationManager: true,
        desiredAccuracy: LocationAccuracy.bestForNavigation);
  }

  @override
  Widget build(BuildContext context) {

    return SwipeInGoBack(
        child: Scaffold(
            body: AnimatedBuilder(
                animation: newbottomsheetAnimation!,
                builder: (context, child1) {
                  return AnimatedBuilder(
                      animation: newbottomsheetAnimatio322!,
                      builder: (context, child1) {
                        return AnimatedBuilder(
                            animation: _animationController1!,
                            builder: (context, child1) {
                              return Stack(
                                children: [
                                  YandexMap(
                                    onMapCreated: _onMapCreated,
                                    onMapLongTap: (position) {
                                      context
                                          .read<LockProvider>()
                                          .initializeTimer();
                                      context.mapPr
                                          .changeExpandedwithValue(false);
                                      yCOORDINATE = 0;
                                      isForward = false;
                                      _animationController1!.reverse();
                                    },
                                    onMapTap: (position) {
                                      context.mapPr
                                          .changeExpandedwithValue(false);
                                      context
                                          .read<LockProvider>()
                                          .initializeTimer();
                                      yCOORDINATE = 0;
                                      isForward = false;
                                      if (_animationController1 != null) {
                                        _animationController1!.reverse();
                                      }
                                      newbottomsheetAnimation!.reverse();
                                    },
                                    onCameraPositionChanged: (position, r, b) {
                                      context
                                          .read<LockProvider>()
                                          .initializeTimer();
                                      context.mapPr
                                          .changeExpandedwithValue(false);
                                      yCOORDINATE = 0;
                                      isForward = false;
                                      _animationController1!.reverse();
                                      context
                                          .read<LockProvider>()
                                          .initializeTimer();
                                    },
                                    mapObjects: _mapObjects,
                                  ),
                                  Positioned(
                                    top: 50.h,
                                    left: 10.w,
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          child: IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: Icon(
                                              Icons.arrow_back_ios_new_outlined,
                                              color: ColorConst
                                                  .instance.kPrimaryColor,
                                            ),
                                          ),
                                          backgroundColor:
                                              ColorConst.instance.kButtonColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (state == getcoordinata.initial ||
                                      state == getcoordinata.loading)
                                    Container(
                                      color: Colors.white,
                                      child: LoadingPage(true),
                                    ),
                                  if (state == getcoordinata.error)
                                    Center(child: Text(fulldata["error"])),
                                  if (state == getcoordinata.success)
                                    Positioned(
                                      bottom: 91.h,
                                      left: 0,
                                      right: 0,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  right: 14.w,
                                                  bottom: 11.h,
                                                ),
                                                child: InkWell(
                                                  onTap:
                                                      _changePointToCurrentMove,
                                                  child: Container(
                                                    width: context.w * 0.12,
                                                    height: context.h * 0.06,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: context.mapPrStream
                                                                  .indexButton ==
                                                              4
                                                          ? ColorConst.instance
                                                              .kGreenOpacity
                                                          : ColorConst.instance
                                                              .kButtonColor,
                                                      shape: BoxShape.circle,
                                                      boxShadow: <BoxShadow>[
                                                        BoxShadow(
                                                          blurRadius: 10,
                                                          color: ColorConst
                                                              .instance
                                                              .kShadowColor
                                                              .withOpacity(
                                                                  0.11),
                                                          offset: const Offset(
                                                              0, -4),
                                                          spreadRadius: 0,
                                                        ),
                                                      ],
                                                    ),
                                                    child: SvgPicture.asset(
                                                      ImageConst.instance
                                                          .toSvg("gps"),
                                                      color: context.mapPrStream
                                                                  .indexButton ==
                                                              4
                                                          ? ColorConst.instance
                                                              .kButtonColor
                                                          : ColorConst.instance
                                                              .kPrimaryColor,
                                                      width: context.h * 0.03,
                                                      height: context.h * 0.03,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            child: changeBottomShett(
                                              fulldata["getBancomates"],
                                              fulldata["getRegions"],
                                              fulldata["getBranches"],
                                              context,
                                            ),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(
                                                    16.r,
                                                  ),
                                                  topRight: Radius.circular(
                                                    16.r,
                                                  ),
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(
                                                        0.11,
                                                      ),
                                                      blurRadius: 10.r,
                                                      offset: Offset(
                                                        0,
                                                        -4.h,
                                                      )),
                                                ]),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (state == getcoordinata.success)
                                    Positioned(
                                      left: 0,
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                        width: 1.sw,
                                        height: 94.h,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 16.w,
                                            vertical: 16.h,
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  context.mapPr
                                                      .changeExpandedwithValue(
                                                          false);
                                                  getPointswithFiltr(
                                                      fulldata["getBancomates"],
                                                      fulldata["getRegions"],
                                                      fulldata["getBranches"],
                                                      1);
                                                  context.mapPr
                                                      .changeButtonState(0);
                                                  context.mapPr
                                                      .changeNewBottomSheetData(
                                                          null);
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 15.w),
                                                  // width: 1.sw,
                                                  height: 46.h,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: context.mapPrStream
                                                                .indexButton ==
                                                            0
                                                        ? Color(0xff357E4E)
                                                        : Color(0XFFF2F3F7),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            context.h * 0.025),
                                                  ),
                                                  child: Text(
                                                    "branchs".locale,
                                                    style: TextStyle(
                                                      color: context.mapPrStream
                                                                  .indexButton ==
                                                              0
                                                          ? ColorConst.instance
                                                              .kButtonColor
                                                          : ColorConst.instance
                                                              .kMainTextColor,
                                                      fontSize: FontSizeConst
                                                          .instance.medium,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              context.mapPrStream.indexButton ==
                                                      0
                                                  ? InkWell(
                                                      onTap: () {
                                                        context.mapPr
                                                            .changeExpandedwithValue(
                                                                false);
                                                        getPointswithFiltr(
                                                            fulldata[
                                                                "getBancomates"],
                                                            fulldata[
                                                                "getRegions"],
                                                            fulldata[
                                                                "getBranches"],
                                                            2);
                                                        context.mapPr
                                                            .changeButtonState(
                                                                1);
                                                        context.mapPr
                                                            .changeNewBottomSheetData(
                                                                null);
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    15.w),
                                                        height: 46.h,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0XFFF2F3F7),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      context.h *
                                                                          0.025),
                                                        ),
                                                        child: Text(
                                                          "bancomates".locale,
                                                          style: TextStyle(
                                                            color: ColorConst
                                                                .instance
                                                                .kMainTextColor,
                                                            fontSize:
                                                                FontSizeConst
                                                                    .instance
                                                                    .medium,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      padding: EdgeInsets.only(
                                                        left: 10.w,
                                                        right: 5.w,
                                                      ),
                                                      height: 46.h,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xff357E4E),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          context.h * 0.025,
                                                        ),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              context.mapPr
                                                                  .changeExpandedwithValue(
                                                                      false);
                                                              getPointswithFiltr(
                                                                  fulldata[
                                                                      "getBancomates"],
                                                                  fulldata[
                                                                      "getRegions"],
                                                                  fulldata[
                                                                      "getBranches"],
                                                                  2);
                                                              context.mapPr
                                                                  .changeButtonState(
                                                                      1);
                                                              context.mapPr
                                                                  .changeNewBottomSheetData(
                                                                      null);
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5.w),
                                                              child: Text(
                                                                "bancomates"
                                                                    .locale,
                                                                style:
                                                                    TextStyle(
                                                                  color: ColorConst
                                                                      .instance
                                                                      .kButtonColor,
                                                                  fontSize:
                                                                      FontSizeConst
                                                                          .instance
                                                                          .medium,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 10.w,
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              context.mapPr
                                                                  .changeExpandedwithValue(
                                                                      false);
                                                              getPointswithFiltr(
                                                                  fulldata[
                                                                      "getBancomates"],
                                                                  fulldata[
                                                                      "getRegions"],
                                                                  fulldata[
                                                                      "getBranches"],
                                                                  3);
                                                              context.mapPr
                                                                  .changeButtonState(
                                                                      3);
                                                              context.mapPr
                                                                  .changeNewBottomSheetData(
                                                                      null);
                                                            },
                                                            child: Container(
                                                              width: 35.h,
                                                              height: 35.h,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .white,
                                                                  width: 1.w,
                                                                ),
                                                                color: context.mapPrStream.indexButton ==
                                                                            3 ||
                                                                        context.mapPrStream.indexButton ==
                                                                            1
                                                                    ? Color(
                                                                        0xff357E4E)
                                                                    : Colors
                                                                        .white,
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child:
                                                                  Image.asset(
                                                                ImageConst
                                                                    .instance
                                                                    .toPng(
                                                                        "humo_map_logo"),
                                                                color: context.mapPrStream.indexButton ==
                                                                            3 ||
                                                                        context.mapPrStream.indexButton ==
                                                                            1
                                                                    ? Colors
                                                                        .white
                                                                    : Color(
                                                                        0xff357E4E),
                                                                width: 18.w,
                                                                height: 18.w,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: context.mapPr
                                                                        .indexButton ==
                                                                    0
                                                                ? 0
                                                                : 10,
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              context.mapPr
                                                                  .changeExpandedwithValue(
                                                                      false);
                                                              getPointswithFiltr(
                                                                  fulldata[
                                                                      "getBancomates"],
                                                                  fulldata[
                                                                      "getRegions"],
                                                                  fulldata[
                                                                      "getBranches"],
                                                                  4);
                                                              context.mapPr
                                                                  .changeButtonState(
                                                                      2);
                                                              context.mapPr
                                                                  .changeNewBottomSheetData(
                                                                      null);
                                                            },
                                                            child: Container(
                                                              width: 35.h,
                                                              height: 35.h,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .white,
                                                                  width: 1.w,
                                                                ),
                                                                color: !(context.mapPr.indexButton ==
                                                                            2 ||
                                                                        context.mapPr.indexButton ==
                                                                            1)
                                                                    ? Colors
                                                                        .white
                                                                    : Color(
                                                                        0xff357E4E),
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child:
                                                                  Image.asset(
                                                                ImageConst
                                                                    .instance
                                                                    .toPng(
                                                                        "uzcard_map_logo"),
                                                                color: context.mapPr.indexButton ==
                                                                            2 ||
                                                                        context.mapPr.indexButton ==
                                                                            1
                                                                    ? Colors
                                                                        .white
                                                                    : Color(
                                                                        0xff357E4E),
                                                                width: 18.w,
                                                                height: 18.w,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                              SizedBox(
                                                width:
                                                    context.mapPr.indexButton ==
                                                            0
                                                        ? 0
                                                        : 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border(
                                            top: BorderSide(
                                              color: Color(0xffD6D6D6)
                                                  .withOpacity(0.7),
                                              width: 0.5.h,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  Positioned(
                                      bottom: -(newbottomsheetAnimatio322!
                                                  .upperBound +
                                              newbottomsheetAnimation!
                                                  .upperBound) +
                                          newbottomsheetAnimatio322!.value +
                                          newbottomsheetAnimation!.value,
                                      child: Container(
                                        width: 1.sw,
                                        // height: 50.h,
                                        child:
                                            context.mapPr.newbottomsheetData ==
                                                    null
                                                ? Container(
                                                    width: 1.sw,
                                                  )
                                                : buildNewBottomWidget(
                                                    context.mapPr
                                                        .newbottomsheetData[0],
                                                    context.mapPr
                                                        .newbottomsheetData[1],
                                                    context.mapPr
                                                        .newbottomsheetData[2]),
                                      )),
                                ],
                              );
                            });
                      });
                })),
        onWillPop: () async {
          return true;
        });
  }

  Widget buildNewBottomWidget(data, int i, String image_name) {
    if (context.mapPr.indexButton != 0) {
      return LayoutBuilder(
        key: globalKey1,
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 55.w,
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    GestureDetector(
                      onVerticalDragUpdate: (DragUpdateDetails details) {
                        details.delta.dy;
                        if (newbottomsheetAnimation!.value.toInt() ==
                                newbottomsheetAnimation!.upperBound.toInt() &&
                            details.delta.dy > 6) {
                          newbottomsheetAnimation!.reverse();
                        }
                        if (newbottomsheetAnimation!.value.toInt() ==
                                newbottomsheetAnimation!.lowerBound.toInt() &&
                            details.delta.dy > 6) {
                          newbottomsheetAnimatio322!.reverse();
                        }
                        if (newbottomsheetAnimation!.value.toInt() ==
                                newbottomsheetAnimation!.lowerBound.toInt() &&
                            details.delta.dy < -6) {
                          newbottomsheetAnimation!.forward();
                        }
                      },
                      child: CustomPaint(
                        painter: RPSCustomPainter(),
                        child: Container(
                          // color: Colors.blue,
                          child: Column(
                            children: [
                              Container(
                                // color: Colors.grey,
                                child: Transform.translate(
                                  offset: Offset(0, 18.6.h),
                                  child: Container(
                                    height: 36.6.h,
                                    // color: Colors.green,
                                    width: double.infinity,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        right: 18.6.h,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              newbottomsheetAnimation!
                                                  .reverse()
                                                  .then((value) {
                                                newbottomsheetAnimatio322!
                                                    .reverse();
                                              });
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.all(10.h),
                                              child: Container(
                                                width: 16.6.h,
                                                height: 16.6.h,
                                                child: SvgPicture.asset(
                                                  ImageConst.instance
                                                      .toSvg("bottom-close"),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                  context.w * 0.03,
                                  context.h * 0.04,
                                  context.w * 0.03,
                                  context.h * 0.03,
                                ),
                                child: Container(
                                  // color: Colors.blueGrey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child: Center(
                                          child: image_name == "uzcard_humo"
                                              ? Text(
                                                  "bancomates".locale +
                                                      ": " +
                                                      " UzCard " +
                                                      (MapProvider().language ==
                                                              "ru"
                                                          ? "и"
                                                          : "va") +
                                                      " Humo",
                                                  style: TextStyle(
                                                    color: ColorConst.instance
                                                        .kMainTextColor,
                                                    fontSize: FontSizeConst
                                                        .instance.extraLarge,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                )
                                              : Text(
                                                  "bancomates".locale +
                                                      ": " +
                                                      data[i]
                                                          .type
                                                          .toString()
                                                          .split("Type.")[1],
                                                  style: TextStyle(
                                                    color: ColorConst.instance
                                                        .kMainTextColor,
                                                    fontSize: FontSizeConst
                                                        .instance.extraLarge,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                        ),
                                      ),
                                      Container(height: context.h * 0.02),
                                      newbottomsheetAnimation!.value == 0
                                          ? Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 16.w,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    height: 44.h,
                                                    child: AutoSizeText(
                                                      context.mapPr.textBancomates(
                                                          context.mapPr
                                                                  .newbottomsheetData[
                                                              0],
                                                          context.mapPr
                                                              .newbottomsheetData[1]),
                                                      style: FontstyleText
                                                          .instance
                                                          .mainPageMultiWithUzcard,
                                                    ),
                                                  ),
                                                  Text(
                                                    context.mapPr.timeBancomes(
                                                            context.mapPr
                                                                    .newbottomsheetData[
                                                                0],
                                                            context.mapPr
                                                                    .newbottomsheetData[
                                                                1]) +
                                                        "," +
                                                        context.mapPr.workDaysBancomes(
                                                            context.mapPr
                                                                    .newbottomsheetData[
                                                                0],
                                                            context.mapPr
                                                                .newbottomsheetData[1]),
                                                    style: TextStyle(
                                                      color: ColorConst.instance
                                                          .kPrimaryColor,
                                                      fontSize: FontSizeConst
                                                          .instance.bottom,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  "address".locale,
                                                  style: context.theme.caption,
                                                ),
                                                Container(
                                                    height: context.h * 0.0075),
                                                Container(
                                                  child: AutoSizeText(
                                                    context.mapPr
                                                        .textBancomates(
                                                            data, i),
                                                    style: TextStyle(
                                                      color: ColorConst.instance
                                                          .kMainTextColor,
                                                      fontSize: FontSizeConst
                                                          .instance.maptext,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      height: 22.h,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Icon(
                                                        Icons.circle,
                                                        color: ColorConst
                                                            .instance
                                                            .kPrimaryColor,
                                                        size: context.h * 0.015,
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 340.w,
                                                      child: AutoSizeText(
                                                        "target".locale +
                                                            context.mapPr
                                                                .orienterBancomates(
                                                                    data, i),
                                                        style: TextStyle(
                                                          color: ColorConst
                                                              .instance
                                                              .kMainTextColor,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                    // Container(
                                                    //   child: AutoSizeText(
                                                    //     context.mapPr
                                                    //         .orienterBancomates(data, i),
                                                    //     style: TextStyle(
                                                    //       color: ColorConst
                                                    //           .instance.kMainTextColor,
                                                    //       fontSize: 16,
                                                    //       fontWeight: FontWeight.w400,
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                      Opacity(
                                        opacity:
                                            newbottomsheetAnimation!.value == 0
                                                ? 0
                                                : 1,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(height: context.h * 0.02),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  "work_schedule".locale,
                                                  style: context.theme.caption,
                                                ),
                                                Container(
                                                    height: context.h * 0.0075),
                                                Row(
                                                  children: <Widget>[
                                                    Text(
                                                      context.mapPr
                                                          .timeBancomes(
                                                              data, i),
                                                      style: TextStyle(
                                                        color: ColorConst
                                                            .instance
                                                            .kMainTextColor,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    Text(
                                                      " " +
                                                          context.mapPr
                                                              .workDaysBancomes(
                                                                  data, i),
                                                      style: TextStyle(
                                                        color: ColorConst
                                                            .instance
                                                            .kMainTextColor,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Container(height: context.h * 0.02),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  "services2".locale,
                                                  style: context.theme.caption,
                                                ),
                                                Container(
                                                    height: context.h * 0.0075),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          context.w * 0.03),
                                                  child: Text(
                                                    context.mapPr
                                                        .serviceBancomates(
                                                            data, i),
                                                    style: TextStyle(
                                                      color: ColorConst.instance
                                                          .kMainTextColor,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: -55.w,
                      left: context.w * 0.5 - 45.w,
                      child: GestureDetector(
                        onVerticalDragUpdate: (DragUpdateDetails details) {
                          details.delta.dy;
                          if (newbottomsheetAnimation!.value.toInt() ==
                                  newbottomsheetAnimation!.upperBound.toInt() &&
                              details.delta.dy > 6) {
                            newbottomsheetAnimation!.reverse();
                          }
                          if (newbottomsheetAnimation!.value.toInt() ==
                                  newbottomsheetAnimation!.lowerBound.toInt() &&
                              details.delta.dy > 6) {
                            newbottomsheetAnimatio322!.reverse();
                          }
                          if (newbottomsheetAnimation!.value.toInt() ==
                                  newbottomsheetAnimation!.lowerBound.toInt() &&
                              details.delta.dy < -6) {
                            newbottomsheetAnimation!.forward();
                          }
                        },
                        onTap: () {
                          if (newbottomsheetAnimation!.value.toInt() ==
                              newbottomsheetAnimation!.upperBound.toInt()) {
                            newbottomsheetAnimation!.reverse();
                          }
                          if (newbottomsheetAnimation!.value.toInt() ==
                              newbottomsheetAnimation!.lowerBound.toInt()) {
                            newbottomsheetAnimation!.forward();
                          }
                        },
                        child: SvgPicture.asset(
                          ImageConst.instance.toSvg(image_name),
                          width: 90.w,
                          height: 90.w,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    }
    return LayoutBuilder(
        key: globalKey2,
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 37.w,
                ),
                Stack(
                  // alignment: Alignment.topCenter,
                  clipBehavior: Clip.none,
                  children: [
                    GestureDetector(
                      onVerticalDragUpdate: (DragUpdateDetails details) {
                        details.delta.dy;
                        if (newbottomsheetAnimation!.value.toInt() ==
                                newbottomsheetAnimation!.upperBound.toInt() &&
                            details.delta.dy > 6) {
                          newbottomsheetAnimation!.reverse();
                        }
                        if (newbottomsheetAnimation!.value.toInt() ==
                                newbottomsheetAnimation!.lowerBound.toInt() &&
                            details.delta.dy > 6) {
                          newbottomsheetAnimatio322!.reverse();
                        }
                        if (newbottomsheetAnimation!.value.toInt() ==
                                newbottomsheetAnimation!.lowerBound.toInt() &&
                            details.delta.dy < -6) {
                          newbottomsheetAnimation!.forward();
                        }
                      },
                      child: CustomPaint(
                        size: Size(context.w, (context.h * 1.048).toDouble()),
                        painter: RPSCustomPainterr(),
                        child: Container(
                          width: double.infinity,
                          // color: Colors.yellow,
                          child: CustomPaint(
                            painter: RPSCustomPainter(),
                            child: Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Transform.translate(
                                    offset: Offset(0, 18.6.h),
                                    child: Container(
                                      height: 36.6.h,
                                      width: double.infinity,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          right: 18.6.h,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                newbottomsheetAnimation!
                                                    .reverse()
                                                    .then((value) {
                                                  newbottomsheetAnimatio322!
                                                      .reverse();
                                                });
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.all(
                                                  10.h,
                                                ),
                                                child: Container(
                                                  width: 16.6.h,
                                                  height: 16.6.h,
                                                  child: SvgPicture.asset(
                                                    ImageConst.instance
                                                        .toSvg("bottom-close"),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                      context.w * 0.03,
                                      context.h * 0.04,
                                      context.w * 0.03,
                                      context.h * 0.03,
                                    ),
                                    child: Container(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Center(
                                            child: Text(
                                              data[i].title.toString(),
                                              style: TextStyle(
                                                  color: ColorConst
                                                      .instance.kMainTextColor,
                                                  fontSize: FontSizeConst
                                                      .instance.extraLarge,
                                                  fontWeight: FontWeight.w600,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                          ),
                                          SizedBox(height: context.h * 0.02.h),
                                          newbottomsheetAnimation!.value == 0
                                              ? Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 16.w,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Container(
                                                        width: 343.w,
                                                        height: 44.h,
                                                        child: AutoSizeText(
                                                          context.mapPr.textBranches(
                                                              context.mapPr
                                                                      .newbottomsheetData[
                                                                  0],
                                                              context.mapPr
                                                                  .newbottomsheetData[1]),
                                                          style: FontstyleText
                                                              .instance
                                                              .mainPageMultiWithUzcard,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 343.w,
                                                        child: AutoSizeText(
                                                          context.mapPr
                                                              .textOpenTimeBranches(
                                                                  context.mapPr
                                                                          .newbottomsheetData[
                                                                      0],
                                                                  context.mapPr
                                                                      .newbottomsheetData[1]),
                                                          // +
                                                          // "," +
                                                          // context.mapPr.workDaysBancomes(
                                                          //     context.mapPr
                                                          //         .newbottomsheetData[0],
                                                          //     context.mapPr
                                                          // .newbottomsheetData[1]),
                                                          style: TextStyle(
                                                            color: ColorConst
                                                                .instance
                                                                .kPrimaryColor,
                                                            fontSize:
                                                                FontSizeConst
                                                                    .instance
                                                                    .bottom,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        "address".locale,
                                                        style: context
                                                            .theme.caption,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            context.h * 0.0075),
                                                    Container(
                                                      child: AutoSizeText(
                                                        context.mapPr
                                                            .textBranches(
                                                                data, i),
                                                        style: TextStyle(
                                                          color: ColorConst
                                                              .instance
                                                              .kMainTextColor,
                                                          fontSize:
                                                              FontSizeConst
                                                                  .instance
                                                                  .maptext,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                          SizedBox(height: context.h * 0.02),
                                          // if (!isBottom)
                                          Opacity(
                                            opacity: newbottomsheetAnimation!
                                                        .value ==
                                                    0
                                                ? 0
                                                : 1,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      "work_schedule".locale,
                                                      style:
                                                          context.theme.caption,
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            context.h * 0.0075),
                                                    Row(
                                                      children: <Widget>[
                                                        Text(
                                                          "opening_hours"
                                                              .locale,
                                                          style: TextStyle(
                                                            color: ColorConst
                                                                .instance
                                                                .kMainTextColor,
                                                            fontSize:
                                                                FontSizeConst
                                                                    .instance
                                                                    .maptext,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                        Text(
                                                          context.mapPr
                                                              .timeBranches(
                                                                  data, i),
                                                          style: TextStyle(
                                                            color: ColorConst
                                                                .instance
                                                                .kMainTextColor,
                                                            fontSize:
                                                                FontSizeConst
                                                                    .instance
                                                                    .maptext,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      "technical_break"
                                                          .locale
                                                          .replaceAll(
                                                            "NUMBER",
                                                            data[i]
                                                                .lunchTime
                                                                .toString()
                                                                .split(
                                                                    "THE_")[1]
                                                                .lunchtime,
                                                          ),
                                                      style: TextStyle(
                                                        color: ColorConst
                                                            .instance
                                                            .kMainTextColor,
                                                        fontSize: FontSizeConst
                                                            .instance.maptext,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    Text(
                                                      "sat_sun".locale.replaceAll(
                                                          "NUMBER",
                                                          context.mapPr
                                                              .weekendsBranches(
                                                                  data, i)),
                                                      style: TextStyle(
                                                        color: ColorConst
                                                            .instance
                                                            .kMainTextColor,
                                                        fontSize: FontSizeConst
                                                            .instance.maptext,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                    height: context.h * 0.02),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      "services2".locale,
                                                      style:
                                                          context.theme.caption,
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            context.h * 0.0075),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  context.w *
                                                                      0.03),
                                                      child: Text(
                                                        context.mapPr
                                                            .serviceBranches(
                                                                data, i),
                                                        style: TextStyle(
                                                          color: ColorConst
                                                              .instance
                                                              .kMainTextColor,
                                                          fontSize:
                                                              FontSizeConst
                                                                  .instance
                                                                  .maptext,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: -37.w,
                      left: context.w * 0.5 - 43.5.w,
                      child: GestureDetector(
                        onVerticalDragUpdate: (DragUpdateDetails details) {
                          details.delta.dy;
                          if (newbottomsheetAnimation!.value.toInt() ==
                                  newbottomsheetAnimation!.upperBound.toInt() &&
                              details.delta.dy > 6) {
                            newbottomsheetAnimation!.reverse();
                          }
                          if (newbottomsheetAnimation!.value.toInt() ==
                                  newbottomsheetAnimation!.lowerBound.toInt() &&
                              details.delta.dy > 6) {
                            newbottomsheetAnimatio322!.reverse();
                          }
                          if (newbottomsheetAnimation!.value.toInt() ==
                                  newbottomsheetAnimation!.lowerBound.toInt() &&
                              details.delta.dy < -6) {
                            newbottomsheetAnimation!.forward();
                          }
                        },
                        onTap: () {
                          if (newbottomsheetAnimation!.value.toInt() ==
                              newbottomsheetAnimation!.upperBound.toInt()) {
                            newbottomsheetAnimation!.reverse();
                          }
                          if (newbottomsheetAnimation!.value.toInt() ==
                              newbottomsheetAnimation!.lowerBound.toInt()) {
                            newbottomsheetAnimation!.forward();
                          }
                        },
                        child: SvgPicture.asset(
                          ImageConst.instance.toSvg(image_name),
                          width: 87.w,
                          height: 87.w,
                        ),
                      ),
                    ),

                    // ChildSizeNotifier(
                    //   builder: (context, size, child) {
                    //     // size is the size of the text
                    //     return Container(
                    //       height: 300,
                    //       child: Text(size.height.toString() ));
                    //   },
                    //   child: Container(height: 200.h),
                    // ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  getPointswithFiltr(
    BancomatesModel bancomatec,
    RegionsModel regions,
    BranchesModel branches,
    int type,
  ) async {
    _mapObjects.clear();
    _changePointToCurrent();

    if (type == 1) {
      List<branche.Datum> list = branches.data!;
      // for (var i = 0; i < branches.data!.length; i++) {
      //   if (branches.data![i].regionCode == context.mapPr.regionCode) {
      //     list.add(branches.data![i]);
      //   }
      // }
      for (var i = 0; i < list.length; i++) {
        _mapObjects.add(
          PlacemarkMapObject(
            onTap: (placeMarker, point) async {
              if (placeMarkerIndex == -1) {
                context.mapPr.changeExpandedwithValue(false);
                placeMarkerIndex = 1;
                context.mapPr
                    .changeNewBottomSheetData([list, i, "hamkor_rectangle"]);
                newbottomsheetAnimation!.value = 0;
                setState(() {});
                newbottomsheetAnimatio322!.forward(from: 0).then((value) {
                  newbottomsheetAnimation!.forward(from: 0).then((value) {
                    if (getWidgetInfo(globalKey1) != 0) {
                      newbottomsheetAnimation = AnimationController(
                        vsync: this,
                        lowerBound: 0,
                        value: getWidgetInfo(globalKey1) - 322.h,
                        upperBound: getWidgetInfo(globalKey1) - 322.h,
                        duration: Duration(
                          milliseconds:
                              (getWidgetInfo(globalKey1) - 322.h) ~/ 2.h,
                        ),
                      )
                        ..addListener(() {
                          setState(() {});
                        })
                        ..addStatusListener((status) {
                          setState(() {});
                        })
                        ..notifyListeners();
                    }
                    if (getWidgetInfo(globalKey2) != 0) {
                      newbottomsheetAnimation = AnimationController(
                        vsync: this,
                        lowerBound: 0,
                        value: getWidgetInfo(globalKey2) - 322.h,
                        upperBound: getWidgetInfo(globalKey2) - 322.h,
                        duration: Duration(
                          milliseconds:

                              //         (getWidgetInfo(globalKey2) - 322.h) ~/ 2.h,

                              //  ),

                              (getWidgetInfo(globalKey2) - 322.h) ~/ 2.h,
                        ),
                      )
                        ..addListener(() {
                          setState(() {});
                        })
                        ..addStatusListener((status) {
                          setState(() {});
                        })
                        ..notifyListeners();
                    }
                  });
                });
                // await Fillials().filials(context, list, i);
                placeMarkerIndex = -1;
              }
            },
            opacity: 1,
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                scale: 0.6.r,
                rotationType: RotationType.noRotation,
                image: BitmapDescriptor.fromAssetImage(
                  "assets/images/FILLIAL_MAP.png",
                ),
              ),
            ),
            mapId: MapObjectId("$i branches" +
                DateTime.now().microsecondsSinceEpoch.toString()),
            point: Point(
              latitude: double.parse(list[i].coords!.lat!),
              longitude: double.parse(list[i].coords!.lng!),
            ),
          ),
        );
      }
    }
    if (type == 2) {
      List<bancomate.Datum> list = bancomatec.data!;

      // for (var i = 0; i < bancomatec.data!.length; i++) {
      //   if (bancomatec.data![i].regionCode == context.mapPr.regionCode) {
      //     list.add(bancomatec.data![i]);
      //   }
      // }
      Map<String, List<bancomate.Datum>> resultList = {
        "UZCARD": [],
        "HUMO": [],
        "UZCARD-HUMO": []
      };
      List<bancomate.Datum> humoList = [];
      List<bancomate.Datum> uzcardList = [];
      list.forEach((element) {
        if (element.type.toString().split("Type.")[1] == "UZCARD") {
          uzcardList.add(element);
        } else if (element.type.toString().split("Type.")[1] == "HUMO") {
          humoList.add(element);
        }
      });

      humoList.forEach((humo) {
        bool isCheck = true;
        for (int i = 0; i < uzcardList.length; i++) {
          bancomate.Datum uzcard = uzcardList[i];

          if (humo.coords!.lat == uzcard.coords!.lat &&
              humo.coords!.lng == uzcard.coords!.lng) {
            resultList["UZCARD-HUMO"]!.add(humo);
            isCheck = false;
            uzcardList.removeAt(i);

            break;
          }
        }
        if (isCheck) {
          resultList["HUMO"]!.add(humo);
        }
      });
      resultList["UZCARD"] = uzcardList;

      for (var i = 0; i < resultList["UZCARD"]!.length; i++) {
        _mapObjects.add(
          PlacemarkMapObject(
            onTap: (placemarker, point) async {
              if (placeMarkerIndex == -1) {
                context.mapPr.changeExpandedwithValue(false);
                placeMarkerIndex = 1;
                // await UzCardScreen.uzCard(context, resultList["UZCARD"]!, i);
                context.mapPr.changeNewBottomSheetData(
                    [resultList["UZCARD"]!, i, "uzcard_rectangle"]);
                newbottomsheetAnimation!.value = 0;
                setState(() {});
                newbottomsheetAnimatio322!.forward(from: 0).then((value) {
                  newbottomsheetAnimation!.forward(from: 0).then((value) {
                    if (getWidgetInfo(globalKey1) != 0) {
                      newbottomsheetAnimation = AnimationController(
                        vsync: this,
                        lowerBound: 0,
                        value: getWidgetInfo(globalKey1) - 322.h,
                        upperBound: getWidgetInfo(globalKey1) - 322.h,
                        duration: Duration(
                          milliseconds:
                              (getWidgetInfo(globalKey1) - 322.h) ~/ 2.h,
                        ),
                      )
                        ..addListener(() {
                          setState(() {});
                        })
                        ..addStatusListener((status) {
                          setState(() {});
                        })
                        ..notifyListeners();
                    }
                    if (getWidgetInfo(globalKey2) != 0) {
                      newbottomsheetAnimation = AnimationController(
                        vsync: this,
                        lowerBound: 0,
                        value: getWidgetInfo(globalKey2) - 322.h,
                        upperBound: getWidgetInfo(globalKey2) - 322.h,
                        duration: Duration(
                          milliseconds:
                              (getWidgetInfo(globalKey2) - 322.h) ~/ 2.h,
                        ),
                      )
                        ..addListener(() {
                          setState(() {});
                        })
                        ..addStatusListener((status) {
                          setState(() {});
                        })
                        ..notifyListeners();
                    }
                  });
                });
                ;
                //  = [resultList["UZCARD"]!,i,"uzcard_rectangle"];
                placeMarkerIndex = -1;
              }
            },
            opacity: 1,
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                  scale: 0.6.r,
                  rotationType: RotationType.noRotation,
                  image: BitmapDescriptor.fromAssetImage(
                      "assets/images/UZCARD_MAP.png")),
            ),
            mapId: MapObjectId("$i bancomatec1" +
                DateTime.now().microsecondsSinceEpoch.toString()),
            point: Point(
              latitude: double.parse(resultList["UZCARD"]![i].coords!.lat!),
              longitude: double.parse(resultList["UZCARD"]![i].coords!.lng!),
            ),
          ),
        );
      }
      for (var i = 0; i < resultList["HUMO"]!.length; i++) {
        _mapObjects.add(
          PlacemarkMapObject(
            onTap: (placemarker, point) async {
              if (placeMarkerIndex == -1) {
                context.mapPr.changeExpandedwithValue(false);
                placeMarkerIndex = 1;
                // await HumoScreen.humo(context, resultList["HUMO"]!, i);
                context.mapPr.changeNewBottomSheetData([
                  resultList["HUMO"]!,
                  i,
                  "humo_rectangle",
                ]);
                newbottomsheetAnimation!.value = 0;
                setState(() {});
                newbottomsheetAnimatio322!.forward(from: 0).then((value) {
                  newbottomsheetAnimation!.forward(from: 0).then((value) {
                    if (getWidgetInfo(globalKey1) != 0) {
                      newbottomsheetAnimation = AnimationController(
                        vsync: this,
                        lowerBound: 0,
                        value: getWidgetInfo(globalKey1) - 322.h,
                        upperBound: getWidgetInfo(globalKey1) - 322.h,
                        duration: Duration(
                          milliseconds:
                              (getWidgetInfo(globalKey1) - 322.h) ~/ 2.h,
                        ),
                      )
                        ..addListener(() {
                          setState(() {});
                        })
                        ..addStatusListener((status) {
                          setState(() {});
                        })
                        ..notifyListeners();
                    }
                    if (getWidgetInfo(globalKey2) != 0) {
                      newbottomsheetAnimation = AnimationController(
                        vsync: this,
                        lowerBound: 0,
                        value: getWidgetInfo(globalKey2) - 322.h,
                        upperBound: getWidgetInfo(globalKey2) - 322.h,
                        duration: Duration(
                          milliseconds:
                              (getWidgetInfo(globalKey2) - 322.h) ~/ 2.h,
                        ),
                      )
                        ..addListener(() {
                          setState(() {});
                        })
                        ..addStatusListener((status) {
                          setState(() {});
                        })
                        ..notifyListeners();
                    }
                  });
                });
                ;
                // = [resultList["HUMO"]!,i,"humo_rectangle",];
                placeMarkerIndex = -1;
              }
            },
            opacity: 1,
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                  scale: 0.6.r,
                  rotationType: RotationType.noRotation,
                  image: BitmapDescriptor.fromAssetImage(
                      "assets/images/HUMO_MAP.png")),
            ),
            mapId: MapObjectId("$i bancomatec2" +
                DateTime.now().microsecondsSinceEpoch.toString()),
            point: Point(
              latitude: double.parse(resultList["HUMO"]![i].coords!.lat!),
              longitude: double.parse(resultList["HUMO"]![i].coords!.lng!),
            ),
          ),
        );
      }
      for (var i = 0; i < resultList["UZCARD-HUMO"]!.length; i++) {
        _mapObjects.add(
          PlacemarkMapObject(
            onTap: (placemarker, point) async {
              if (placeMarkerIndex == -1) {
                context.mapPr.changeExpandedwithValue(false);
                placeMarkerIndex = 1;
                // await UzCardHumoScreen.uzcard_humo(
                //     context, resultList["UZCARD-HUMO"]!, i);
                context.mapPr.changeNewBottomSheetData(
                    [resultList["UZCARD-HUMO"]!, i, "uzcard_humo"]);
                newbottomsheetAnimation!.value = 0;
                setState(() {});
                newbottomsheetAnimatio322!.forward(from: 0).then((value) {
                  newbottomsheetAnimation!.forward(from: 0).then((value) {
                    if (getWidgetInfo(globalKey1) != 0) {
                      newbottomsheetAnimation = AnimationController(
                        vsync: this,
                        lowerBound: 0,
                        value: getWidgetInfo(globalKey1) - 322.h,
                        upperBound: getWidgetInfo(globalKey1) - 322.h,
                        duration: Duration(
                          milliseconds:
                              (getWidgetInfo(globalKey1) - 322.h) ~/ 2.h,
                        ),
                      )
                        ..addListener(() {
                          setState(() {});
                        })
                        ..addStatusListener((status) {
                          setState(() {});
                        })
                        ..notifyListeners();
                    }
                    if (getWidgetInfo(globalKey2) != 0) {
                      newbottomsheetAnimation = AnimationController(
                        vsync: this,
                        lowerBound: 0,
                        upperBound: getWidgetInfo(globalKey2) - 322.h,
                        duration: Duration(
                          milliseconds:
                              (getWidgetInfo(globalKey2) - 322.h) ~/ 2.h,
                        ),
                      )
                        ..addListener(() {
                          setState(() {});
                        })
                        ..addStatusListener((status) {
                          setState(() {});
                        })
                        ..notifyListeners();
                    }
                  });
                });
                ;
                placeMarkerIndex = -1;
              }
            },
            opacity: 1,
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                  scale: 0.6.r,
                  rotationType: RotationType.noRotation,
                  image: BitmapDescriptor.fromAssetImage(
                      "assets/images/UZCARD-HUMO_MAP.png")),
            ),
            mapId: MapObjectId("$i bancomatec3" +
                DateTime.now().microsecondsSinceEpoch.toString()),
            point: Point(
              latitude:
                  double.parse(resultList["UZCARD-HUMO"]![i].coords!.lat!),
              longitude:
                  double.parse(resultList["UZCARD-HUMO"]![i].coords!.lng!),
            ),
          ),
        );
      }
    }

    if (type == 3) {
      List<bancomate.Datum> list = [];
      for (var i = 0; i < bancomatec.data!.length; i++) {
        if (bancomatec.data![i].type.toString().split("Type.")[1] == "HUMO"
            // &&
            //     bancomatec.data![i].regionCode == context.mapPr.regionCode
            ) {
          list.add(bancomatec.data![i]);
        }
      }
      for (var i = 0; i < list.length; i++) {
        _mapObjects.add(
          PlacemarkMapObject(
            onTap: (placemarker, point) async {
              if (placeMarkerIndex == -1) {
                context.mapPr.changeExpandedwithValue(false);
                placeMarkerIndex = 1;
                context.mapPr.changeNewBottomSheetData([
                  list,
                  i,
                  "humo_rectangle",
                ]);
                newbottomsheetAnimation!.value = 0;
                setState(() {});
                newbottomsheetAnimatio322!.forward(from: 0).then((value) {
                  newbottomsheetAnimation!.forward(from: 0).then((value) {
                    if (getWidgetInfo(globalKey1) != 0) {
                      newbottomsheetAnimation = AnimationController(
                        vsync: this,
                        lowerBound: 0,
                        value: getWidgetInfo(globalKey1) - 322.h,
                        upperBound: getWidgetInfo(globalKey1) - 322.h,
                        duration: Duration(
                          milliseconds:
                              (getWidgetInfo(globalKey1) - 322.h) ~/ 2.h,
                        ),
                      )
                        ..addListener(() {
                          setState(() {});
                        })
                        ..addStatusListener((status) {
                          setState(() {});
                        })
                        ..notifyListeners();
                    }
                    if (getWidgetInfo(globalKey2) != 0) {
                      newbottomsheetAnimation = AnimationController(
                        vsync: this,
                        lowerBound: 0,
                        value: getWidgetInfo(globalKey2) - 322.h,
                        upperBound: getWidgetInfo(globalKey2) - 322.h,
                        duration: Duration(
                          milliseconds:
                              (getWidgetInfo(globalKey2) - 322.h) ~/ 2.h,
                        ),
                      )
                        ..addListener(() {
                          setState(() {});
                        })
                        ..addStatusListener((status) {
                          setState(() {});
                        })
                        ..notifyListeners();
                    }
                  });
                });

                //  = [list,i,"humo_rectangle",];
                // await HumoScreen.humo(context, list, i);
                placeMarkerIndex = -1;
              }
            },
            opacity: 1,
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                  scale: 0.6.r,
                  rotationType: RotationType.noRotation,
                  image: BitmapDescriptor.fromAssetImage(
                      "assets/images/HUMO_MAP.png")),
            ),
            mapId: MapObjectId(
                "$i humo" + DateTime.now().microsecondsSinceEpoch.toString()),
            point: Point(
              latitude: double.parse(list[i].coords!.lat!),
              longitude: double.parse(list[i].coords!.lng!),
            ),
          ),
        );
      }
    }

    if (type == 4) {
      List<bancomate.Datum> list = [];
      for (var i = 0; i < bancomatec.data!.length; i++) {
        if (bancomatec.data![i].type.toString().split("Type.")[1] == "UZCARD"
            //  &&
            //     bancomatec.data![i].regionCode == context.mapPr.regionCode
            ) {
          list.add(bancomatec.data![i]);
        }
      }
      for (var i = 0; i < list.length; i++) {
        _mapObjects.add(
          PlacemarkMapObject(
            onTap: (placemarker, point) async {
              if (placeMarkerIndex == -1) {
                context.mapPr.changeExpandedwithValue(false);
                placeMarkerIndex = 1;
                context.mapPr
                    .changeNewBottomSheetData([list, i, "uzcard_rectangle"]);
                newbottomsheetAnimation!.value = 0;
                newbottomsheetAnimatio322!.value = 0;
                setState(() {});
                newbottomsheetAnimatio322!.forward(from: 0).then((value) {
                  newbottomsheetAnimation!.forward(from: 0).then((value) {
                    if (getWidgetInfo(globalKey1) != 0) {
                      newbottomsheetAnimation = AnimationController(
                        vsync: this,
                        lowerBound: 0,
                        value: getWidgetInfo(globalKey1) - 322.h,
                        upperBound: getWidgetInfo(globalKey1) - 322.h,
                        duration: Duration(
                          milliseconds:
                              (getWidgetInfo(globalKey1) - 322.h) ~/ 2.h,
                        ),
                      )
                        ..addListener(() {
                          setState(() {});
                        })
                        ..addStatusListener((status) {
                          setState(() {});
                        })
                        ..notifyListeners();
                    }
                    if (getWidgetInfo(globalKey2) != 0) {
                      newbottomsheetAnimation = AnimationController(
                        vsync: this,
                        lowerBound: 0,
                        value: getWidgetInfo(globalKey2) - 322.h,
                        upperBound: getWidgetInfo(globalKey2) - 322.h,
                        duration: Duration(
                          milliseconds:
                              (getWidgetInfo(globalKey2) - 322.h) ~/ 2.h,
                        ),
                      )
                        ..addListener(() {})
                        ..addStatusListener((status) {
                          setState(() {});
                        })
                        ..notifyListeners();
                    }
                  });
                });
                ;
                //  = [list,i,"uzcard_rectangle"];
                // await UzCardScreen.uzCard(context, list, i);
                placeMarkerIndex = -1;
              }
            },
            opacity: 1,
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                  scale: 0.6.r,
                  rotationType: RotationType.noRotation,
                  image: BitmapDescriptor.fromAssetImage(
                      "assets/images/UZCARD_MAP.png")),
            ),
            mapId: MapObjectId(
                "$i uzcard" + DateTime.now().microsecondsSinceEpoch.toString()),
            point: Point(
              latitude: double.parse(list[i].coords!.lat!),
              longitude: double.parse(list[i].coords!.lng!),
            ),
          ),
        );
      }
      ;
    }

    setState(() {});
  }

  LocalDistance calculateDistance(
      {double lat1 = 0, double lon1 = 0, double lat2 = 0, double lon2 = 0}) {
    String result = "";
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    double data = 12742000 * asin(sqrt(a));
    if (data > 1000) {
      result = (data.toInt() ~/ 1000).toString() +
          "km " +
          (data.toInt() % 1000 > 10
              ? ((data.toInt() % 1000) ~/ 10 * 10).toString() + "m"
              : "");
    } else {
      result = (data.toInt() % 1000 > 10
          ? ((data.toInt()) ~/ 10 * 10).toString() + "m"
          : "0m");
    }
    return LocalDistance(inDouble: data, inString: result);
  }

  Future refreshdata() async {
    state = getcoordinata.loading;
    setState(() {});
    try {
      Map data = {
        "getBancomates": await context.mapPr.getBancomates(context),
        "getRegions": await context.mapPr.getRegions(context),
        "getBranches": await context.mapPr.getBranches(context),
      };

      state = getcoordinata.success;

      fulldata = data;
    } catch (e) {
      state = getcoordinata.error;

      fulldata = {"error": "Yandex Map Error"};

      Navigator.pop(context);
    }

    if (context.mapPr.indexButton == 0) {
      getPointswithFiltr(
        fulldata["getBancomates"],
        fulldata["getRegions"],
        fulldata["getBranches"],
        1,
      );
    } else if (context.mapPr.indexButton == 1) {
      getPointswithFiltr(
        fulldata["getBancomates"],
        fulldata["getRegions"],
        fulldata["getBranches"],
        2,
      );
    }
    setState(() {});
  }

  changeBottomShett(BancomatesModel bancomatec, RegionsModel regions,
      BranchesModel branches, BuildContext context) {
    context.read<LockProvider>().initializeTimer();
    if (context.mapPr.bottomSheetIndex == 0) {
      return mainBottomSheet(bancomatec, regions, branches, context);
    } else if (context.mapPr.bottomSheetIndex == 1) {
      return Fillials();
    } else if (context.mapPr.bottomSheetIndex == 2) {
      return BankomatsScreen();
    }
  }

  mainBottomSheet(BancomatesModel bancomatec, RegionsModel regions,
      branche.BranchesModel branches, BuildContext context) {
    late final toshkent;
    regions.data!.removeWhere((region) {
      if (region.code == "26") {
        toshkent = region;
        return true;
      }
      return false;
    });
    regions.data!.sort((a, b) => a.title.compareTo(b.title));
    regions.data = [toshkent] + regions.data!;

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: GestureDetector(
              onVerticalDragUpdate: (_) async {
                if (yCOORDINATE - _.delta.dy * 5 >=
                    _animationController1!.upperBound) {
                  yCOORDINATE = _animationController1!.upperBound;
                } else if (yCOORDINATE - _.delta.dy * 5 <=
                    _animationController1!.lowerBound) {
                  yCOORDINATE = 0;
                } else {
                  yCOORDINATE -= _.delta.dy * 5;
                }

                if (_.delta.dy < 0) {
                  isForward = true;
                  _animationController1!.forward();
                } else if (_.delta.dy > 0) {
                  isForward = false;
                  _animationController1!.reverse();
                }
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      if (yCOORDINATE > 0) {
                        yCOORDINATE = 0;
                        isForward = false;
                        _animationController1!.reverse();
                      } else {
                        isForward = true;
                        _animationController1!.forward();
                        yCOORDINATE = _animationController1!.upperBound / 2;
                      }
                    },
                    child: Container(
                      height: 37.h,
                      child: Center(
                        child: Image.asset(
                          ImageConst.instance.toPng("divider"),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.w * 0.04,
                    ),
                    child: AnimatedContainer(
                      duration: Duration(seconds: 0),
                      height: context.mapPrStream.isExpanded ? 188.h : 47.h,
                      decoration: BoxDecoration(
                        color: ColorConst.instance.kBackgroundColor,
                        borderRadius: BorderRadius.circular(context.h * 0.02),
                      ),
                      child: Column(
                        children: <Widget>[
                          InkWell(
                            splashColor: Colors.blue,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: ColorConst.instance.kBackgroundColor,
                                  borderRadius:
                                      BorderRadius.circular(context.h * 0.02),
                                  boxShadow: context.mapPr.isExpanded
                                      ? [
                                          BoxShadow(
                                            color: Colors.grey.shade300,
                                            blurRadius: 5.r,
                                          )
                                        ]
                                      : null),
                              // color: Colors.red,
                              height: 47.h,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: context.w * 0.04,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    context.mapPrStream.regionIndex == -1
                                        ? Text(
                                            "choose_city_or_region".locale,
                                            style: context.theme.bodyText1,
                                          )
                                        : Text(
                                            regions
                                                .data![context
                                                    .mapPrStream.regionIndex]
                                                .title
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w400,
                                                color: ColorConst
                                                    .instance.kBlackColor),
                                          ),
                                    Icon(
                                      context.mapPrStream.isExpanded
                                          ? Icons.keyboard_arrow_up_rounded
                                          : Icons.keyboard_arrow_down_rounded,
                                      color: ColorConst.instance.kElementsColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              context.mapPr.changeisExpanded();
                              setState(() {});
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.w * 0.04,
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              height:
                                  context.mapPrStream.isExpanded ? 121.h : 0,
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: regions.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () async {
                                    
                                      context.mapPr.changeisExpanded();
                                      setState(() {});
                                      context.mapPr.changeRegionCode(
                                          regions.data![index].code.toString(),
                                          index);
                                      List list = await context.mapPr
                                          .regionLocation(regions
                                              .data![index].code
                                              .toString());

                                      await _changePoint(
                                        double.parse(list[0].toString()),
                                        double.parse(
                                          list[1].toString(),
                                        ),
                                      );

                                      if (context.mapPr.indexButton == 0) {
                                        getPointswithFiltr(
                                            fulldata["getBancomates"],
                                            fulldata["getRegions"],
                                            fulldata["getBranches"],
                                            1);
                                      } else if (context.mapPr.indexButton ==
                                          1) {
                                        getPointswithFiltr(
                                            fulldata["getBancomates"],
                                            fulldata["getRegions"],
                                            fulldata["getBranches"],
                                            2);
                                      } else if (context.mapPr.indexButton ==
                                          3) {
                                        getPointswithFiltr(
                                            fulldata["getBancomates"],
                                            fulldata["getRegions"],
                                            fulldata["getBranches"],
                                            3);
                                      } else if (context.mapPr.indexButton ==
                                          2) {
                                        getPointswithFiltr(
                                            fulldata["getBancomates"],
                                            fulldata["getRegions"],
                                            fulldata["getBranches"],
                                            4);
                                      }
                                      setState(() {});
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: index == 0 ? 10.h : 0,
                                        bottom:
                                            regions.data!.length - 1 == index
                                                ? 0
                                                : 18.h,
                                      ),
                                      child: Text(
                                        regions.data![index].title.toString(),
                                        style: TextStyle(
                                          color: ColorConst
                                              .instance.kSecondaryTextColor,
                                          fontSize:
                                              FontSizeConst.instance.small2,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: context.h * 0.01),
                ],
              ),
            ),
          ),
          bottomData(bancomatec, regions, branches, context)
        ],
      ),
    );
  }

  bottomData(BancomatesModel bancomatec, RegionsModel regions,
      BranchesModel branches, BuildContext context) {
    if (context.mapPrStream.indexButton == 0) {
      return branchesData(bancomatec, regions, branches, context);
    } else if (context.mapPrStream.indexButton == 1) {
      return bancomesData(bancomatec, regions, branches, context);
    } else if (context.mapPrStream.indexButton == 2) {
      return uzCardDdata(bancomatec, regions, branches, context);
    } else if (context.mapPrStream.indexButton == 3) {
      return humoData(bancomatec, regions, branches, context);
    }
  }

  bancomesData(BancomatesModel bancomatec, RegionsModel regions, final branches,
      BuildContext context) {
    List<bancomate.Datum> list = [];

    for (var i = 0; i < bancomatec.data!.length; i++) {
      if (bancomatec.data![i].regionCode == context.mapPrStream.regionCode) {
        list.add(bancomatec.data![i]);
      }
    }
    list.sort((a, b) => calculateDistance(
          lat1: _currPosition.latitude,
          lon1: _currPosition.longitude,
          lat2: double.parse(a.coords!.lat!),
          lon2: double.parse(a.coords!.lng!),
        ).inDouble.compareTo(calculateDistance(
              lat1: _currPosition.latitude,
              lon1: _currPosition.longitude,
              lat2: double.parse(b.coords!.lat!),
              lon2: double.parse(b.coords!.lng!),
            ).inDouble));
    return SizedBox(
      height: ((context.mapPrStream.isExpanded ? -141.h : 0) +
                  _animationController1!.value) >
              0
          ? ((context.mapPrStream.isExpanded ? -141.h : 0) +
              _animationController1!.value)
          : 0,
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 6.h,
              ),
              MapListTileW(
                onTap: () {
                  context.mapPr.bancomateIndex = index;
                  //   = list[index];
                  // BankomatsScreen.bankomats(context, list, index);
                  context.mapPr.changeNewBottomSheetData([
                    list,
                    index,
                    MapProvider.cardLogo(
                        list[index].type.toString().split("Type.")[1])
                  ]);
                  newbottomsheetAnimation!.value = 0;
                  newbottomsheetAnimatio322!.forward(from: 0).then((value) {
                    newbottomsheetAnimation!.forward(from: 0).then((value) {
                      if (getWidgetInfo(globalKey1) != 0) {
                        newbottomsheetAnimation = AnimationController(
                          vsync: this,
                          lowerBound: 0,
                          value: getWidgetInfo(globalKey1) - 322.h,
                          upperBound: getWidgetInfo(globalKey1) - 322.h,
                          duration: Duration(
                            milliseconds:
                                (getWidgetInfo(globalKey1) - 322.h) ~/ 2.h,
                          ),
                        )
                          ..addListener(() {
                            setState(() {});
                          })
                          ..addStatusListener((status) {
                            setState(() {});
                          })
                          ..notifyListeners();
                      }
                      if (getWidgetInfo(globalKey2) != 0) {
                        newbottomsheetAnimation = AnimationController(
                          vsync: this,
                          lowerBound: 0,
                          value: getWidgetInfo(globalKey2) - 322.h,
                          upperBound: getWidgetInfo(globalKey2) - 322.h,
                          duration: Duration(
                            milliseconds:
                                (getWidgetInfo(globalKey2) - 322.h) ~/ 2.h,
                          ),
                        )
                          ..addListener(() {
                            setState(() {});
                          })
                          ..addStatusListener((status) {
                            setState(() {});
                          })
                          ..notifyListeners();
                      }
                    });
                  });
                  ;
                  //   = [
                  //   list,
                  //   index,
                  //   MapProvider.cardLogo(
                  //       list[index].type.toString().split("Type.")[1])
                  // ];
                  setState(() {});
                  _changePoint(double.parse(list[0].coords!.lat.toString()),
                      double.parse(list[1].coords!.lng.toString()),
                      zoom: 8);
                },
                distance: calculateDistance(
                  lat1: _currPosition.latitude,
                  lon1: _currPosition.longitude,
                  lat2: double.parse(list[index].coords!.lat!),
                  lon2: double.parse(list[index].coords!.lng!),
                ).inString,
                leading: MapProvider.cardLogo(
                    list[index].type.toString().split("Type.")[1]),
                title: "bancomates".locale +
                    " : " +
                    list[index].type.toString().split("Type.")[1],
                subtitle: context.mapPr.textBancomates(list, index),
                open: context.mapPr.timeBancomes(list, index) +
                    "," +
                    context.mapPr.workDaysBancomes(list, index),
                isOpen: true,
              ),
            ],
          );
        },
      ),
    );
  }

  branchesData(BancomatesModel bancomatec, RegionsModel regions,
      BranchesModel branches, BuildContext context) {
    List<branche.Datum> list = [];

    for (var i = 0; i < branches.data!.length; i++) {
      if (branches.data![i].regionCode == context.mapPrStream.regionCode) {
        list.add(branches.data![i]);
      }
    }
    // Mirzo Ulugbek tumani,  Shaxrisabz ko'chasi,  1A uy
    dynamic item = null;
    list.removeWhere((element) {
      if (element.address!.uz ==
          "Mirzo Ulugbek tumani,  Shaxrisabz ko'chasi,  1A uy") {
        item = element;
        return true;
      }
      return false;
    });
    if (item != null) {
      list.add(item);
    }

    list.sort((a, b) => calculateDistance(
          lat1: _currPosition.latitude,
          lon1: _currPosition.longitude,
          lat2: double.tryParse(a.coords!.lat!) ?? 0,
          lon2: double.tryParse(a.coords!.lng!) ?? 0,
        ).inDouble.compareTo(calculateDistance(
              lat1: _currPosition.latitude,
              lon1: _currPosition.longitude,
              lat2: double.tryParse(b.coords!.lat!) ?? 0,
              lon2: double.tryParse(b.coords!.lng!) ?? 0,
            ).inDouble));

    return SizedBox(
      height: ((context.mapPrStream.isExpanded ? -141.h : 0) +
                  _animationController1!.value) >
              0
          ? ((context.mapPrStream.isExpanded ? -141.h : 0) +
              _animationController1!.value)
          : 0,
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 6.h,
              ),
              MapListTileW(
                onTap: () {
                  context.mapPr.brancheIndex = index;

                  // Fillials().filials(context, list, index);
                  context.mapPr.changeNewBottomSheetData(
                      [list, index, "hamkor_rectangle"]);
                  newbottomsheetAnimation!.value = 0;
                  newbottomsheetAnimatio322!.forward(from: 0).then((value) {
                    newbottomsheetAnimation!.forward(from: 0).then((value) {
                      if (getWidgetInfo(globalKey1) != 0) {
                        newbottomsheetAnimation = AnimationController(
                          vsync: this,
                          lowerBound: 0,
                          value: getWidgetInfo(globalKey1) - 322.h,
                          upperBound: getWidgetInfo(globalKey1) - 322.h,
                          duration: Duration(
                            milliseconds:
                                (getWidgetInfo(globalKey1) - 322.h) ~/ 2.h,
                          ),
                        )
                          ..addListener(() {
                            setState(() {});
                          })
                          ..addStatusListener((status) {
                            setState(() {});
                          })
                          ..notifyListeners();
                      }
                      if (getWidgetInfo(globalKey2) != 0) {
                        newbottomsheetAnimation = AnimationController(
                          vsync: this,
                          lowerBound: 0,
                          upperBound: getWidgetInfo(globalKey2) - 322.h,
                          duration: Duration(
                            milliseconds:
                                (getWidgetInfo(globalKey2) - 322.h) ~/ 2.h,
                          ),
                        )
                          ..addListener(() {
                            setState(() {});
                          })
                          ..addStatusListener((status) {
                            setState(() {});
                          })
                          ..notifyListeners();
                      }
                    });
                  });
                  ;
                  // = [list, index, "hamkor_rectangle"];
                  setState(() {});
                  _changePoint(double.parse(list[index].coords!.lat.toString()),
                      double.parse(list[index].coords!.lng.toString()),
                      zoom: 14);
                },
                distance: _currPosition == null
                    ? "0m"
                    : calculateDistance(
                        lat1: _currPosition.latitude,
                        lon1: _currPosition.longitude,
                        lat2: double.parse(list[index].coords!.lat!),
                        lon2: double.parse(list[index].coords!.lng!),
                      ).inString,
                leading: "hamkor_rectangle",
                title: list[index].title.toString(),
                subtitle: context.mapPr.textBranches(list, index),
                open: context.mapPr.textOpenTimeBranches(list, index),
                isOpen: list[index].isOpen,
              ),
            ],
          );
        },
      ),
    );
  }

  uzCardDdata(BancomatesModel bancomatec, RegionsModel regions, final branches,
      BuildContext context) {
    List<bancomate.Datum> list = [];
    for (var i = 0; i < bancomatec.data!.length; i++) {
      if (bancomatec.data![i].type.toString().split("Type.")[1] == "UZCARD" &&
          bancomatec.data![i].regionCode == context.mapPrStream.regionCode) {
        list.add(bancomatec.data![i]);
      }
    }
    list.sort((a, b) => calculateDistance(
          lat1: _currPosition.latitude,
          lon1: _currPosition.longitude,
          lat2: double.parse(a.coords!.lat!),
          lon2: double.parse(a.coords!.lng!),
        ).inDouble.compareTo(calculateDistance(
              lat1: _currPosition.latitude,
              lon1: _currPosition.longitude,
              lat2: double.parse(b.coords!.lat!),
              lon2: double.parse(b.coords!.lng!),
            ).inDouble));
    return SizedBox(
      height: ((context.mapPrStream.isExpanded ? -141.h : 0) +
                  _animationController1!.value) >
              0
          ? ((context.mapPrStream.isExpanded ? -141.h : 0) +
              _animationController1!.value)
          : 0,
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MapListTileW(
                onTap: () {
                  // UzCardScreen.uzCard(context, list, index);
                  context.mapPr.changeNewBottomSheetData(
                      [list, index, "uzcard_rectangle"]);
                  newbottomsheetAnimation!.value = 0;
                  newbottomsheetAnimatio322!.forward(from: 0).then((value) {
                    newbottomsheetAnimation!.forward(from: 0).then((value) {
                      if (getWidgetInfo(globalKey1) != 0) {
                        newbottomsheetAnimation = AnimationController(
                          vsync: this,
                          lowerBound: 0,
                          value: getWidgetInfo(globalKey1) - 322.h,
                          upperBound: getWidgetInfo(globalKey1) - 322.h,
                          duration: Duration(
                            milliseconds:
                                (getWidgetInfo(globalKey1) - 322.h) ~/ 2.h,
                          ),
                        )
                          ..addListener(() {
                            setState(() {});
                          })
                          ..addStatusListener((status) {
                            setState(() {});
                          })
                          ..notifyListeners();
                      }
                      if (getWidgetInfo(globalKey2) != 0) {
                        newbottomsheetAnimation = AnimationController(
                          vsync: this,
                          lowerBound: 0,
                          value: getWidgetInfo(globalKey2) - 322.h,
                          upperBound: getWidgetInfo(globalKey2) - 322.h,
                          duration: Duration(
                            milliseconds:
                                (getWidgetInfo(globalKey2) - 322.h) ~/ 2.h,
                          ),
                        )
                          ..addListener(() {
                            setState(() {});
                          })
                          ..addStatusListener((status) {
                            setState(() {});
                          })
                          ..notifyListeners();
                      }
                    });
                  });
                  ;
                  // = [list, index, "uzcard_rectangle"];
                  setState(() {});
                  _changePoint(double.parse(list[index].coords!.lat.toString()),
                      double.parse(list[index].coords!.lng.toString()),
                      zoom: 14);
                },
                distance: _currPosition == null
                    ? "0m"
                    : calculateDistance(
                        lat1: _currPosition.latitude,
                        lon1: _currPosition.longitude,
                        lat2: double.parse(list[index].coords!.lat!),
                        lon2: double.parse(list[index].coords!.lng!),
                      ).inString,
                leading: "uzcard_rectangle",
                title: "bancomates".locale +
                    " : " +
                    list[index].type.toString().split("Type.")[1],
                open: context.mapPr.timeBancomes(list, index) +
                    "," +
                    context.mapPr.workDaysBancomes(list, index),
                subtitle: context.mapPr.textBancomates(list, index),
              ),
            ],
          );
        },
      ),
    );
  }

  humoData(BancomatesModel bancomatec, RegionsModel regions, final branches,
      BuildContext context) {
    List<bancomate.Datum> list = [];
    for (var i = 0; i < bancomatec.data!.length; i++) {
      if (bancomatec.data![i].type.toString().split("Type.")[1] == "HUMO" &&
          bancomatec.data![i].regionCode == context.mapPrStream.regionCode) {
        list.add(bancomatec.data![i]);
      }
    }
    list.sort((a, b) => calculateDistance(
          lat1: _currPosition.latitude,
          lon1: _currPosition.longitude,
          lat2: double.parse(a.coords!.lat!),
          lon2: double.parse(a.coords!.lng!),
        ).inDouble.compareTo(calculateDistance(
              lat1: _currPosition.latitude,
              lon1: _currPosition.longitude,
              lat2: double.parse(b.coords!.lat!),
              lon2: double.parse(b.coords!.lng!),
            ).inDouble));
    return SizedBox(
      height: ((context.mapPrStream.isExpanded ? -141.h : 0) +
                  _animationController1!.value) >
              0
          ? ((context.mapPrStream.isExpanded ? -141.h : 0) +
              _animationController1!.value)
          : 0,
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 6.h,
              ),
              MapListTileW(
                  onTap: () {
                    // HumoScreen.humo(context, list, index);
                    context.mapPr.changeNewBottomSheetData(
                        [list, index, "humo_rectangle"]);
                    newbottomsheetAnimation!.value = 0;
                    newbottomsheetAnimatio322!.forward(from: 0).then((value) {
                      newbottomsheetAnimation!.forward(from: 0).then((value) {
                        if (getWidgetInfo(globalKey1) != 0) {
                          newbottomsheetAnimation = AnimationController(
                            vsync: this,
                            lowerBound: 0,
                            value: getWidgetInfo(globalKey1) - 322.h,
                            upperBound: getWidgetInfo(globalKey1) - 322.h,
                            duration: Duration(
                              milliseconds:
                                  (getWidgetInfo(globalKey1) - 322.h) ~/ 2.h,
                            ),
                          )
                            ..addListener(() {
                              setState(() {});
                            })
                            ..addStatusListener((status) {
                              setState(() {});
                            })
                            ..notifyListeners();
                        }
                        if (getWidgetInfo(globalKey2) != 0) {
                          newbottomsheetAnimation = AnimationController(
                            vsync: this,
                            lowerBound: 0,
                            value: getWidgetInfo(globalKey2) - 322.h,
                            upperBound: getWidgetInfo(globalKey2) - 322.h,
                            duration: Duration(
                              milliseconds:
                                  (getWidgetInfo(globalKey2) - 322.h) ~/ 2.h,
                            ),
                          )
                            ..addListener(() {
                              setState(() {});
                            })
                            ..addStatusListener((status) {
                              setState(() {});
                            })
                            ..notifyListeners();
                        }
                      });
                    });
                    ;
                    // = [list, index, "humo_rectangle"];
                    setState(() {});
                    _changePoint(
                        double.parse(list[index].coords!.lat.toString()),
                        double.parse(list[index].coords!.lng.toString()),
                        zoom: 14);
                  },
                  leading: "humo_rectangle",
                  distance: _currPosition == null
                      ? "0m"
                      : calculateDistance(
                          lat1: _currPosition.latitude,
                          lon1: _currPosition.longitude,
                          lat2: double.parse(list[index].coords!.lat!),
                          lon2: double.parse(list[index].coords!.lng!),
                        ).inString,
                  title: "bancomates".locale +
                      " : " +
                      list[index].type.toString().split("Type.")[1],
                  open: context.mapPr.timeBancomes(list, index) +
                      "," +
                      context.mapPr.workDaysBancomes(list, index),
                  subtitle: context.mapPr.textBancomates(list, index)),
            ],
          );
        },
      ),
    );
  }
}

class LocalDistance {
  String inString;
  double inDouble;
  LocalDistance({required this.inDouble, required this.inString});
}
