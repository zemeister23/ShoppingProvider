import 'dart:ui';

import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../size_config.dart';

class FirstImage extends StatelessWidget {
  final BorderRadius? radius;
  final Alignment myAlignment;
  const FirstImage({
    Key? key,
    this.radius,
    required this.myAlignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(12.0),
        vertical: getProportionateScreenHeight(12.0),
      ),
      alignment: myAlignment,
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: radius,
        image: const DecorationImage(
          image: AssetImage("assets/images/Rectangle1522.png"),
          fit: BoxFit.cover,
        ),
      ),
      height: getProportionateScreenHeight(190.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            color: Colors.white12,
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(16.0),
              vertical: getProportionateScreenHeight(8.0),
            ),
            child: Text(
              "5 dona",
              style: TextStyle(
                fontSize: getProportionateScreenHeight(12.0),
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
