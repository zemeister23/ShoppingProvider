import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/constants.dart';
import 'package:smart_farm/getX/is_filter_controller.dart';
import 'package:smart_farm/home/home_page.dart';
import 'package:smart_farm/search/components/my_search_widget.dart';
import 'package:smart_farm/search/pages/selected_location.dart';

import '../../size_config.dart';

class FilterLocation extends StatefulWidget {
  final bool isCity;
  final String? city;
  const FilterLocation({Key? key, required this.isCity, this.city})
      : super(key: key);

  @override
  State<FilterLocation> createState() => _FilterLocationState();
}

class _FilterLocationState extends State<FilterLocation> {
  String? street;
  final IsFilterController _filterController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(14.0),
              vertical: getProportionateScreenHeight(12.0),
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  MySeachWiget(
                    onPage: true,
                    readOnly: true,
                    onFilter: true,
                    isCity: widget.isCity,
                    city: widget.city,
                    street: street,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenHeight(12.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.isCity
                                ? "Viloyatni tanlang"
                                : "Shaharni tanlang",
                            style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        widget.isCity
                            ? Container()
                            : GestureDetector(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.black,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    "O'chirish",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  _filterController.filterControll(false);
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => HomePage()),
                                    (route) => false,
                                  );
                                }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const Divider(
                height: 0.4,
                color: kPrimaryBorderColor,
                thickness: 0.4,
              ),
            ]),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(14.0),
              vertical: getProportionateScreenHeight(12.0),
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.isCity ? kCities[index] : kData[index],
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16.0,
                          ),
                          onPressed: () {
                            widget.isCity
                                ? Get.to(SelectedLocation(city: kCities[index]))
                                : street = kData[index];
                            setState(() {});
                          },
                        )
                      ],
                    ),
                    Divider(
                      height: getProportionateScreenHeight(14.0),
                      color: kPrimaryBorderColor,
                      thickness: 0.4,
                    ),
                  ],
                );
              }, childCount: widget.isCity ? kCities.length : kData.length),
            ),
          ),
          widget.isCity
              ? SliverList(delegate: SliverChildListDelegate([]))
              : SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(14.0),
                    vertical: getProportionateScreenHeight(12.0),
                  ),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        TextButton(
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                vertical: getProportionateScreenHeight(8.0)),
                            child: const Text(
                              "Natijani ko'rsatish",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                          onPressed: () {
                            _filterController.filterControll(true);
                            Navigator.pushAndRemoveUntil(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => HomePage()),
                              (route) => false,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
