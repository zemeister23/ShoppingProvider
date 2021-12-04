import 'package:flutter/material.dart';
import 'package:smart_farm/search/components/filter_location.dart';

class SelectedLocation extends StatelessWidget {
  final String city;
  const SelectedLocation({Key? key, required this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FilterLocation(isCity: false, city: city),
    );
  }
}
