import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/size_config.dart';

import '../constants.dart';

class CurrentNews extends StatelessWidget {
  final dynamic onTap;
  final bool isColor;
  const CurrentNews({Key? key, required this.onTap, required this.isColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) {
          return Obx(
            () => AnimatedContainer(
              curve: Curves.easeInQuint,
              margin: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(3.0),
                  vertical: getProportionateScreenHeight(6.0)),
              duration: const Duration(milliseconds: 200),
              height: getProportionateScreenHeight(6.0),
              width: onTap.newsCurrentIndex.value == index
                  ? getProportionateScreenWidth(20.0)
                  : getProportionateScreenWidth(6.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(38.0),
                color: isColor ? onTap.newsCurrentIndex.value == index
                    ? kPrimaryBorderColor
                    : kPrimaryLightColor : kPrimaryBackgroundColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
