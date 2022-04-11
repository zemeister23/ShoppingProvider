import 'package:animation/core/constants/constant.dart';
import 'package:animation/pages/home/components/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _sliderValue = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getSlider(),
          getContainerForRotate(),
          getContainerForScale(),
          getContainerForTranslate(),
        ],
      ),
    );
  }

  Widget getSlider() => Slider(
      onChanged: (double value) {
        setState(() {
          _sliderValue = value;
        });
      },
      value: _sliderValue);
  Widget getContainerForRotate() {
    return Transform.rotate(
      angle: _sliderValue * 6.28,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.pink,
          border: Border(
            top: BorderSide(
              width: 6,
              color: Colors.black,
            ),
          ),
        ),
        height: Get.width * 0.3,
        width: Get.width * 0.3,
      ),
    );
  }

  Widget getContainerForScale() {
    return Transform.scale(
      scale: _sliderValue == 0 ? 1 : _sliderValue,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.indigoAccent,
          border: Border(
            top: BorderSide(
              width: 6,
              color: Colors.black,
            ),
          ),
        ),
        height: Get.width * 0.3,
        width: Get.width * 0.3,
      ),
    );
  }

  Widget getContainerForTranslate() {
    return Transform.translate(
      offset: Offset(0, _sliderValue * 100),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.indigoAccent,
          border: Border(
            top: BorderSide(
              width: 6,
              color: Colors.black,
            ),
          ),
        ),
        height: Get.width * 0.3,
        width: Get.width * 0.3,
      ),
    );
  }
}
