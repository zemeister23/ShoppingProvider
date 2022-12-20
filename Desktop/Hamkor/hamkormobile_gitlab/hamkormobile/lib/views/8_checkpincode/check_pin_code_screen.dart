import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mobile/core/constants/navigation/navigation_constant.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/service/api_service/face_id_touch_id_service/face_id_touch_id_service.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:mobile/core/base/state/base_state.dart';
import 'package:mobile/core/base/view/base_view.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/sizeconst/size_const.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/provider/6_check_pin_code_provider.dart';
import 'package:mobile/widgets/appbar/default_appbar.dart';
import 'package:mobile/widgets/number_button.dart';
import 'package:mobile/widgets/pin_point.dart';
import 'package:provider/provider.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';

class CheckPinCodeScreen extends StatefulWidget {
  const CheckPinCodeScreen({Key? key}) : super(key: key);
  @override
  State<CheckPinCodeScreen> createState() => _CheckPinCodeScreenState();
}

class _CheckPinCodeScreenState extends BaseState<CheckPinCodeScreen>
    with WidgetsBindingObserver {
      late LocalAuthentication auth ;
  @override
  void initState() {
    auth = LocalAuthentication();
    context.checkPinProvider.isNavigateSettings = false;
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  
    Provider.of<CheckPinCodeProvider>(context, listen: false).init();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    context.checkPinProvider.isNavigateSettings = true;
    

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    
    if (state == AppLifecycleState.resumed) {
      Provider.of<CheckPinCodeProvider>(context, listen: false).isBiometric
          ? FaceAndTouchIDService.instance.bioSupport(
              context: context,
              bioSuccsess: () {
                GetStorageService.instance.box
                    .write(GetStorageService.instance.hasFaceTouch, "true");
                NavigationService.instance.pushNamedRemoveUntil(
                    routeName: NavigationConst.RAZVILKA_PAGE_VIEW);
              },
              bioDontNow: () {
                GetStorageService.instance.box
                    .write(GetStorageService.instance.hasFaceTouch, "false");
                NavigationService.instance.pushNamedRemoveUntil(
                    routeName: NavigationConst.RAZVILKA_PAGE_VIEW);
              },
            
            )
          : null;
  
    }
    super.didChangeAppLifecycleState(state);
  }
 
 
 
  @override
  Widget build(BuildContext context) {
    CheckPinCodeProvider _myProvider = context.watch<CheckPinCodeProvider>();
    return BaseView(
      viewModal: CheckPinCodeScreen,
      onPageBuilder: (BuildContext context, value) {
        return SwipeInGoBack(
            child: Scaffold(
              appBar: DefaultAppbar.getAppBar(
                  "pin_code_installation".locale, null, context, false),
              resizeToAvoidBottomInset: false,
              extendBodyBehindAppBar: true,
              body: SafeArea(
                child: Column(children: [
                  Expanded(
                    flex: 9,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: context.w * 0.09),
                      child: Column(
                        children: [
                          Expanded(
                            child: Center(child: labelText(_myProvider)),
                          ),
                          Expanded(
                            child: Center(
                              child: PinPoint(
                                _myProvider.pinList,
                                _myProvider.list,
                                _myProvider.pinCode,
                                true,
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 6,
                              child: Center(
                                child: NumButton(
                                  pageState: false,
                                  isCheckPassCode: true,
                                ),
                              )),
                          Expanded(flex: 1, child: Container()),
                          SizedBox(height: SizeConst.instance.minSize),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            onWillPop: () async => false);
      },
    );
  }

  labelText(CheckPinCodeProvider _myProvider) {
    return _myProvider.capacity < 3
        ? Column(
            children: [
              Text(
                "code_doesn't"
                    .locale
                    .replaceAll("ATTEMPT", _myProvider.capacity.toString()),
                style: TextStyle(
                  color: ColorConst.instance.kErrorColor,
                  fontWeight: FontWeight.w600,
                  fontSize: FontSizeConst.instance.medium,
                ),
              ),
              Text(
                "1_try_left"
                    .locale
                    .replaceAll("ATTEMPT", _myProvider.capacity.toString()),
                style: TextStyle(
                  color: ColorConst.instance.kErrorColor,
                  fontWeight: FontWeight.w600,
                  fontSize: FontSizeConst.instance.medium,
                ),
              )
            ],
          )
        : Text(
            "confirm_pin".locale,
            style: context.theme.subtitle2,
            textAlign: TextAlign.center,
          );
  }

  // deviceSupported() async {
  //   final LocalAuthentication auth = await LocalAuthentication();
  //   bool isDeviceSupported = await auth.isDeviceSupported();
  //   GetStorageService.instance.box.write(
  //       GetStorageService.instance.isDeviceSupported,
  //       isDeviceSupported.toString());

  //   print(GetStorageService.instance.box
  //       .read(GetStorageService.instance.isDeviceSupported));
  // }



}
