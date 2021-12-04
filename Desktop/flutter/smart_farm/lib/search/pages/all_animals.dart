import 'package:flutter/material.dart';
import 'package:smart_farm/constants.dart';
import 'package:smart_farm/search/components/animals.dart';
import 'package:smart_farm/search/components/big_title.dart';
import 'package:smart_farm/search/components/my_search_widget.dart';
import 'package:smart_farm/search/components/top_farms.dart';
import '../../size_config.dart';

class AllAnimals extends StatelessWidget {
  const AllAnimals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(14.0),
            vertical: getProportionateScreenHeight(12.0),
          ),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const MySeachWiget(
                onPage: true,
                readOnly: true,
                onFilter: false,
              ),
              SizedBox(height: getProportionateScreenHeight(18.0)),
              const BigTitle(title: "Hayvonlar", isAllOpen: false),
              Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: List.generate(9, (index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: getProportionateScreenHeight(14.0)),
                    child: Animals(title: kAnimalsName[index % kAnimalsName.length]),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
