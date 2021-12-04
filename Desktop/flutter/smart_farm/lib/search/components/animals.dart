import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/constants.dart';
import 'package:smart_farm/search/pages/type_of_animals.dart';
import 'package:smart_farm/size_config.dart';

class Animals extends StatelessWidget {
  final String title;
  const Animals({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: getProportionateScreenHeight(85.0),
        width: getProportionateScreenHeight(85.0),
        margin: EdgeInsets.only(right: getProportionateScreenWidth(12.0)),
        decoration: BoxDecoration(
          color: kRandomColors[Random().nextInt(kRandomColors.length)],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: getProportionateScreenWidth(12.0),
                  top: getProportionateScreenHeight(12.0)),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: getProportionateScreenHeight(40.0),
                width: getProportionateScreenHeight(40.0),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/tovuq.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Get.to(TypeOfAnimals(title: title), transition: Transition.cupertino);
      },
    );
  }
}
