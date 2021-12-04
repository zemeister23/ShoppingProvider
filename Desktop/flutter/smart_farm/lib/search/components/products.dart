import 'package:flutter/material.dart';
import 'package:smart_farm/constants.dart';
import 'package:smart_farm/size_config.dart';

class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        height: getProportionateScreenHeight(100.0),
        width: getProportionateScreenHeight(140.0),
        margin: EdgeInsets.only(right: getProportionateScreenWidth(10.0)),
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage("assets/images/tuxum.png"),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10.0),
          color: kPrimaryBackgroundColor,
        ),
        alignment: Alignment.bottomRight,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.black38,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(58.0),
              topLeft: Radius.circular(58.0),
              bottomRight: Radius.circular(58.0),
            ),
          ),
          padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(4.0),
            horizontal: getProportionateScreenWidth(18.0),
          ),
          child: const Text(
            "Tuxum",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14.0,
            ),
          ),
        ),
      ),
    );
  }
}
