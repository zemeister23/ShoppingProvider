import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

List<Widget> titleInfoBottom(String title, String data, bool isDivider) {
  return [
    ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18.0,
        ),
      ),
      subtitle: Padding(
        padding: EdgeInsets.only(top: getProportionateScreenHeight(6.0)),
        child: Text(
          data,
          style: const TextStyle(
            fontSize: 16.0,
            color: kPrimaryBorderColor,
          ),
        ),
      ),
    ),
    isDivider ? Divider(
      color: kPrimaryBorderColor,
      height:getProportionateScreenHeight(6.0),
      indent: getProportionateScreenWidth(16.0),
      endIndent: getProportionateScreenWidth(16.0),
    ) : Container(),
  ];
}
