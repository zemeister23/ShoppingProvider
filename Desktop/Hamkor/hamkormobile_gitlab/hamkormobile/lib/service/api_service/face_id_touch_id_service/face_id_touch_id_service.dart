import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/error/mobile_erorr.dart';
import 'package:mobile/core/constants/navigation/navigation_constant.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/provider/6_check_pin_code_provider.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:mobile/widgets/new_dialog/alerty_dialog_2.dart';
import 'package:provider/provider.dart';

import '../../../widgets/bottomSheet/face_id_bottomsheet.dart';

class FaceAndTouchIDService {
  static final FaceAndTouchIDService _instance = FaceAndTouchIDService._init();
  static FaceAndTouchIDService get instance => _instance;
  LocalAuthentication? auth;

  late bool didAuthenticate;
  late bool canCheckBiometrics;
  late bool isDeviceSupported;
  List<BiometricType>? availableBiometrics;
  List<AuthMessages> authMessages =  <AuthMessages>[
    AndroidAuthMessages(
      // biometricRequiredTitle: "Title",
      // biometricNotRecognized: "Alo",
      // biometricSuccess: "dsdsdsdsd",
      // goToSettingsButton: "keyingi",
      biometricHint: "",
      // goToSettingsDescription: "Bla Bla",
      signInTitle: 'face-id-title'.locale,

      // cancelButton: 'Отмена',
    ),
    // IOSAuthMessages(
    //  goToSettingsDescription: "a",
    //  lockOut: "b",
    //  localizedFallbackTitle: "c",
    // ),
  ];

  Future Face_ID_and_Touch_ID(
    BuildContext context, {
    required VoidCallback bioSuccsess,
    required VoidCallback bioDontNow,
  }) async {
    
    LocalAuthentication auth = await LocalAuthentication();
    availableBiometrics = await auth.getAvailableBiometrics();
    GetStorageService.instance.box
        .read(GetStorageService.instance.hasFaceTouch);
     if(Platform.isIOS && availableBiometrics!.contains(BiometricType.face)){
bioSupport(
              context: context,
              bioSuccsess: bioSuccsess,
              bioDontNow: bioDontNow);
     } else{
       if (availableBiometrics!.isNotEmpty) {
      GetStorageService.instance.box
                  .read(GetStorageService.instance.hasFaceTouch) ==
              null
          ? FaceIDBottomsheet.show(
              context: context,
              onTapTop: () async {
                
                await bioSupport(
                    bioDontNow: bioDontNow,
                    bioSuccsess: bioSuccsess,
                    context: context);
              },
              onTapTopBottom: bioDontNow)
          : bioSupport(
              context: context,
              bioSuccsess: bioSuccsess,
              bioDontNow: bioDontNow);
    } else {
      
      
      await MobileErrorAlert.instance.mobileErrorAlert(1, context);
    }
     }  
   
  }

  bioSupport({
    required BuildContext context,
    required VoidCallback bioSuccsess,
    required VoidCallback bioDontNow,
    bool alert = false,
  }) async {
    
    LocalAuthentication auth1 = await LocalAuthentication();
    availableBiometrics = await auth1.getAvailableBiometrics();
    
    try {
      canCheckBiometrics = await auth1.canCheckBiometrics;
      isDeviceSupported = await auth1.isDeviceSupported();
    } on PlatformException catch (e) {
      
      canCheckBiometrics = false;
      isDeviceSupported = false;
      if (kDebugMode) {
        
      }
    }
    if (isDeviceSupported && canCheckBiometrics) {
      try {
        Provider.of<CheckPinCodeProvider>(context, listen: false).isBiometric =
            true;
        didAuthenticate = await auth1.authenticate(
            localizedReason:
                ' ',
            options: AuthenticationOptions(
                
                useErrorDialogs: alert,
                biometricOnly: true,
                sensitiveTransaction: false,
                stickyAuth: true),
            authMessages: authMessages);
      } on PlatformException catch (e) {
        
        if (e.code == auth_error.notAvailable) {
          
        } else if (e.code == auth_error.notEnrolled) {
          return MobileErrorAlert.instance.mobileErrorAlert(
            1,
            context,
            onTap: () {
              
              GetStorageService.instance.box
                  .write(GetStorageService.instance.hasFaceTouch, "false");
              Navigator.pop(context);
            },
          );
        } else {
          }
      }
    } else {
      didAuthenticate = false;
    }
    if (didAuthenticate) {
      
      // GetStorageService.instance.box
      //     .write(GetStorageService.instance.hasFaceTouch, "true");
      bioSuccsess();
    } else {
      
    }
  }

  // Future bioAlert(
  //   BuildContext context,
  //   VoidCallback bioSuccsess,
  //   VoidCallback dontNow,
  // ) {
  //   return showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Container(
  //           child: Center(
  //             child: Container(
  //               padding: EdgeInsets.symmetric(horizontal: 10.h),
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(20),
  //                 color: Colors.white,
  //               ),
  //               height: 250.h,
  //               width: 250.w,
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   SizedBox(
  //                     height: 40.h,
  //                     width: double.infinity,
  //                   ),
  //                   DefaultTextStyle(
  //                     style: TextStyle(
  //                         fontSize: FontSizeConst.instance.maptext,
  //                         color: Colors.black),
  //                     child: Text(
  //                       "access_face_touch_app".locale,
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: 10.h,
  //                   ),
  //                   TextButton(
  //                     onPressed: dontNow,
  //                     child: DefaultTextStyle(
  //                       style: TextStyle(
  //                           fontSize: FontSizeConst.instance.maptext,
  //                           color: Colors.blue),
  //                       child: Text(
  //                         "dont_now".locale,
  //                         textAlign: TextAlign.center,
  //                       ),
  //                     ),
  //                   ),
  //                   Divider(
  //                     color: Colors.black45,
  //                   ),
  //                   TextButton(
  //                     onPressed: bioSuccsess,
  //                     child: DefaultTextStyle(
  //                       style: TextStyle(
  //                           fontSize: FontSizeConst.instance.maptext,
  //                           color: Colors.blue),
  //                       child: Text(
  //                         "yes".locale,
  //                         textAlign: TextAlign.center,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       });
 // }

  Future onFaceAndTouch(BuildContext context) async {
    LocalAuthentication auth = await LocalAuthentication();
    availableBiometrics = await auth.getAvailableBiometrics();
    if (availableBiometrics!.isNotEmpty) {
      GetStorageService.instance.box
          .write(GetStorageService.instance.hasFaceTouch, "true");
    } else {
      return MobileErrorAlert.instance.mobileErrorAlert(
        1,
        context,
        onTap: () {
          
          GetStorageService.instance.box
              .write(GetStorageService.instance.hasFaceTouch, "false");
          Navigator.pop(context);
        },
      );
    }
  }

  Future controlCheckBox() async {
    
    LocalAuthentication auth = await LocalAuthentication();
    availableBiometrics = await auth.getAvailableBiometrics();
    
    if (availableBiometrics!.isNotEmpty) {
      
      GetStorageService.instance.box
          .write(GetStorageService.instance.hasFaceTouch, "true");
    } else {
      GetStorageService.instance.box
          .write(GetStorageService.instance.hasFaceTouch, "false");
    }
  }

  FaceAndTouchIDService._init();
}
