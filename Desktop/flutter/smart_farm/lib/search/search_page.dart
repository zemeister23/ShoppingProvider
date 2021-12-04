import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/constants.dart';
import 'package:smart_farm/getX/is_filter_controller.dart';
import 'package:smart_farm/getX/select_animals.dart';
import 'package:smart_farm/myFerma/my_ferma_page.dart';
import 'package:smart_farm/search/components/big_title.dart';
import 'package:smart_farm/search/components/my_search_widget.dart';
import 'package:smart_farm/search/components/products.dart';
import 'package:smart_farm/search/pages/all_animals.dart';
import 'package:smart_farm/search/pages/all_farms.dart';
import 'package:smart_farm/size_config.dart';
import 'package:smart_farm/widgets/my_bottomsheep.dart';
import 'components/animals.dart';
import 'components/top_farms.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  final SelectAnimals _animals = Get.put(SelectAnimals());
  final IsFilterController _filterController = Get.put(IsFilterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(14.0),
                    vertical: getProportionateScreenHeight(12.0),
                  ),
                  child: const MySeachWiget(
                    onPage: false,
                    readOnly: true,
                    onFilter: false,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Obx(
                    () => Container(
                      height: 14.0,
                      width: 14.0,
                      margin: EdgeInsets.only(
                        top: getProportionateScreenHeight(10.0),
                        right: getProportionateScreenWidth(12.0),
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _filterController.isFiltered.value
                            ? kPrimaryExtraColor
                            : Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(12.0),
                  horizontal: getProportionateScreenWidth(16.0)),
              child: BigTitle(
                title: "Fermalar",
                isAllOpen: true,
                voidCallback: () {
                  Get.to(const AllFarms(), transition: Transition.cupertino);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(4.0),
                horizontal: getProportionateScreenWidth(16.0),
              ),
              child: GestureDetector(
                child: TopFarms(),
                onTap: () {
                  Get.to(MyFermaPage(), transition: Transition.cupertino);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(12.0),
                  horizontal: getProportionateScreenWidth(16.0)),
              child: BigTitle(
                title: "Hayvonlar",
                isAllOpen: true,
                voidCallback: () {
                  Get.to(const AllAnimals(), transition: Transition.cupertino);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: getProportionateScreenWidth(16.0)),
              height: getProportionateScreenHeight(85.0),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Animals(
                    title: _animals.typeOfAnimals[index],
                  );
                },
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 4,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(12.0),
                  horizontal: getProportionateScreenWidth(16.0)),
              child: const BigTitle(
                title: "Mahsulotlar",
                isAllOpen: false,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: getProportionateScreenWidth(16.0),
                  bottom: getProportionateScreenHeight(8.0)),
              height: getProportionateScreenHeight(100.0),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: const Products(),
                    onTap: () {
                      Get.bottomSheet(
                        MyBottomSheep(
                          myImage: const NetworkImage(
                              "https://th.bing.com/th/id/R.adefdcd95a7149b640824b8f2a485e0a?rik=PtjjOvzhfEAJKQ&riu=http%3a%2f%2f4.bp.blogspot.com%2f_I6XaHeBO2Js%2fTRPIKfRBSqI%2fAAAAAAAAAkA%2f5FvkBLkVquI%2fw1200-h630-p-k-no-nu%2fIMG_6612.JPG&ehk=UBzSYD9fHsxG6sp8AVo6zysmm1yfhxXVlTckFiBcEqM%3d&risl=&pid=ImgRaw&r=0"),
                          productName: "Qatiq",
                          productMoney: 12000,
                          isIncrement: true,
                          listTile: "Bu siz topa oladigan eng yangi sut",
                        ),
                      );
                    },
                  );
                },
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
