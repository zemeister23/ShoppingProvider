import 'package:flutter/material.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/provider/5_pin-code_auth_provider.dart';
import 'package:mobile/provider/check_pass_code_provider.dart';
import 'package:mobile/widgets/pin_point_data.dart';
import 'package:provider/provider.dart';

class PinPoint extends StatelessWidget {
  final List<dynamic> state;
  final List<dynamic> colorState;
  final List<dynamic> number;
  final bool checkPinCodePage;
  final bool isLockScreenPage;
  const PinPoint(
      this.state, this.colorState, this.number, this.checkPinCodePage,
      {Key? key, this.isLockScreenPage = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    int length;

    if (isLockScreenPage)
      length = context.watch<CheckPassCodeProvider>().pinCode.length;
    else
      length = context.watch<PinCodeAuthProvider>().pinCode.length;
    if (isLockScreenPage) {
      String storegePasCode = "";

      List listCode = GetStorageService.instance.box.read("passcode");
      for (var i = 0; i < listCode.length; i++) {
        storegePasCode += listCode[i].toString();
      }

      return SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PinPontData(0, state[0], colorState[0], number, checkPinCodePage,
                isLockScreenPage),
            PinPontData(1, state[1], colorState[1], number, checkPinCodePage,
                isLockScreenPage),
            PinPontData(2, state[2], colorState[2], number, checkPinCodePage,
                isLockScreenPage),
            PinPontData(3, state[3], colorState[3], number, checkPinCodePage,
                isLockScreenPage),
            storegePasCode.length > 4
                ? PinPontData(4, state[4], colorState[4], number,
                    checkPinCodePage, isLockScreenPage)
                : Container(),
            storegePasCode.length > 5
                ? PinPontData(5, state[5], colorState[5], number,
                    checkPinCodePage, isLockScreenPage)
                : Container(),
            storegePasCode.length > 6
                ? PinPontData(6, state[6], colorState[6], number,
                    checkPinCodePage, isLockScreenPage)
                : Container(),
            storegePasCode.length > 7
                ? PinPontData(7, state[7], colorState[7], number,
                    checkPinCodePage, isLockScreenPage)
                : Container(),
          ],
        ),
      );
    }
    if (!checkPinCodePage) {
      return SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PinPontData(0, state[0], colorState[0], number, checkPinCodePage,
                isLockScreenPage),
            PinPontData(1, state[1], colorState[1], number, checkPinCodePage,
                isLockScreenPage),
            PinPontData(2, state[2], colorState[2], number, checkPinCodePage,
                isLockScreenPage),
            PinPontData(3, state[3], colorState[3], number, checkPinCodePage,
                isLockScreenPage),
            number.length > 4
                ? PinPontData(4, state[4], colorState[4], number,
                    checkPinCodePage, isLockScreenPage)
                : Container(),
            number.length > 5
                ? PinPontData(5, state[5], colorState[5], number,
                    checkPinCodePage, isLockScreenPage)
                : Container(),
            number.length > 6
                ? PinPontData(6, state[6], colorState[6], number,
                    checkPinCodePage, isLockScreenPage)
                : Container(),
            number.length > 7
                ? PinPontData(7, state[7], colorState[7], number,
                    checkPinCodePage, isLockScreenPage)
                : Container(),
          ],
        ),
      );
    } else {
      return SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PinPontData(0, state[0], colorState[0], number, checkPinCodePage,
                isLockScreenPage),
            PinPontData(1, state[1], colorState[1], number, checkPinCodePage,
                isLockScreenPage),
            PinPontData(2, state[2], colorState[2], number, checkPinCodePage,
                isLockScreenPage),
            PinPontData(3, state[3], colorState[3], number, checkPinCodePage,
                isLockScreenPage),
            4 < length
                ? PinPontData(4, state[4], colorState[4], number,
                    checkPinCodePage, isLockScreenPage)
                : Container(),
            5 < length
                ? PinPontData(5, state[5], colorState[5], number,
                    checkPinCodePage, isLockScreenPage)
                : Container(),
            6 < length
                ? PinPontData(6, state[6], colorState[6], number,
                    checkPinCodePage, isLockScreenPage)
                : Container(),
            7 < length
                ? PinPontData(7, state[7], colorState[7], number,
                    checkPinCodePage, isLockScreenPage)
                : Container(),
          ],
        ),
      );
    }
  }
}
