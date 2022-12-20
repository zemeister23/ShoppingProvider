import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/navigation/navigation_constant.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/service/api_service/face_id_touch_id_service/face_id_touch_id_service.dart';
import 'package:mobile/views/biometric/after_home_page_biometric/after_home_page_biometry_screen_first.dart';
import 'package:mobile/widgets/bottomSheet/face_id_bottomsheet.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile/core/base/state/base_state.dart';
import 'package:mobile/core/constants/images/image_const.dart';
import 'package:mobile/core/init/internet/networ_change_manager.dart';
import 'package:mobile/provider/check_pass_code_provider.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/service/version_control/min_version_service.dart';
import 'package:mobile/views/internet_error/internet_error_screen.dart';
import 'package:mobile/widgets/number_button.dart';
import 'package:mobile/widgets/pin_point.dart';
import 'package:provider/provider.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import '../../provider/lock_timer_provider.dart';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/navigation/navigation_constant.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/provider/6_check_pin_code_provider.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:provider/provider.dart';

class PassCodeAuthScreen extends StatefulWidget {
  bool? isPop = false;
  PassCodeAuthScreen({Key? key, this.isPop = false}) : super(key: key);
  @override
  State<PassCodeAuthScreen> createState() => _PassCodeAuthScreenState();
}

class _PassCodeAuthScreenState extends State<PassCodeAuthScreen> {
  @override
  void initState() {
    super.initState();
    
        MinVersionService.instance.checkVersion(context);
    Provider.of<CheckPassCodeProvider>(context, listen: false).init();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await init();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var myProvider = context.watch<CheckPassCodeProvider>();
     
    return SwipeInGoBack(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: SvgPicture.asset(
                      ImageConst.instance.miniLogo,
                      height: 30.h,
                    ),
                  ),
                ),
                Expanded(flex: 1, child: labelText(myProvider)),
                Expanded(
                  flex: 9,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: context.w * 0.09),
                    child: Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              "confirm_pincode".locale,
                              style: context.theme.subtitle2,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: PinPoint(
                              myProvider.pinList,
                              myProvider.list,
                              myProvider.pinCode,
                              false,
                              isLockScreenPage: true,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Center(
                            child: NumButton(
                              pageState: true,
                              isLockScreen: true,
                              isPop: widget.isPop ?? false,
                            ),
                          ),
                        ),
                        SizedBox(height: context.h * 0.01),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
      onWillPop: () async => false,
    );
  }

  List<AuthMessages> authMessages = const <AuthMessages>[
    AndroidAuthMessages(
      signInTitle: 'Вход в Hamkor',
      cancelButton: 'Отмена',
    ),
    IOSAuthMessages(
      cancelButton: 'Вход в Hamkor',
    ),
  ];

  init() async {
    // print(GetStorageService.instance.box
    //     .read(GetStorageService.instance.hasFaceTouch));
    if ((GetStorageService.instance.box
            .read(GetStorageService.instance.hasFaceTouch) ==
        null)) {
      await FaceAndTouchIDService.instance.Face_ID_and_Touch_ID(context,
          bioSuccsess: () => bioSuccsess(), bioDontNow: () => bioDontNow());
    } else {
      if (GetStorageService.instance.box
              .read(GetStorageService.instance.hasFaceTouch) ==
          "true") {
        await FaceAndTouchIDService.instance.Face_ID_and_Touch_ID(
          context,
          bioSuccsess: () {
            bioSuccsess();
          },
          bioDontNow: () {
            Navigator.pop(context);
          },
        );
        ;
      }
    }
  }

  void bioDontNow() async {
    await GetStorageService.instance.box
        .write(GetStorageService.instance.hasFaceTouch, "false");
  }

  void bioSuccsess() async {
    await GetStorageService.instance.box
        .write(GetStorageService.instance.capacity, "5");
    await GetStorageService.instance.box
        .write(GetStorageService.instance.isLocked, false);
    await GetStorageService.instance.box
        .write(GetStorageService.instance.hasFaceTouch, "true");
    // print(GetStorageService.instance.box
    //     .read(GetStorageService.instance.hasFaceTouch));
    context.passCodePr.capacity = 5;
    context.passCodePr.pinErorColor = false;
    if (widget.isPop!) {
      Navigator.pop(context);
    } else {
      NavigationService.instance
          .pushNamed(routeName: NavigationConst.HOME_PAGE_VIEW, data: true);
    }
  }

  labelText(CheckPassCodeProvider myProvider) {
    return myProvider.capacity < 5 && myProvider.isErrorTextCapasity
        ? Column(
            children: [
              Text(
                "pin_incorrect".locale,
                style: TextStyle(
                  color: ColorConst.instance.kErrorColor,
                  fontWeight: FontWeight.w600,
                  fontSize: FontSizeConst.instance.medium,
                ),
              ),
              Text(
                "have_attempts"
                    .locale
                    .replaceAll("NUMBER", myProvider.capacity.toString()),
                style: TextStyle(
                  color: ColorConst.instance.kErrorColor,
                  fontWeight: FontWeight.w600,
                  fontSize: FontSizeConst.instance.medium,
                ),
              )
            ],
          )
        : SizedBox();
  }
}
