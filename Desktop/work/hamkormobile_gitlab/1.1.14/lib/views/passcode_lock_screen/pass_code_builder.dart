import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/provider/lock_timer_provider.dart';
import 'package:provider/provider.dart';

import '../../core/constants/images/image_const.dart';
import '../../provider/check_pass_code_provider.dart';
import '../../widgets/number_button.dart';
import '../../widgets/pin_point.dart';

class PassCodeBuilder extends StatefulWidget {
  const PassCodeBuilder({Key? key}) : super(key: key);

  @override
  State<PassCodeBuilder> createState() => _PassCodeBuilderState();
}

class _PassCodeBuilderState extends State<PassCodeBuilder> {
  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: Duration(milliseconds: 500),
      crossFadeState: (GetStorageService.instance.box
                      .read(GetStorageService.instance.isLockScreenShowed) ??
                  false) &&
              (GetStorageService.instance.box
                      .read(GetStorageService.instance.isLocked) ??
                  false)
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      firstChild: SafeArea(
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
                          context.watch<CheckPassCodeProvider>().pinList,
                          context.watch<CheckPassCodeProvider>().list,
                          context.watch<CheckPassCodeProvider>().pinCode,
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
                            isPop: true,
                          ),
                        )),
                    SizedBox(
                      height: context.h * 0.01,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      secondChild: SizedBox(),
    );
  }
}
