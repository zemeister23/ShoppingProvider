import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(12.0),
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.black,
          size: 16.0,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
      onTap: () {
        Get.back();
      },
    );
  }
}
