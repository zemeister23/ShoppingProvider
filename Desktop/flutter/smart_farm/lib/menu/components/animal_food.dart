import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/menu/components/first_image.dart';
import 'package:smart_farm/widgets/my_bottomsheep.dart';

import '../../constants.dart';
import '../../size_config.dart';

class AnimalFoods extends StatelessWidget {
  const AnimalFoods({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(14.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: FirstImage(
              myAlignment: Alignment.bottomLeft,
              radius: BorderRadius.circular(10.0),
            ),
            flex: 14,
          ),
          const Spacer(flex: 1),
          Expanded(
            child: GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(8.0),
                  vertical: getProportionateScreenHeight(8.0),
                ),
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: kPrimaryBorderColor),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                height: getProportionateScreenHeight(190.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.asset("assets/images/sesame1.png"),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenHeight(6.0)),
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 1.0, color: kPrimaryDarkColor),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        "12%",
                        style: TextStyle(
                          fontSize: getProportionateScreenHeight(16.0),
                          color: kPrimaryDarkColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {
                Get.bottomSheet(
                  MyBottomSheep(
                    myImage: const AssetImage("assets/images/animalsfood.png"),
                    productName: "Makkajo'xori",
                    productMoney: 12000,
                    isIncrement: true,
                  ),
                );
              },
            ),
            flex: 6,
          ),
        ],
      ),
    );
  }
}
