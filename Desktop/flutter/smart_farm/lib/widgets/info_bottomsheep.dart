import 'package:flutter/material.dart';
import 'package:smart_farm/constants.dart';
import 'package:smart_farm/widgets/title_info_bottom.dart';

import '../size_config.dart';

class InfoBottomSheep extends StatelessWidget {
  final Map<String, String>? infoFarm;
  final String? phoneNumber;
  const InfoBottomSheep({Key? key, this.infoFarm, this.phoneNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(10.0),
      ),
      child: Container(
        color: Colors.white,
        height: getProportionateScreenHeight(345.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: getProportionateScreenHeight(8.0)),
                height: getProportionateScreenHeight(4.0),
                width: getProportionateScreenWidth(25.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28.0),
                  color: kPrimaryLightColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(16.0),
                vertical: getProportionateScreenHeight(12.0),
              ),
              child: Text(
                infoFarm!["farm"]!,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24.0,
                ),
              ),
            ),
            const Divider(color: kPrimaryBorderColor, height: 0.0),
            ...titleInfoBottom(
                "Telefon raqami:", infoFarm!["phonenumber"]!, true),
            ...titleInfoBottom("Manzil:", infoFarm!["address"]!, true),
            ...titleInfoBottom("Izoh", infoFarm!["comment"]!, false)
          ],
        ),
      ),
    );
  }
}
