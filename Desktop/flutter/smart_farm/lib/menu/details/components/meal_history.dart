import 'package:flutter/material.dart';
import 'package:smart_farm/constants.dart';

class MealHistory extends StatelessWidget {
  const MealHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.all(0.0),
          title: const Text(
            "Makkajoxori",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          ),
          subtitle: const Text(
            "1kg - 15 000 sum",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 12.0,
            ),
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "27.09.2021",
                style: TextStyle(fontSize: 12.0, color: kPrimaryBorderColor),
              ),
              Text(
                "14:16",
                style: TextStyle(fontSize: 12.0, color: kPrimaryBorderColor),
              ),
            ],
          ),
        ),
        const Divider(thickness: 0.4, color: kPrimaryBorderColor),
      ],
    );
  }
}
