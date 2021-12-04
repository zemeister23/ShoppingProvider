import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/getX/my_inceement.dart';
import 'package:smart_farm/widgets/icons_path.dart';
import '../constants.dart';
import '../size_config.dart';

class MyBottomSheep extends StatelessWidget {
  final ImageProvider myImage;
  final String productName;
  final String? listTile;
  final int productMoney;
  final bool isIncrement;

  MyBottomSheep({
    Key? key,
    required this.myImage,
    required this.productName,
    required this.productMoney,
    this.listTile,
    this.isIncrement = false,
  }) : super(key: key);

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
        height: getProportionateScreenHeight(listTile != null ? 459.0 : 407.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(14.0),
                  vertical: getProportionateScreenHeight(14.0),
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: myImage,
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(CupertinoIcons.xmark),
                      ),
                      onTap: () {
                        Get.back();
                        _incrementGetx.incrementValue.value = 1;
                      },
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14.0),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaY: 14.0, sigmaX: 10.0),
                        child: Container(
                          color: Colors.black26,
                          child: ListTile(
                            title: Text(
                              "Hamyon balansi",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: getProportionateScreenHeight(12.0),
                              ),
                            ),
                            subtitle: Text(
                              "150 000 sum",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: getProportionateScreenHeight(18.0),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: ImageIcon(
                              AssetImage(IconsPath.primaryIcon),
                              color: Colors.white,
                              size: 26.0,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              flex: listTile != null ? 6 : 7,
            ),
            Expanded(
              child: listTile != null
                  ? Container(
                      margin: EdgeInsets.only(
                        top: getProportionateScreenHeight(14.0),
                        left: getProportionateScreenWidth(20.0),
                        right: getProportionateScreenWidth(20.0),
                      ),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Text(
                              "Bugun 14:52",
                              style: TextStyle(
                                fontSize: 12.0,
                                color: kPrimaryBorderColor,
                              ),
                            ),
                            flex: 2,
                          ),
                          Text(
                            listTile!,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(flex: 1),
                        ],
                      ),
                    )
                  : Container(),
              flex: listTile != null ? 2 : 0,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(18.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.all(0.0),
                      title: Text(
                        productName,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: Obx(
                        () => Text(
                          (productMoney * _incrementGetx.incrementValue.value)
                              .toString(),
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Spacer(
                      flex: listTile != null ? 6 : 8,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          isIncrement
                              ? Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: kPrimaryBorderColor,
                                        width: 0.4,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                            getProportionateScreenHeight(8.0)),
                                    child: Material(
                                      color: Colors.white,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                            splashRadius: 24.0,
                                            icon: const Icon(
                                              Icons.horizontal_rule,
                                              color: kPrimaryBorderColor,
                                            ),
                                            onPressed: () {
                                              _incrementGetx.removeValue();
                                            },
                                          ),
                                          Obx(
                                            () => Text(
                                              _incrementGetx
                                                  .incrementValue.value
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 20.0,
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            splashRadius: 24.0,
                                            color: kPrimaryBorderColor,
                                            icon: const Icon(
                                              Icons.add,
                                            ),
                                            onPressed: () {
                                              _incrementGetx.addValue();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  flex: 12,
                                )
                              : Container(),
                          isIncrement ? const Spacer(flex: 1) : Container(),
                          Expanded(
                            child: TextButton(
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        getProportionateScreenHeight(8.0)),
                                child: const Text(
                                  "Sotib olish",
                                  style: TextStyle(
                                    fontSize: 16.0,
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
                                Get.snackbar(
                                  "",
                                  "",
                                  titleText: const Text(
                                    "Xabar",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                  colorText: Colors.white,
                                  messageText: const Text(
                                    "Xaridingiz muvofaqiyatli bajarlidi!",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                  backgroundColor: Colors.black26,
                                );
                              },
                            ),
                            flex: 12,
                          ),
                        ],
                      ),
                      flex: 22,
                    ),
                    const Spacer(flex: 6),
                  ],
                ),
              ),
              flex: 4,
            ),
          ],
        ),
      ),
    );
  }
}
