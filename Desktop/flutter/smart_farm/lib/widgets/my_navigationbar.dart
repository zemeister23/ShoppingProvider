import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/constants.dart';
import 'package:smart_farm/getX/my_navigation.dart';
import 'package:smart_farm/size_config.dart';
import 'package:smart_farm/widgets/icons_path.dart';

class MyNavigationBar extends StatelessWidget {
  MyNavigationBar({Key? key}) : super(key: key);

  final List<String> myIcons = [
    IconsPath.homeIcon,
    IconsPath.searchIcon,
    IconsPath.calendarIcon,
    IconsPath.settingsIcon,
  ];

  final MyNavigationOnTap _navigationOnTap = Get.find();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Material(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          myIcons.length,
          (index) {
            return IconButton(
              onPressed: () {
                _navigationOnTap.onTapIndex(index);
              },
              icon: Obx(
                () => ImageIcon(
                  AssetImage(myIcons[index]),
                  size: getProportionateScreenHeight(18.0),
                  color: _navigationOnTap.currentIndex.value == index
                      ? kPrimaryColor
                      : kPrimaryBorderColor,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
