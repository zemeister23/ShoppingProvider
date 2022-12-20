import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SwipeInGoBack extends StatelessWidget {
  final Future<bool> Function() onWillPop;
  final Widget child;
  SwipeInGoBack({super.key, required this.onWillPop, required this.child});

  @override
  Widget build(BuildContext context) {
     return WillPopScope(child: child, onWillPop: onWillPop);
    if (Platform.isAndroid) {
      return WillPopScope(child: child, onWillPop: onWillPop);
    }
    return GestureDetector(
      onHorizontalDragUpdate: (details) async {
        //set the sensitivity for your ios gesture anywhere between 10-50 is good
        
        

        double sensitivity = 10.w;
        double widthofSwipe = 130.w;
        // Integers().iosSwipeSensitivity;

        if (details.delta.dx > sensitivity &&
            widthofSwipe > details.globalPosition.dx) {
          await onWillPop();
        }
      },
      child: child,
    );
  }
}
