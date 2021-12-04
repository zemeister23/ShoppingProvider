import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/constants.dart';
import 'package:smart_farm/search/pages/search_results_page.dart';
import 'package:smart_farm/search/pages/selected_city_page.dart';
import 'package:smart_farm/widgets/icons_path.dart';

import '../../size_config.dart';

class MySeachWiget extends StatelessWidget {
  final bool onPage, readOnly, onFilter;
  final bool? isCity;
  final String? city, street;
  const MySeachWiget(
      {Key? key,
      required this.onPage,
      required this.readOnly,
      required this.onFilter,
      this.street,
      this.isCity,
      this.city})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        onPage
            ? GestureDetector(
                child: Row(
                  children: [
                    const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 20.0,
                    ),
                    SizedBox(width: getProportionateScreenWidth(12.0))
                  ],
                ),
                onTap: () => Get.back(),
              )
            : Container(),
        Expanded(
          child: TextField(
            onTap: readOnly
                ? () {
                    Get.to(
                      const SearchResultsPage(),
                      transition: Transition.downToUp,
                    );
                  }
                : null,
            readOnly: readOnly,
            cursorColor: Colors.black,
            decoration: InputDecoration(
                prefixIcon: !onPage
                    ? const Icon(
                        CupertinoIcons.search,
                        color: Colors.black,
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: kPrimaryLightColor.withOpacity(0.3),
                hintText: onFilter
                    ? isCity!
                        ? "Shahar nomlari"
                        : city! + (street != null ? (", " + street!) : "")
                    : "Qidiring"),
          ),
        ),
        SizedBox(width: getProportionateScreenWidth(8.0)),
        onPage
            ? Container()
            : Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: kPrimaryLightColor.withOpacity(0.3),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: IconButton(
                    icon: ImageIcon(
                      AssetImage(IconsPath.filterIcon),
                      color: Colors.black,
                      size: 20.0,
                    ),
                    onPressed: () {
                      Get.to(const SelectedCityPage(),
                          transition: Transition.cupertino);
                    },
                  ),
                ),
              ),
      ],
    );
  }
}
