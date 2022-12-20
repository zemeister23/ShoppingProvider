import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';

class DecoInput {
  static DecoInput? _instance;
  static DecoInput get instance => const DecoInput._init();

  focusedBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: color,
      ),
      borderRadius: BorderRadius.circular(10),
    );
  }

  outlineBorder(double radius) {
    return OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(radius),
    );
  }

  focusedErorBorder(double radius, Color color) async {
    OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: color),
    );
  }

  enabledBOrder(double radius) {
    return OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(radius),
    );
  }

  const DecoInput._init();
}
