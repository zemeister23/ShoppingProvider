import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/getX/my_inceement.dart';
import 'package:smart_farm/size_config.dart';
import 'package:smart_farm/widgets/buy_card.dart';
import 'package:smart_farm/widgets/icons_path.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class BuyBottomSheep extends StatelessWidget {
  final bool isBuy;
  BuyBottomSheep({Key? key, required this.isBuy}) : super(key: key);

  final MyIncrementGetx _incrementGetx = Get.put(MyIncrementGetx());
  @override
  Widget build(BuildContext context) {
    _incrementGetx.incrementValue.value = 1;
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(10.0),
      ),
      child: Container(
        color: Colors.white,
        height: isBuy
            ? getProportionateScreenHeight(386.0)
            : getProportionateScreenHeight(250.0),
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20.0)),
        child: isBuy ? buyAnimal() : callForAnimal(),
      ),
    );
  }

  Widget callForAnimal() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Container(
            margin: EdgeInsets.only(top: getProportionateScreenHeight(8.0)),
            height: getProportionateScreenHeight(4.0),
            width: getProportionateScreenWidth(25.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28.0),
              color: kPrimaryLightColor,
            ),
          ),
        ),
        const Spacer(flex: 3),
        const Text(
          "Telefon",
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(flex: 1),
        const Text(
          "+998 97 736-63-25",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(flex: 3),
        TextButton(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(8.0)),
            child: const Text(
              "Qo'ngiroq qilmoq",
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          style: TextButton.styleFrom(
            backgroundColor: kPrimaryColor,
            primary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
          ),
          onPressed: () {
            launch("tel://+998 97 736-63-25");
            Get.back();
          },
        ),
        const Spacer(flex: 1),
        OutlinedButton(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(14.0)),
            child: const Text(
              "SMS yuborish",
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          style: OutlinedButton.styleFrom(
            primary: kPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            side: const BorderSide(
              width: 1.0,
              color: kPrimaryColor,
            ),
          ),
          onPressed: () {
            launch("sms://+998 97 736-63-25");
            Get.back();
          },
        ),
        const Spacer(flex: 3),
      ],
    );
  }

  Widget buyAnimal() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            margin: EdgeInsets.only(top: getProportionateScreenHeight(8.0)),
            height: getProportionateScreenHeight(4.0),
            width: getProportionateScreenWidth(25.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28.0),
              color: kPrimaryLightColor,
            ),
          ),
        ),
        const Spacer(flex: 1),
        const BuyCard(),
        const Spacer(flex: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Sof zotli toy",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Obx(
              () => Text(
                (_incrementGetx.incrementValue.value * 2000000).toString(),
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        const Spacer(flex: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OutlinedButton(
              onPressed: () {
                _incrementGetx.removeValue();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(10.0)),
                child: const Icon(
                  Icons.horizontal_rule,
                  size: 24.0,
                  color: Colors.black,
                ),
              ),
              style: OutlinedButton.styleFrom(
                primary: kPrimaryBorderColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                side: const BorderSide(
                  width: 1.0,
                  color: kPrimaryLightColor,
                ),
              ),
            ),
            const Spacer(flex: 1),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: kPrimaryLightColor),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenHeight(10.0)),
                  child: Obx(
                    () => Text(
                      _incrementGetx.incrementValue.value.toString(),
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              flex: 18,
            ),
            const Spacer(flex: 1),
            OutlinedButton(
              onPressed: () {
                _incrementGetx.addValue();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(10.0)),
                child: const Icon(
                  Icons.add,
                  size: 24.0,
                  color: Colors.black,
                ),
              ),
              style: OutlinedButton.styleFrom(
                primary: kPrimaryBorderColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                side: const BorderSide(
                  width: 1.0,
                  color: kPrimaryLightColor,
                ),
              ),
            ),
          ],
        ),
        const Spacer(flex: 2),
        TextButton(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(8.0)),
            child: const Text(
              "Sotib olish",
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
            Get.back();
            _incrementGetx.incrementValue.value = 1;
            Get.snackbar("", "",
                titleText: const Icon(
                  Icons.check,
                  color: kPrimaryExtraColor,
                  size: 24.0,
                ),
                colorText: Colors.white,
                messageText: const Text(
                  "Sotib olish muvaffaqiyatli bo'ldi",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: kPrimaryExtraColor,
                  ),
                ),
                backgroundColor: Colors.white,
                barBlur: 0.0,
                borderWidth: 1.0,
                borderColor: kPrimaryExtraColor);
          },
        ),
        const Spacer(flex: 4),
      ],
    );
  }
}
