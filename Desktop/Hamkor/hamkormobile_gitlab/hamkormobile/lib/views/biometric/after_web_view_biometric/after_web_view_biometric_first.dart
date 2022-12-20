import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/provider/7_razvilka_provider.dart';
import 'package:mobile/views/biometric/after_web_view_biometric/after_web_view_camera_for_android_screen.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:mobile/core/constants/navigation/navigation_constant.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/models/settings_bio.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/views/biometric/after_home_page_biometric/after_home_page_biometry_screen_first.dart';
import 'package:mobile/views/biometric/after_razvilka_biometric/after_razvilka_biometry_screen_camera_for_android.dart';
import 'package:mobile/widgets/appbar/default_appbar.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class AfterWebViewBiometricFirst extends StatefulWidget {
  AfterWebViewBiometricFirst({
    Key? key,
  }) : super(key: key);
  @override
  State<AfterWebViewBiometricFirst> createState() =>
      _AfterWebViewBiometricFirstState();
}


class _AfterWebViewBiometricFirstState
    extends State<AfterWebViewBiometricFirst> {
  Future<SettingsBio>? bioData;
  @override
  void initState() {
    super.initState();
    givePermissionStorage();
    bioData = context.biometricPr.bioSettings();
  Provider.of<RazvilkaProvider>(context, listen: false).isBioService = true;
  }
  Future<void> givePermissionStorage() async {
    var status = Permission.storage;
  }
  @override
  Widget build(BuildContext context) {
    return SwipeInGoBack(
      onWillPop: () async {
        navigateBackButton();
        return true;
      },
      child: Scaffold(
        appBar: DefaultAppbar.getAppBar(
          "",
          () {
          navigateBackButton();
          },
          context,
          true,
        ),
        body: FirstView(
          onPressed: () async {
            cameras = await availableCameras();
            availableCameras().then((value) async {
              SettingsBio? mySettignsBio = await bioData;
              bool isSmile =
                  mySettignsBio == null ? false : mySettignsBio.data!.isSmile!;
              String resolution = mySettignsBio == null
                  ? "720"
                  : mySettignsBio.data!.resolution!;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) {
                  return AfterWebViewBiometricCameraAndroid(
                    resolution: resolution,
                    isSmile: isSmile,
                    cameras: value,
                  );
                }),
                (r) => false,
              );
            });
          },
        ),
      ),
    );
  }
  navigateBackButton(){
    if(context.biometricPr.isBioScreen){
   NavigationService.instance.pushNamedRemoveUntil(
                    routeName: NavigationConst.AFTER_RAZVILKA_BIOMETRIC_PAGE);   
    }else{
      if( GetStorageService.instance.box.read(GetStorageService.instance.isRazvilkaPage) == "true" ){
  NavigationService.instance.pushNamedRemoveUntil(
                routeName: NavigationConst.RAZVILKA_PAGE_VIEW);
      }
      else{
 NavigationService.instance.pushNamedRemoveUntil(
                routeName: NavigationConst.HOME_PAGE_VIEW);
      }
    }
  }
}
