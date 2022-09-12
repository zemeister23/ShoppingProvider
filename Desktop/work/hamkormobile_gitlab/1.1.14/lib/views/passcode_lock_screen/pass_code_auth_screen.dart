import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile/core/base/state/base_state.dart';
import 'package:mobile/core/constants/images/image_const.dart';
import 'package:mobile/provider/check_pass_code_provider.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/service/firebase/performance/performance_service.dart';
import 'package:mobile/service/version_control/min_version_service.dart';
import 'package:mobile/widgets/number_button.dart';
import 'package:mobile/widgets/pin_point.dart';
import 'package:provider/provider.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import '../../provider/lock_timer_provider.dart';

class PassCodeAuthScreen extends StatefulWidget {
  bool? isPop = false;
  PassCodeAuthScreen({Key? key, this.isPop = false}) : super(key: key);
  @override
  State<PassCodeAuthScreen> createState() => _PassCodeAuthScreenState();
}

class _PassCodeAuthScreenState extends BaseState<PassCodeAuthScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CheckPassCodeProvider>(context, listen: false).init();
  }

  late LockProvider lockProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lockProvider = Provider.of<LockProvider>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();
    lockProvider.initializeTimer();
  }

  @override
  Widget build(BuildContext context) {
    var myProvider = context.watch<CheckPassCodeProvider>();
    var myProvider2 =
        Provider.of<CheckPassCodeProvider>(context, listen: false);
    MinVersionService.instance.checkVersion(context);
    return WillPopScope(
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
        ),
      ),
      onWillPop: () async => false,
    );
  }
}
