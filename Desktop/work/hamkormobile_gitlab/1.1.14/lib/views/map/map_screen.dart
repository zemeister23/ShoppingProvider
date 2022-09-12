import 'dart:async';
import 'package:flutter/material.dart';
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
import 'package:mobile/views/map/humo_screen.dart';
import 'package:mobile/views/map/uz_card_screen.dart';
import 'package:mobile/widgets/listTile/map_bottom_list_tile.dart';
import 'package:provider/provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import '../../provider/lock_timer_provider.dart';

enum getcoordinata { initial, loading, error, success }

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Future<BancomatesModel>? getBancomates;
  Future<RegionsModel>? getRegions;
  Future<branche.BranchesModel>? getBranches;

  Completer<YandexMapController> _completer = Completer();
  late YandexMapController yController;
  List<MapObject> _mapObjects = [];
  getcoordinata state = getcoordinata.initial;
  Map fulldata = {};
  bool stateBottmSheet = true;
  @override
  void initState() {
    super.initState();
    refreshdata().then((value) => () {
          setState(() {});
        });

    // Provider.of<MapProvider>(context, listen: false).changeIsMapState(true);
  }

  _onMapCreated(YandexMapController controller) async {
    _completer.complete(controller);
    yController = controller;
    var _currPosition = await _determinePosition();
    controller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: _currPosition.latitude,
            longitude: _currPosition.longitude,
          ),
          zoom: 12,
        ),
      ),
    );
  }

  _changePointToCurrent() async {
    context.read<LockProvider>().initializeTimer();
    var _currPosition = await _determinePosition();
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
          zoom: 12,
        ),
      ),
    );
  }

  // ! USE THIS FUNC FOR CHANGE MAP
  _changePoint(lat, long) async {
    context.read<LockProvider>().initializeTimer();
    var _currPosition = await _determinePosition();
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
          zoom: 12,
        ),
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: Stack(
            children: [
              YandexMap(
                onMapCreated: _onMapCreated,
                onMapTap: (position) {
                  context.read<LockProvider>().initializeTimer();
                },
                onCameraPositionChanged: (position, r, b) {
                  context.read<LockProvider>().initializeTimer();
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
                          color: ColorConst.instance.kPrimaryColor,
                        ),
                      ),
                      backgroundColor: ColorConst.instance.kButtonColor,
                    ),
                  ],
                ),
              ),
              Positioned(
                  top: stateBottmSheet ? 420.h : 710.h,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => context.mapPr.changeButtonState(0),
                        child: Container(
                          width: context.w * 0.24,
                          height: context.h * 0.06,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: context.mapPrStream.indexButton == 0
                                ? ColorConst.instance.kGreenOpacity
                                : ColorConst.instance.kButtonColor,
                            borderRadius:
                                BorderRadius.circular(context.h * 0.025),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                blurRadius: 10,
                                color: ColorConst.instance.kShadowColor
                                    .withOpacity(0.11),
                                offset: const Offset(0, -4),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Text(
                            "branchs".locale,
                            style: TextStyle(
                              color: context.mapPrStream.indexButton == 0
                                  ? ColorConst.instance.kButtonColor
                                  : ColorConst.instance.kMainTextColor,
                              fontSize: FontSizeConst.instance.medium,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          context.mapPr.changeButtonState(1);
                        },
                        child: Container(
                          width: context.w * 0.28,
                          height: context.h * 0.06,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: context.mapPrStream.indexButton == 1
                                ? ColorConst.instance.kGreenOpacity
                                : ColorConst.instance.kButtonColor,
                            borderRadius:
                                BorderRadius.circular(context.h * 0.025),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                blurRadius: 10,
                                color: ColorConst.instance.kShadowColor
                                    .withOpacity(0.11),
                                offset: const Offset(0, -4),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Text(
                            "bancomates".locale,
                            style: TextStyle(
                              color: context.mapPrStream.indexButton == 1
                                  ? ColorConst.instance.kButtonColor
                                  : ColorConst.instance.kMainTextColor,
                              fontSize: FontSizeConst.instance.medium,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      context.mapPr.indexButton == 0
                          ? SizedBox()
                          : InkWell(
                              onTap: () => context.mapPr.changeButtonState(3),
                              child: Container(
                                width: context.w * 0.12,
                                height: context.h * 0.06,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: context.mapPrStream.indexButton == 3
                                      ? ColorConst.instance.kGreenOpacity
                                      : ColorConst.instance.kButtonColor,
                                  shape: BoxShape.circle,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      blurRadius: 10,
                                      color: ColorConst.instance.kShadowColor
                                          .withOpacity(0.11),
                                      offset: const Offset(0, -4),
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: Image.asset(
                                  ImageConst.instance.toPng("humo_map_logo"),
                                  color: context.mapPrStream.indexButton == 3
                                      ? ColorConst.instance.kButtonColor
                                      : ColorConst.instance.kPrimaryColor,
                                  width: context.h * 0.03,
                                  height: context.h * 0.03,
                                ),
                              ),
                            ),
                      SizedBox(
                        width: context.mapPr.indexButton == 0 ? 0 : 10,
                      ),
                      context.mapPr.indexButton == 0
                          ? SizedBox()
                          : InkWell(
                              onTap: () => context.mapPr.changeButtonState(2),
                              child: Container(
                                width: context.w * 0.12,
                                height: context.h * 0.06,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: context.mapPr.indexButton == 2
                                      ? ColorConst.instance.kGreenOpacity
                                      : ColorConst.instance.kButtonColor,
                                  shape: BoxShape.circle,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      blurRadius: 10,
                                      color: ColorConst.instance.kShadowColor
                                          .withOpacity(0.11),
                                      offset: const Offset(0, -4),
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: Image.asset(
                                  ImageConst.instance.toPng("uzcard_map_logo"),
                                  color: context.mapPr.indexButton == 2
                                      ? ColorConst.instance.kButtonColor
                                      : ColorConst.instance.kPrimaryColor,
                                  width: context.h * 0.03,
                                  height: context.h * 0.03,
                                ),
                              ),
                            ),
                      SizedBox(
                        width: context.mapPr.indexButton == 0 ? 0 : 10,
                      ),
                      InkWell(
                        onTap: _changePointToCurrent,
                        child: Container(
                          width: context.w * 0.12,
                          height: context.h * 0.06,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: context.mapPrStream.indexButton == 4
                                ? ColorConst.instance.kGreenOpacity
                                : ColorConst.instance.kButtonColor,
                            shape: BoxShape.circle,
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                blurRadius: 10,
                                color: ColorConst.instance.kShadowColor
                                    .withOpacity(0.11),
                                offset: const Offset(0, -4),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: SvgPicture.asset(
                            ImageConst.instance.toSvg("gps"),
                            color: context.mapPrStream.indexButton == 4
                                ? ColorConst.instance.kButtonColor
                                : ColorConst.instance.kPrimaryColor,
                            width: context.h * 0.03,
                            height: context.h * 0.03,
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
          bottomSheet: stateBottmSheet
              ? state == getcoordinata.initial || state == getcoordinata.loading
                  ? LoadingPage(true)
                  : state == getcoordinata.success
                      ? changeBottomShett(
                          fulldata["getBancomates"],
                          fulldata["getRegions"],
                          fulldata["getBranches"],
                          context)
                      : Center(child: Text(fulldata["error"]))
              : InkWell(
                  onTapDown: (v) {
                    setState(() {
                      stateBottmSheet = !stateBottmSheet;
                    });
                  },
                  child: Container(
                    height: 50.h,
                    width: double.infinity,
                    color: Colors.white,
                    child: Center(
                      child: Image.asset(
                        ImageConst.instance.toPng("divider"),
                      ),
                    ),
                  ),
                ),
        ),
        onWillPop: () async {
          return true;
        });
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

      fulldata = {"error": e.toString()};
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
    bool isExpanded = false;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        InkWell(
          onTapDown: (v) {
            setState(() {
              stateBottmSheet = !stateBottmSheet;
            });
          },
          child: Container(
            //  color: Colors.red,
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
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.w * 0.04,
              ),
              child: Column(
                children: <Widget>[
                  InkWell(
                    child: SizedBox(
                      height: 47.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          context.mapPrStream.regionIndex == -1
                              ? Text(
                                  "choose_city_or_region".locale,
                                  style: context.theme.bodyText1,
                                )
                              : Text(
                                  regions.data![context.mapPrStream.regionIndex]
                                      .title
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400,
                                      color: ColorConst.instance.kBlackColor),
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
                    onTap: () {
                      context.mapPr.changeisExpanded();
                    },
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: context.mapPrStream.isExpanded ? 141.h : 0,
                    child: ListView.builder(
                      itemCount: regions.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () async {
                            context.mapPr.changeRegionCode(
                                regions.data![index].code.toString(), index);
                            context.mapPr.changeisExpanded();
                            List list = await context.mapPr.regionLocation(
                                regions.data![index].code.toString());
                            await _changePoint(
                                list[0].toString(), list[1].toString());
                            setState(() {});
                          },
                          child: Text(
                            regions.data![index].title.toString(),
                            style: TextStyle(
                              color: ColorConst.instance.kSecondaryTextColor,
                              fontSize: FontSizeConst.instance.small2,
                              fontWeight: FontWeight.w600,
                              height: context.h * 0.004,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: context.h * 0.01),
        bottomData(bancomatec, regions, branches, context)
      ],
    );
  }

  bottomData(BancomatesModel bancomatec, RegionsModel regions,
      BranchesModel branches, BuildContext context) {
    _mapObjects.clear();
    setState(() {});

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
          opacity: 1,
          icon: PlacemarkIcon.single(
            PlacemarkIconStyle(
                scale: 1,
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
          opacity: 1,
          icon: PlacemarkIcon.single(
            PlacemarkIconStyle(
                scale: 1,
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
          opacity: 1,
          icon: PlacemarkIcon.single(
            PlacemarkIconStyle(
                scale: 1,
                rotationType: RotationType.noRotation,
                image: BitmapDescriptor.fromAssetImage(
                    "assets/images/UZCARD-HUMO_MAP.png")),
          ),
          mapId: MapObjectId("$i bancomatec3" +
              DateTime.now().microsecondsSinceEpoch.toString()),
          point: Point(
            latitude: double.parse(resultList["UZCARD-HUMO"]![i].coords!.lat!),
            longitude: double.parse(resultList["UZCARD-HUMO"]![i].coords!.lng!),
          ),
        ),
      );
    }

    return SizedBox(
      height: context.h * 0.3,
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Padding(
              //   padding: EdgeInsets.symmetric(
              //     horizontal: context.w * 0.04,
              //     vertical: context.h * 0.02,
              //   ),
              //   child: Text(
              //     "В радиусе 1 км",
              //     style: TextStyle(
              //       color: ColorConst.instance.kSecondaryTextColor,
              //       fontSize: FontSizeConst.instance.bottom,
              //       fontWeight: FontWeight.w600,
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 6.h,
              ),
              MapListTileW(
                onTap: () {
                  context.mapPr.bancomateIndex = index;
                  BankomatsScreen.bankomats(context, list, index);
                  //  context.mapPr.changeBottomSheetIndex(2);
                },
                leading: MapProvider.cardLogo(
                    list[index].type.toString().split("Type.")[1]),
                title: "bancomates".locale +
                    " : " +
                    list[index].type.toString().split("Type.")[1],
                subtitle: context.mapPr.textBancomates(list, index),
                open: "",
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

        _mapObjects.add(
          PlacemarkMapObject(
            opacity: 1,
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                  scale: 1,
                  rotationType: RotationType.noRotation,
                  image: BitmapDescriptor.fromAssetImage(
                      "assets/images/FILLIAL_MAP.png")),
            ),
            mapId: MapObjectId("$i branches" +
                DateTime.now().microsecondsSinceEpoch.toString()),
            point: Point(
              latitude: double.parse(branches.data![i].coords!.lat!),
              longitude: double.parse(branches.data![i].coords!.lng!),
            ),
          ),
        );
      }
    }
    return SizedBox(
      height: context.h * 0.3,
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Padding(
              //   padding: EdgeInsets.symmetric(
              //     horizontal: context.w * 0.04,
              //     vertical: context.h * 0.02,
              //   ),
              //   child: Text(
              //     " ",
              //     //  "В радиусе 1 км",
              //     style: TextStyle(
              //       color: ColorConst.instance.kSecondaryTextColor,
              //       fontSize: FontSizeConst.instance.bottom,
              //       fontWeight: FontWeight.w600,
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 6.h,
              ),
              MapListTileW(
                onTap: () {
                  context.mapPr.brancheIndex = index;
                  // context.mapPr.changeBottomSheetIndex(1);
                  Fillials.filials(context, list, index);
                },
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
        _mapObjects.add(
          PlacemarkMapObject(
            opacity: 1,
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                  scale: 1,
                  rotationType: RotationType.noRotation,
                  image: BitmapDescriptor.fromAssetImage(
                      "assets/images/UZCARD_MAP.png")),
            ),
            mapId: MapObjectId(
                "$i uzcard" + DateTime.now().microsecondsSinceEpoch.toString()),
            point: Point(
              latitude: double.parse(bancomatec.data![i].coords!.lat!),
              longitude: double.parse(bancomatec.data![i].coords!.lng!),
            ),
          ),
        );
      }
    }
    return SizedBox(
      height: context.h * 0.3,
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Padding(
              //   padding: EdgeInsets.symmetric(
              //     horizontal: context.w * 0.04,
              //     vertical: context.h * 0.02,
              //   ),
              //   child: Text(
              //     "В радиусе 1 км",
              //     style: TextStyle(
              //       color: ColorConst.instance.kSecondaryTextColor,
              //       fontSize: FontSizeConst.instance.bottom,
              //       fontWeight: FontWeight.w600,
              //     ),
              //   ),
              // ),
              MapListTileW(
                  onTap: () {
                    UzCardScreen.uzCard(context, list, index);
                  },
                  leading: "uzcard_rectangle",
                  title: "bancomates".locale +
                      " : " +
                      list[index].type.toString().split("Type.")[1],
                  open: "",
                  subtitle: context.mapPr.textBancomates(list, index)),
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
        // var marker= YandexMap()
        _mapObjects.add(
          PlacemarkMapObject(
            opacity: 1,
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                  scale: 1,
                  rotationType: RotationType.noRotation,
                  image: BitmapDescriptor.fromAssetImage(
                      "assets/images/HUMO_MAP.png")),
            ),
            mapId: MapObjectId(
                "$i humo" + DateTime.now().microsecondsSinceEpoch.toString()),
            point: Point(
              latitude: double.parse(bancomatec.data![i].coords!.lat!),
              longitude: double.parse(bancomatec.data![i].coords!.lng!),
            ),
          ),
        );
      }
    }
    return SizedBox(
      height: context.h * 0.3,
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Padding(
              //   padding: EdgeInsets.symmetric(
              //     horizontal: context.w * 0.04,
              //     vertical: context.h * 0.02,
              //   ),
              //   child: Text(
              //     "В радиусе 1 км",
              //     style: TextStyle(
              //       color: ColorConst.instance.kSecondaryTextColor,
              //       fontSize: FontSizeConst.instance.bottom,
              //       fontWeight: FontWeight.w600,
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 6.h,
              ),
              MapListTileW(
                  onTap: () {
                    HumoScreen.humo(context, list, index);
                  },
                  leading: "humo_rectangle",
                  title: "bancomates".locale +
                      " : " +
                      list[index].type.toString().split("Type.")[1],
                  open: "",
                  subtitle: context.mapPr.textBancomates(list, index)),
            ],
          );
        },
      ),
    );
  }
}
