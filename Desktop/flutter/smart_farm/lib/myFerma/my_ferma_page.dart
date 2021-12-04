import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/getX/select_animals.dart';
import 'package:smart_farm/myFerma/components/choose_animal.dart';
import 'package:smart_farm/myFerma/components/detail_farm.dart';
import 'package:smart_farm/size_config.dart';
import 'package:smart_farm/widgets/about_animal_page.dart';
import 'package:smart_farm/widgets/animals_data.dart';

class MyFermaPage extends StatelessWidget {
  MyFermaPage({Key? key}) : super(key: key);

  final SelectAnimals _animals = Get.find();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const DetailFarm(
              image: AssetImage(
                'assets/images/ina.png',
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(14.0)),
                    child: ChooseAnimal(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: getProportionateScreenHeight(8.0),
                      left: getProportionateScreenWidth(18.0),
                      right: getProportionateScreenWidth(4.0),
                      bottom: getProportionateScreenHeight(8.0),
                    ),
                    child: Obx(
                      () => Text(
                        _animals.typeOfAnimals[_animals.currentAnimal.value],
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: getProportionateScreenHeight(242.0)),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return AnimalsData(
                    animals: _animals,
                    myCallback: () {
                      Get.to(
                        AboutAnimal(),
                        transition: Transition.cupertino,
                      );
                    },
                  );
                },
                childCount: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
const DetailFarm(
              image: AssetImage(
                'assets/images/ina_ferma.png',
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(14.0)),
              child: ChooseAnimal(),
            ),
            const AnimalsData(),
*/
