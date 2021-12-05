import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/constants.dart';
import 'package:smart_farm/menu/components/farm_news.dart';
import 'package:smart_farm/menu/components/first_image.dart';
import 'package:smart_farm/menu/details/components/meal_history.dart';
import 'package:smart_farm/menu/details/components/meal_history_page.dart';
import 'package:smart_farm/size_config.dart';
import 'package:smart_farm/widgets/icons_path.dart';
import 'package:smart_farm/widgets/my_back_button.dart';
import 'package:smart_farm/widgets/my_bottomsheep.dart';

class DetailPage extends StatelessWidget {
  final String? food_percent;
  final String? title;
  final String? description;
  final String? imgUrl;
  final String? count;
  final String? balance;

  const DetailPage({
    Key? key,
    this.food_percent,
    this.title,
    this.description,
    this.imgUrl,
    this.count,
    this.balance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: getProportionateScreenHeight(300.0),
            child: Stack(
              fit: StackFit.expand,
              children: [
                FirstImage(
                  myAlignment: Alignment.bottomRight,
                  imageUrl: ipAdress + imgUrl!,
                  count: count,
                ),
                Padding(
                  padding: EdgeInsets.all(getProportionateScreenHeight(12.0)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const MyBackButton(),
                      GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          child: ImageIcon(
                            AssetImage(IconsPath.healthIcon),
                            color: Colors.white,
                            size: 16.0,
                          ),
                          decoration: const BoxDecoration(
                            color: kPrimaryDarkColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        onTap: () {
                          Get.bottomSheet(
                            MyBottomSheep(
                              myImage: const AssetImage(
                                  "assets/images/medicine.png"),
                              productName: "Tovuq dorisi",
                              productMoney: 9000,
                              balance: balance!,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: const Alignment(0.0, 1.01),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: kPrimaryBackgroundColor,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(12.0)),
                    ),
                    height: getProportionateScreenHeight(8.0),
                  ),
                ),
              ],
            ),
          ),
          FarmNews(
            version: "two",
            title: title,
            description: description,
            readiness: food_percent,
          ),
          Divider(
            height: getProportionateScreenHeight(32.0),
            thickness: 0.4,
            color: kPrimaryBorderColor,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(14.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Ovqatlanish tarixi",
                  overflow: TextOverflow.fade,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
                ...List.generate(
                  3,
                  (index) => const MealHistory(),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: getProportionateScreenHeight(18.0),
                bottom: getProportionateScreenHeight(38.0)),
            child: Center(
              child: TextButton(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(8.0),
                    horizontal: getProportionateScreenWidth(32.0),
                  ),
                  child: const Text(
                    "Ko'proq ko'rish",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                ),
                onPressed: () {
                  Get.to(const MealHistoryPage(),
                      transition: Transition.cupertino);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
