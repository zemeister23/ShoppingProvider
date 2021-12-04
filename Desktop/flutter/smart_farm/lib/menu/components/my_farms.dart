import 'package:flutter/material.dart';
import 'package:smart_farm/constants.dart';

import '../../size_config.dart';

class MyFarms extends StatelessWidget {
  const MyFarms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(14.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Fermalar",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: getProportionateScreenHeight(14.0)),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                    color: kPrimaryBackgroundColor,
                    image: const DecorationImage(
                      image: AssetImage("assets/images/ina_ferma.png"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  height: getProportionateScreenHeight(120.0),
                  child: const Text(
                    "Ina ferma",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                flex: 14,
              ),
              const Spacer(flex: 1),
              Expanded(
                child: Container(
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: kPrimaryBackgroundColor,
                    image: const DecorationImage(
                      image: AssetImage("assets/images/sigir_ferma.png"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  height: getProportionateScreenHeight(120.0),
                  child: const Text(
                    "Sigir ferma",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white54,
                    ),
                  ),
                ),
                flex: 14,
              ),
            ],
          )
        ],
      ),
    );
  }
}
