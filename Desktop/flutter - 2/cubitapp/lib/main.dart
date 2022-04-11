import 'package:cubitapp/bloc/home/cats_bloc_view.dart';
import 'package:cubitapp/screens/home_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: CatsBlocView(),
    );
  }
}
