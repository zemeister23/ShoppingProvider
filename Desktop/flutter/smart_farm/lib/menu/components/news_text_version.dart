import 'package:flutter/cupertino.dart';
import 'package:smart_farm/size_config.dart';

import '../../constants.dart';

Widget firstVersion(String title, String description) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Text(
          title,
          overflow: TextOverflow.fade,
          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
        ),
        flex: 4,
      ),
      const Expanded(
        child: Text(
          "Izoh",
          overflow: TextOverflow.fade,
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
        ),
        flex: 3,
      ),
      Expanded(
        child: Text(
          description,
          overflow: TextOverflow.fade,
          style: const TextStyle(
            fontSize: 14.0,
            color: kPrimaryBorderColor,
          ),
        ),
        flex: 7,
      ),
    ],
  );
}

Widget secondVersion(String title, String description, String readiness) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        overflow: TextOverflow.fade,
        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
      ),
      Padding(
        padding: EdgeInsets.only(
            top: getProportionateScreenHeight(8.0),
            bottom: getProportionateScreenHeight(4.0)),
        child: const Text(
          "Izoh",
          overflow: TextOverflow.fade,
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
        ),
      ),
      Text(
        description,
        overflow: TextOverflow.fade,
        style: const TextStyle(
          fontSize: 14.0,
          color: kPrimaryBorderColor,
        ),
      ),
    ],
  );
}
