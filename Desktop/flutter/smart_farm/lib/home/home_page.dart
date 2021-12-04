import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/constants.dart';
import 'package:smart_farm/getX/my_navigation.dart';
import 'package:smart_farm/widgets/my_navigationbar.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final MyNavigationOnTap _navigationOnTap = Get.put(MyNavigationOnTap());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => kAllPages[_navigationOnTap.currentIndex.value]),
      bottomNavigationBar: MyNavigationBar(),
    );
  }
}
