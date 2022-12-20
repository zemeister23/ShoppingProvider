import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/core/constants/images/image_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';

class LoadingPage extends StatelessWidget {
  final bool margin;
  LoadingPage(this.margin, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.h,
      width: context.w,
       
      margin: EdgeInsets.only(bottom: margin ? context.h * 0.09 : 0),
      child: Center(
        child: Lottie.asset(
          ImageConst.instance.loading,
          fit: BoxFit.cover,
          height: context.h * 0.15,
          width: context.w * 0.5,
        ),
      ),
    );
  }
}
