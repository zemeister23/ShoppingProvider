import 'package:flutter/cupertino.dart';
import 'package:smart_farm/size_config.dart';

import '../../constants.dart';

Widget firstVersion() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: const [
      Expanded(
        child: Text(
          "Broller tovuq",
          overflow: TextOverflow.fade,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
        ),
        flex: 4,
      ),
      Expanded(
        child: Text(
          "Izoh",
          overflow: TextOverflow.fade,
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
        ),
        flex: 3,
      ),
      Expanded(
        child: Text(
          "Shu kunlari infektsiya tarqaldi va sizning tovuqlaringizga ham bu infektsiya yuqti, shoshilinch ravishda dori sotib olishingiz kerak!!",
          overflow: TextOverflow.fade,
          style: TextStyle(
            fontSize: 14.0,
            color: kPrimaryBorderColor,
          ),
        ),
        flex: 7,
      ),
    ],
  );
}

Widget secondVersion() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Broller tovuq",
        overflow: TextOverflow.fade,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
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
      const Text(
        "Shu kunlari infektsiya tarqaldi va sizning tovuqlaringizga ham bu infektsiya yuqti, shoshilinch ravishda dori sotib olishingiz kerak!!",
        overflow: TextOverflow.fade,
        style: TextStyle(
          fontSize: 14.0,
          color: kPrimaryBorderColor,
        ),
      ),
    ],
  );
}
