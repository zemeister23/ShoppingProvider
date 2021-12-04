import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smart_farm/size_config.dart';

class BlurTitle extends StatelessWidget {
  final Widget child;
  const BlurTitle({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          color: Colors.white10,
          child: child
        ),
      ),
    );
  }
}
