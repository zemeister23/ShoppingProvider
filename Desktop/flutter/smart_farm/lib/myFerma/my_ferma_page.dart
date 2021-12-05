import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/constants.dart';
import 'package:smart_farm/getX/select_animals.dart';
import 'package:smart_farm/myFerma/components/choose_animal.dart';
import 'package:smart_farm/myFerma/components/detail_farm.dart';
import 'package:smart_farm/service/backend_service.dart';
import 'package:smart_farm/size_config.dart';
import 'package:smart_farm/widgets/about_animal_page.dart';
import 'package:smart_farm/widgets/animals_data.dart';

class MyFermaPage extends StatelessWidget {
  String? title;
  String? imgUrl;
  String? countUser;
  var data;
  var dataWithIndex;
  MyFermaPage(
      {Key? key,
      this.title,
      this.imgUrl,
      this.dataWithIndex,
      this.countUser,
      this.data})
      : super(key: key);

  final SelectAnimals _animals = Get.find();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: BackendService().getFarmAnimals(title!),
        builder: (context, AsyncSnapshot snap) {
          if (!snap.hasData) {
            return Center(
              child: Platform.isAndroid
                  ? const CircularProgressIndicator()
                  : const CupertinoActivityIndicator(),
            );
          } else if (snap.hasError) {
            return const Center(
                child: Text("Internetni Tekshirib Qaytadan Urinib Ko'ring !"));
          } else {
            var data = snap.data['products'];
            return SafeArea(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  DetailFarm(
                    data: snap.data,
                    countUser: countUser,
                    title: title,
                    image: NetworkImage(
                      ipAdress + imgUrl!,
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
                              _animals
                                  .typeOfAnimals[_animals.currentAnimal.value],
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
                          data: data[index],
                          myCallback: () {
                            Get.to(
                              AboutAnimal(
                                  data: data[index], phone: snap.data['phone']),
                              transition: Transition.cupertino,
                            );
                          },
                        );
                      },
                      childCount: data.length,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
