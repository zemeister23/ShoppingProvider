// import 'package:firebase_performance/firebase_performance.dart';
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

class AfterProfilePassCodeAuthScreen extends StatefulWidget {
  bool? isPop = false;
  AfterProfilePassCodeAuthScreen({Key? key, this.isPop = false}) : super(key: key);
  @override
  State<AfterProfilePassCodeAuthScreen> createState() => _PassCodeAuthScreenState();
}

class _PassCodeAuthScreenState extends BaseState<AfterProfilePassCodeAuthScreen> {
  @override
//   late final INetworkChangeManager _networkChange;
  void initState() {
    MinVersionService.instance.checkVersion(context);
    super.initState();
  
//  _networkChange = NetworkChangeManager();

    Provider.of<CheckPassCodeProvider>(context, listen: false).init();
  }

//   late LockProvider lockProvider;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   lockProvider = Provider.of<LockProvider>(context, listen: false);
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   lockProvider.initializeTimer();
  // }
  @override
  Widget build(BuildContext context) {
    var myProvider = context.watch<CheckPassCodeProvider>();
  
    return SwipeInGoBack(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          body:  SafeArea(
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
                          padding: EdgeInsets.symmetric(
                              horizontal: context.w * 0.09),
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
                                    onCompleted: () async{
                                      
                                        await GetStorageService.instance.box.write(
                                GetStorageService.instance.hasFaceTouch,
                                "true");
                                     
                                      NavigationService.instance.pushNamedRemoveUntil(routeName: NavigationConst.PROFILE_PAGE_VIEW);
                                    },
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
                )
              ),
      onWillPop: () async => false,
    );
  }
  labelText(CheckPassCodeProvider myProvider) {
    return myProvider.capacity < 5
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
