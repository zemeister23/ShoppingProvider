import 'package:flutter/material.dart';
import 'package:get/get_connect.dart';
import 'package:get/instance_manager.dart';
import 'package:smart_farm/constants.dart';
import 'package:get/get.dart';

import '../../size_config.dart';

class MyFarms extends StatelessWidget {
  var data;
  MyFarms({Key? key, this.data}) : super(key: key);

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
            "Mavjud Fermalar",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: getProportionateScreenHeight(14.0)),
          SizedBox(
            height: getProportionateScreenHeight(120),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  margin: EdgeInsets.only(right: Get.width * 0.04),
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                    color: kPrimaryBackgroundColor,
                    image: DecorationImage(
                      image: NetworkImage(ipAdress +
                          data[index]['image']['formats']['thumbnail']['url']),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  height: getProportionateScreenHeight(120.0),
                  child: Text(
                    data[index]['name'],
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                );
              },
              itemCount: data.length,
            ),
          ),
        ],
      ),
    );
  }
}
