import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/core/components/loading/loading_page.dart';
import 'package:mobile/core/constants/images/image_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';

class LoadingDialog {
  static final LoadingDialog _instance = LoadingDialog._init();
  static LoadingDialog get instance => _instance;
  LoadingDialog._init();
  loading() => Center(
        child: Lottie.asset(
          ImageConst.instance.loading,
          fit: BoxFit.cover,
          height: 100.h,
          width: 150.w,
        ),
      );
}
