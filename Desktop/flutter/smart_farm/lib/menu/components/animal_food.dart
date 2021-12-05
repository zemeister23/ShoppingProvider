import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:smart_farm/menu/components/first_image.dart';
import 'package:smart_farm/service/backend_service.dart';
import 'package:smart_farm/widgets/my_bottomsheep.dart';

import '../../constants.dart';
import '../../size_config.dart';

class AnimalFoods extends StatefulWidget {
  String? imgUrl;
  String? count;
  String? food_percent;

  AnimalFoods({Key? key, this.imgUrl, this.count, this.food_percent})
      : super(key: key);

  @override
  State<AnimalFoods> createState() => _AnimalFoodsState();
}

class _AnimalFoodsState extends State<AnimalFoods> {
  int? balance;

  @override
  void initState() {
    super.initState();
    BackendService()
        .getMyAnimals()
        .then((value) => balance = value[0]['balance']);
  }

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
              imageUrl: ipAdress + widget.imgUrl!,
              count: widget.count,
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
                      height: Get.height * 0.18,
                      alignment: Alignment.center,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenHeight(6.0)),
                      child: LiquidLinearProgressIndicator(
                        value: double.parse(widget.food_percent!) *
                            0.01, // Defaults to 0.5.
                        valueColor: const AlwaysStoppedAnimation(
                            kPrimaryColor), // Defaults to the current Theme's accentColor.
                        backgroundColor: Colors
                            .white, // Defaults to the current Theme's backgroundColor.
                        borderColor: kPrimaryColor,
                        borderWidth: 1.0,
                        borderRadius: 10.0,
                        direction: Axis
                            .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
                        center: Text(
                          "${widget.food_percent} %\nYegulik",
                          textAlign: TextAlign.center,
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
                    balance: balance.toString(),
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
