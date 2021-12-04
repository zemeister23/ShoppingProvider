import 'package:flutter/material.dart';
import 'package:smart_farm/menu/details/components/meal_history.dart';

import '../../../size_config.dart';

class MealHistoryPage extends StatelessWidget {
  const MealHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverAppBar(
            iconTheme: IconThemeData(color: Colors.black),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            title: Text(
              "Ovqatlanish tarixi",
              style: TextStyle(color: Colors.black),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(8.0),
              horizontal: getProportionateScreenWidth(14.0),
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return const MealHistory();
                },
                childCount: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
