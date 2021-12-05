import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/constants.dart';
import 'package:smart_farm/getX/my_navigation.dart';
import 'package:smart_farm/menu/components/animal_food.dart';
import 'package:smart_farm/service/backend_service.dart';
import 'package:smart_farm/service/currencies_service.dart';
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
      body: FutureBuilder(
        future: Future.wait([
          BackendService().getMyAnimals(),
          CurrencyService().getCurrencies()
        ]),
        builder: (context, AsyncSnapshot<List> snap) {
          if (!snap.hasData) {
            return Center(
              child: Platform.isAndroid
                  ? const CircularProgressIndicator()
                  : const CupertinoActivityIndicator(),
            );
          } else if (snap.hasError) {
            return const Center(
                child: Text("Internet Bilan Bog'liq Muammo Bor !"));
          } else {
            var data = snap.data![0][0]['products'];
            var dataCurrencies = snap.data![1][0]['currencies'];
            return ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: getProportionateScreenHeight(14.0)),
                      child: AnimalFoods(
                        imgUrl: data[0]['image']['formats']['medium']['url'],
                        count: data[0]['count'].toString(),
                        food_percent: data[0]['food_percent'].toString(),
                      ),
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
                              myImage: const AssetImage(
                                  "assets/images/medicine.png"),
                              productName: "Tovuq dorisi",
                              productMoney: 9000,
                              balance: snap.data![0][0]['balance'].toString(),
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
                        child: FarmNews(
                          version: "init",
                          readiness: data[index]['readiness'].toString(),
                          title: data[index]['title'],
                          description: data[index]['description'],
                        ),
                        onTap: () {
                          Get.to(
                              DetailPage(
                                food_percent:
                                    data[index]['food_percent'].toString(),
                                title: data[index]['title'],
                                description: data[index]['description'],
                                imgUrl: data[index]['image']['formats']
                                    ['medium']['url'],
                                count: data[index]['count'].toString(),
                                balance: snap.data![0][0]['balance'].toString(),
                              ),
                              transition: Transition.cupertino);
                        },
                      );
                    },
                    itemCount: data.length,
                  ),
                ),
                CurrentNews(onTap: _navigationOnTap, isColor: true),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenHeight(2.0)),
                  child: SizedBox(
                    height: Get.height * 0.15,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: kPrimaryColor,
                            backgroundImage: NetworkImage(ipAdress +
                                snap.data![1][0]['image'][index]['formats']
                                    ['thumbnail']['url']),
                          ),
                          title: Text(dataCurrencies[index]['name'].toString()),
                          subtitle: const Text("Narxi"),
                          trailing: Text(
                            dataCurrencies[index]['price'].toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: Get.width * 0.05,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                      itemCount: dataCurrencies.length,
                    ),
                  ),
                ),
                Divider(
                  thickness: 0.4,
                  color: kPrimaryBorderColor,
                  height: getProportionateScreenHeight(10.0),
                ),
                MyFarms(data: snap.data![0][0]['farms']),
              ],
            );
          }
        },
      ),
    );
  }
}
