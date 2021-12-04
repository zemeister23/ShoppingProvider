import 'package:flutter/material.dart';
import 'package:smart_farm/search/components/filter_location.dart';

class SelectedCityPage extends StatelessWidget {
  const SelectedCityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FilterLocation(isCity: true),
    );
  }
}
