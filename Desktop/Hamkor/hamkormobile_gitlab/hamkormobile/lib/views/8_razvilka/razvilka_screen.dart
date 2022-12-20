import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/core/components/loading/loading_page.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/error/alert_error.dart';
import 'package:mobile/core/constants/images/image_const.dart';
import 'package:mobile/core/constants/navigation/navigation_constant.dart';
import 'package:mobile/core/constants/sizeconst/size_const.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/models/razvilka_model.dart';
import 'package:mobile/models/store_action_model.dart';
import 'package:mobile/provider/7_razvilka_provider.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/widgets/appbar/default_appbar.dart';
import 'package:mobile/widgets/outlined_buttun.dart';
import 'package:mobile/widgets/gradient_button_widget.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:provider/provider.dart';
import '../../core/init/cache/get_storege.dart';
import '../../service/api_service/face_id_touch_id_service/face_id_touch_id_service.dart';

class RazvilkaPage extends StatefulWidget {
  RazvilkaPage({Key? key}) : super(key: key) {
    GetStorageService.instance.box
        .write(GetStorageService.instance.pageState, "true");
    GetStorageService.instance.box
        .write(GetStorageService.instance.isRazvilkaPage, "true");
  }
  @override
  State<RazvilkaPage> createState() => _RazvilkaPageState();
}

class _RazvilkaPageState extends State<RazvilkaPage> {
  late Uri toLaunch;
  Future<StoreActionModel>? storeActionData;
  List<BiometricType>? availableBiometrics;
  @override
  void initState() {
    super.initState();
   
    if((GetStorageService.instance.box
            .read(GetStorageService.instance.hasFaceTouch) ==
        null)){
           instanceFace().then((value)async{
  Platform.isIOS && availableBiometrics!.contains(BiometricType.face)
        ? await initFaceIos(context)
        : await initFaceAndTouch(context);
    });

    }
   

    context.biometricPr.isBioScreen = false;
    Provider.of<RazvilkaProvider>(context, listen: false).isBioService = false;
    storeActionData = Provider.of<RazvilkaProvider>(context, listen: false)
        .getStoreAction(context);
   
  }

  @override
  Widget build(BuildContext context) {
    return SwipeInGoBack(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: DefaultAppbar.getAppBar(
          "",
          () {
            NavigationService.instance.pushNamedRemoveUntil(
                routeName: NavigationConst.INTRO_PAGE_VIEW);
          },
          context,
          true,
          backgoundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                const Spacer(flex: 15),
                SvgPicture.asset(
                  ImageConst.instance.miniLogo,
                  color: ColorConst.instance.kPrimaryColor,
                ),
                const Spacer(flex: 15),
                Expanded(
                  flex: 4,
                  child: GradientButton(
                    text: "add_card".locale,
                    width: 343.w,
                    height: 56.h,
                    colorOpacity: true,
                    onPressed: () {
                      NavigationService.instance
                          .pushNamed(routeName: "/9_addcard");
                    },
                  ),
                ),
                const Spacer(flex: 1),
                Expanded(
                  flex: 4,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 0, // SizeConst.instance.paddingW
                        ),
                        child: OutlinedButtonW(
                          opacity: 1,
                          text: "online_services".locale,
                          width: 339.w,
                          height: SizeConst.instance.buttonSize,
                          onPressed: () {
                            context.biometricPr.isNavigateHomePage = false;
                            storeActionData!.then((value) {
                              WebViewRoute(value, toLaunch, context);
                            });
                          },
                        ),
                   
                   
                     ),
                      FutureBuilder<StoreActionModel>(
                        future: storeActionData,
                        builder:
                            ((context, AsyncSnapshot<StoreActionModel> snap) {
                          if (!snap.hasData) {
                            return SizedBox();
                          } else if (snap.hasError) {
                            return SizedBox();
                          } else {
                            toLaunch = snap.data!.data!.link == null
                                ? Uri.parse("")
                                : Uri.parse(snap.data!.data!.link.toString());

                            GetStorageService.instance.box.write(
                                GetStorageService.instance.toLaunch,
                                toLaunch.toString());

                            return snap.data!.data!.count! > 0
                                ? Positioned(
                                    top: -context.h * 0.012,
                                    right: context.h * 0.025,
                                    child: CircleAvatar(
                                      backgroundColor:
                                          ColorConst.instance.kBackgroundColor,
                                      radius: context.h * 0.02,
                                      child: CircleAvatar(
                                        child: Text(
                                            (snap.data!.data!.count ?? 0)
                                                .toString()),
                                        backgroundColor:
                                            ColorConst.instance.kOrangeColor,
                                        radius: context.h * 0.015,
                                      ),
                                    ))
                                : SizedBox();
                          }
                        }),
                      ),
                    ],
                  ),
                ),
                const Spacer(flex: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }

 Future instanceFace() async {
    LocalAuthentication auth = await LocalAuthentication();
    availableBiometrics = await auth.getAvailableBiometrics();
  }

  initFaceAndTouch(BuildContext context) async {
    return await FaceAndTouchIDService.instance.Face_ID_and_Touch_ID(context,
        bioSuccsess: () async {
  
      if (GetStorageService.instance.box
              .read(GetStorageService.instance.hasFaceTouch) ==
          null) {
        Navigator.pop(context);
      }

      GetStorageService.instance.box
          .write(GetStorageService.instance.hasFaceTouch, "true");
    }, bioDontNow: () async {
      GetStorageService.instance.box
          .write(GetStorageService.instance.hasFaceTouch, "false");
      Navigator.pop(context);
    });
  }

  initFaceIos(BuildContext context) async {
    return await FaceAndTouchIDService.instance.Face_ID_and_Touch_ID(context,
        bioSuccsess: () async {
    
      if (GetStorageService.instance.box
              .read(GetStorageService.instance.hasFaceTouch) ==
          null) {}

      GetStorageService.instance.box
          .write(GetStorageService.instance.hasFaceTouch, "true");
    }, bioDontNow: () async {
      GetStorageService.instance.box
          .write(GetStorageService.instance.hasFaceTouch, "false");
    });
  }
}

class WebViewRoute {
  WebViewRoute(StoreActionModel value, Uri toLaunch, BuildContext context) {
    //  Provider.of<RazvilkaProvider>(context, listen: false).isBioService = true;
    if (value.data!.action == 1) {
      NavigationService.instance
          .pushNamed(routeName: NavigationConst.AFTER_RAZVILKA_BIOMETRIC_PAGE);
    } else if (value.data!.action == 2) {
      NavigationService.instance
          .pushNamed(routeName: NavigationConst.AFTER_RAZVILKA_BIOMETRIC_PAGE);
    } else if (value.data!.action == 3) {
      toLaunch = value.data!.link == null
          ? Uri.parse("")
          : Uri.parse(value.data!.link.toString());
      NavigationService.instance.pushNamed(
          routeName: NavigationConst.VIEW_ADD_CARD_WEB_PAGE, data: toLaunch);
    }
  }
}

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    required this.gradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}
