import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/myFerma/my_ferma_page.dart';
import 'package:smart_farm/search/components/big_title.dart';
import 'package:smart_farm/search/components/my_search_widget.dart';
import 'package:smart_farm/search/components/top_farms.dart';
import 'package:smart_farm/size_config.dart';

class AllFarms extends StatelessWidget {
  const AllFarms({Key? key}) : super(key: key);

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
              const BigTitle(title: "Fermalar", isAllOpen: false),
              ...List.generate(7, (index) {
                return Padding(
                  padding:
                      EdgeInsets.only(top: getProportionateScreenHeight(14.0)),
                  child: GestureDetector(
                    child: TopFarms(),
                    onTap: () {
                      Get.to(MyFermaPage(), transition: Transition.cupertino);
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
