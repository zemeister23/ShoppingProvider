import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:mobile/core/extensions/context_extension.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  ThemeData get themeData => Theme.of(context);

  double contextHeight(double value) => context.h * value;
  double contextWidth(double value) => context.w * value;
}
