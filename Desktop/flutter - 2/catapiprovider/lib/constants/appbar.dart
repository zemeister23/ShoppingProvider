import 'package:flutter/material.dart';

class Constants {
  static AppBar myAppBar(String title, Color color) => AppBar(
        title: Text(title),
        backgroundColor: color,
        elevation: 0,
      );
}
