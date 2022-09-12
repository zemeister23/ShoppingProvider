import 'package:flutter/material.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/sizeconst/size_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/provider/6_check_pin_code_provider.dart';
import 'package:mobile/provider/check_pass_code_provider.dart';
import 'package:provider/provider.dart';

class PinPontData extends StatelessWidget {
  final int index;
  final bool state;
  final bool colorState;
  final List<dynamic> number;
  final bool checkPinCodePage;
  final bool isLockScreenPage;

  const PinPontData(this.index, this.state, this.colorState, this.number,
      this.checkPinCodePage, this.isLockScreenPage,
      {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.w * 0.07,
      height: context.h * 0.033,
      child: state
          ? Center(
              child: Container(
                height: SizeConst.instance.pinPointH,
                width: SizeConst.instance.pinPointH,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: color(context, checkPinCodePage),
                  shape: BoxShape.circle,
                ),
              ),
            )
          : Container(
              padding: EdgeInsets.only(bottom: 0),
              child: Text(
                number[index].toString(),
                style: context.theme.headline5,
                textAlign: TextAlign.center,
              ),
            ),
    );
  }

  Color color(BuildContext context, bool checkPinCodePage) {
    if (checkPinCodePage) {
      if (context.watch<CheckPinCodeProvider>().pinErorColor) {
        return colorState
            ? ColorConst.instance.kErrorColor
            : ColorConst.instance.kBacColor;
      } else {
        return colorState
            ? context.watch<CheckPassCodeProvider>().isGreen
            : ColorConst.instance.kBacColor;
      }
    } else if (isLockScreenPage) {
      if (context.watch<CheckPassCodeProvider>().pinErorColor) {
        return colorState
            ? ColorConst.instance.kErrorColor
            : ColorConst.instance.kBacColor;
      } else {
        return colorState
            ? ColorConst.instance.kPrimaryColor
            : ColorConst.instance.kBacColor;
      }
    } else {
      return colorState
          ? ColorConst.instance.kPrimaryColor
          : ColorConst.instance.kBacColor;
    }
  }
}
