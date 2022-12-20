import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/views/passcode_lock_screen/pass_code_builder.dart';

import '../../../models/min_version_model.dart';
import '../../../service/version_control/min_version_service.dart';
import '../../../views/internet_error/internet_error_screen.dart';
import '../../constants/error/alert_error.dart';

class MainBuild {
  MainBuild._();
  static Widget build(BuildContext context, Widget? child) {
    // Navigator.of(context,rootNavigator: );
    final MediaQueryData data = MediaQuery.of(context);
    return MediaQuery(
        data: data.copyWith(textScaleFactor: 1),
        child: NoNetworkWidget(
          child: child,
        ));

  }
}
