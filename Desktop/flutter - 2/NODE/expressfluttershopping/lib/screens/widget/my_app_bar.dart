import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  String? title;
  Color? color;
  MyAppBar({Key? key, this.title, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color,
      title: Text(title!),
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 100);
}
