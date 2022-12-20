import 'dart:async';
import 'package:flutter/material.dart';
import '../core/constants/navigation/navigation_constant.dart';
import '../core/init/cache/get_storege.dart';
import '../routes/router/router.dart';

class LockProvider extends ChangeNotifier {
  Timer? timer;
  BuildContext context;
  LockProvider(this.context);
  Future<void> initializeTimer() async {
    if (GetStorageService.instance.box
            .read(GetStorageService.instance.isLockScreenShowed) ??
        false) {
      if (timer != null) {
        timer!.cancel();
      }
      timer = Timer(const Duration(seconds: 40), logOutUser);
    }
  }

  void logOutUser() async {
    timer?.cancel();
    timer = null;
    if (GetStorageService.instance.box
            .read(GetStorageService.instance.isLockScreenShowed) ??
        false) {
      await GetStorageService.instance.box
          .write(GetStorageService.instance.isLocked, true)
          .then((value) async {
        NavigationService.instance.pushNamed(
          routeName: NavigationConst.PASS_CODE_VIEW,
          data: true,
        );
      });
    }
  }
}
