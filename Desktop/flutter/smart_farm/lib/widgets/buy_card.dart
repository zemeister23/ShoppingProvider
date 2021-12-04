import 'package:flutter/material.dart';
import 'package:smart_farm/size_config.dart';
import 'package:smart_farm/widgets/icons_path.dart';

class BuyCard extends StatelessWidget {
  const BuyCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(140.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF8E31F4).withOpacity(0.7),
            const Color(0XFF4945F8).withOpacity(0.7)
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      padding: EdgeInsets.only(
        bottom: getProportionateScreenHeight(14.0),
        left: getProportionateScreenWidth(20.0),
        right: getProportionateScreenWidth(20.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListTile(
            minVerticalPadding: 0.0,
            contentPadding: const EdgeInsets.all(0.0),
            title: const Text(
              "Hamyon balansi",
              style: TextStyle(
                color: Colors.white54,
                fontSize: 14.0,
              ),
            ),
            subtitle: const Text(
              "150 000 sum",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 22.0,
              ),
            ),
            trailing: ImageIcon(
              AssetImage(IconsPath.primaryIcon),
              color: Colors.white,
              size: 26.0,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Expanded(
                child: Text(
                  "5282 3456 2890 1289",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ),
              Text(
                "09/25",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
