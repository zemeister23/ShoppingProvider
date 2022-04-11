import 'package:animation/pages/home/my_home_page.dart';
import 'package:animation/pages/introduction/components/intro_model.dart';
import 'package:animation/services/get_service.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:get/route_manager.dart';

class IntroViewPage extends StatelessWidget {
  const IntroViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroViewsFlutter(
      page,
      onTapDoneButton: () {
        GetService.box
            .write('isDone', true)
            .then((value) => Get.to(MyHomePage()));
      },
      showSkipButton: false,
      pageButtonTextStyles: const TextStyle(
        color: Colors.white,
        fontSize: 18.0,
        fontFamily: 'Regular',
      ),
    );
    ;
  }
}
