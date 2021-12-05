import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/constants.dart';
import 'package:smart_farm/getX/select_animals.dart';
import 'package:smart_farm/size_config.dart';
import 'package:smart_farm/widgets/about_animal_page.dart';

class AnimalsData extends StatelessWidget {
  var data;
  final VoidCallback myCallback;
  AnimalsData({Key? key, required this.data, required this.myCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(
          top: getProportionateScreenHeight(2.0),
          bottom: getProportionateScreenHeight(12.0),
          left: getProportionateScreenWidth(8.0),
          right: getProportionateScreenWidth(8.0),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          border: Border.all(
            color: kPrimaryLightColor,
          ),
        ),
        height: getProportionateScreenHeight(222.0),
        width: getProportionateScreenWidth(154.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10.0)),
                  image: DecorationImage(
                    image: NetworkImage(
                        ipAdress + data['image']['formats']['medium']['url']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              flex: 4,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Text(
                      data['title'],
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      data['age'].toString() + ' yoshda',
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: kPrimaryBorderColor,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: kPrimaryBackgroundColor,
                          borderRadius: BorderRadius.circular(10.0)),
                      padding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenHeight(8.0)),
                      child: Text(
                        data['price'].toString() + " so'm",
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              flex: 4,
            ),
          ],
        ),
      ),
      onTap: myCallback,
    );
  }
}
