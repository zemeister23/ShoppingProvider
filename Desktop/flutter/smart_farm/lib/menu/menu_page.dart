import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/constants.dart';
import 'package:smart_farm/getX/my_navigation.dart';
import 'package:smart_farm/menu/components/animal_food.dart';
import 'package:smart_farm/widgets/current_news.dart';
import 'package:smart_farm/menu/components/farm_news.dart';
import 'package:smart_farm/menu/components/my_farms.dart';
import 'package:smart_farm/menu/details/detail_page.dart';
import 'package:smart_farm/myFerma/my_ferma_page.dart';
import 'package:smart_farm/size_config.dart';
import 'package:smart_farm/widgets/icons_path.dart';
import 'package:smart_farm/widgets/my_bottomsheep.dart';

class MenuPage extends StatelessWidget {
  MenuPage({Key? key}) : super(key: key);

  final MyNavigationOnTap _navigationOnTap = Get.find();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Stack(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: getProportionateScreenHeight(14.0)),
                  child: const AnimalFoods(),
                ),
                Align(
                  alignment: const Alignment(0.29, 0.80),
                  child: GestureDetector(
                    child: Container(
                      margin: EdgeInsets.only(
                          top: getProportionateScreenHeight(2.0)),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: kPrimaryDarkColor,
                      ),
                      padding: const EdgeInsets.all(12.0),
                      child: ImageIcon(
                        AssetImage(IconsPath.healthIcon),
                        color: Colors.white,
                        size: 16.0,
                      ),
                    ),
                    onTap: () {
                      Get.bottomSheet(
                        MyBottomSheep(
                          myImage:
                              const AssetImage("assets/images/medicine.png"),
                          productName: "Tovuq dorisi",
                          productMoney: 9000,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(16.0)),
            SizedBox(
              height: getProportionateScreenHeight(118.0),
              child: PageView.builder(
                controller: PageController(
                    initialPage: _navigationOnTap.newsCurrentIndex.value),
                onPageChanged: (value) {
                  _navigationOnTap.onPageChengedNews(value);
                },
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: const FarmNews(version: "init"),
                    onTap: () {
                      Get.to(const DetailPage(),
                          transition: Transition.cupertino);
                    },
                  );
                },
                itemCount: 3,
              ),
            ),
            CurrentNews(onTap: _navigationOnTap, isColor: true),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(18.0)),
              child: Container(
                child: IconButton(
                  icon: const Icon(Icons.add, color: Colors.black),
                  onPressed: () {
                    Get.to(MyFermaPage(), transition: Transition.cupertino);
                  },
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(-0.2, 3.0),
                      blurRadius: 6.0,
                      color: Colors.grey.shade300.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 0.4,
              color: kPrimaryBorderColor,
              height: getProportionateScreenHeight(26.0),
            ),
            const MyFarms(),
          ],
        ),
      ),
    );
  }
}
