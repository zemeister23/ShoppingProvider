import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/getX/select_animals.dart';
import '../../constants.dart';

class ChooseAnimal extends StatelessWidget {
  ChooseAnimal({Key? key}) : super(key: key);
  final SelectAnimals _animals = Get.put(SelectAnimals());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          1,
          (index) {
            return Obx(
              () => TextButton(
                child: const Text('Jonzotlar'),
                style: TextButton.styleFrom(
                  backgroundColor: _animals.currentAnimal.value == index
                      ? kPrimaryColor
                      : Colors.transparent,
                  primary: _animals.currentAnimal.value == index
                      ? Colors.white
                      : Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
                onPressed: () {},
              ),
            );
          },
        ),
      ),
    );
  }
}
