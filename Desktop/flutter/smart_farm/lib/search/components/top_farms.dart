import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/getX/select_animals.dart';

import '../../constants.dart';
import '../../size_config.dart';

class TopFarms extends StatelessWidget {
  String? name;
  String? description;
  String? countUser;
  String? age;
  String? imageUrl;

  TopFarms(
      {Key? key,
      this.name,
      this.description,
      this.countUser,
      this.age,
      this.imageUrl})
      : super(key: key);

  final SelectAnimals _animals = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: NetworkImage(ipAdress + imageUrl.toString()),
          fit: BoxFit.cover,
        ),
      ),
      height: getProportionateScreenHeight(150.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: kPrimaryExtraColor,
              borderRadius: BorderRadius.circular(58.0),
            ),
            padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(4.0),
              horizontal: getProportionateScreenWidth(10.0),
            ),
            child: Text(
              "+ $countUser xaridorlar",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 12.0,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(58.0),
            ),
            padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(4.0),
              horizontal: getProportionateScreenWidth(10.0),
            ),
            child: Text(
              "+ $age yosh",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 12.0,
              ),
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$name",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        backgroundColor:
                            Colors.black.withOpacity(0.3),
                      ),
                    ),
                    Text(
                      "$description",
                      style: const TextStyle(
                        fontSize: 10.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              ...List.generate(
                3,
                (index) => Container(
                  margin:
                      EdgeInsets.only(left: getProportionateScreenWidth(6.0)),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(4.0),
                    horizontal: getProportionateScreenWidth(10.0),
                  ),
                  child: Text(
                    index != 2 ? _animals.typeOfAnimals[index] : "+12",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
