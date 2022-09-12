import 'package:flutter/material.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/init/cache/get_storege.dart';

import '../../core/network/dio/endpoints.dart';

class DefaultAppbar {
  static getAppBar(
    String? title,
    VoidCallback? onPress,
    BuildContext context,
    bool icon,
  ) {
    return AppBar(
      leading: icon
          ? IconButton(
              onPressed: onPress ??
                  () {
                    Navigator.pop(context);
                  },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
              ),
            )
          : const SizedBox(),
      centerTitle: true,
      title: Text(
        title ?? "",
        style: Theme.of(context).textTheme.caption,
      ),
      iconTheme: IconThemeData(
        color: ColorConst.instance.kMainTextColor,
      ),
      elevation: 0,
      actions: Endpoints.isVersionEnable ? [versionText()] : null,
    );
  }

  static Text versionText() {
    // ! VERSIONN
    return Text(
      GetStorageService.instance.box.read(
                GetStorageService.instance.version,
              ) +
              Endpoints.status ??
          "?.?.?",
    );
  }
}
