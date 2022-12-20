import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';

class NavigationNotFoundWidget extends StatelessWidget {
  const NavigationNotFoundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Page Not Found"),
      ),
    );
  }
}
