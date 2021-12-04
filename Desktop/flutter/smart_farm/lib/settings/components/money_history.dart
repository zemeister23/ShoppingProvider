import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../size_config.dart';

class MoneyHistory extends StatelessWidget {
  final String image, text;
  final VoidCallback callback;
  const MoneyHistory({
    Key? key,
    required this.image,
    required this.text,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: kPrimaryLightColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(image, height: 22.0),
            SizedBox(
              height: getProportionateScreenHeight(18.0),
            ),
            const Text(
              "Depozit",
              style: TextStyle(
                fontSize: 16.0,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
      onTap: callback,
    );
  }
}
