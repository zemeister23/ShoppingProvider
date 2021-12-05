import 'package:flutter/material.dart';
import 'package:smart_farm/service/backend_service.dart';
import 'package:smart_farm/size_config.dart';
import 'package:smart_farm/widgets/icons_path.dart';

class BuyCard extends StatefulWidget {
  const BuyCard({Key? key}) : super(key: key);

  @override
  State<BuyCard> createState() => _BuyCardState();
}

class _BuyCardState extends State<BuyCard> {
  int? balance;

  @override
  void initState() {
    super.initState();
    BackendService().getMyAnimals().then((value) {
      balance = value[0]['balance'];
      setState(() {});
    });
  }

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
              "Hamyon balansingiz",
              style: TextStyle(
                color: Colors.white54,
                fontSize: 14.0,
              ),
            ),
            subtitle: Text(
              "$balance so'm",
              style: const TextStyle(
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
                  "1111 2222 3333 4444",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ),
              Text(
                "Smart Farm",
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
