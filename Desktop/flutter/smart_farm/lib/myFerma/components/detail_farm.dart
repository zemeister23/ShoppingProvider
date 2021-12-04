import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/myFerma/components/blur_title.dart';
import 'package:smart_farm/size_config.dart';
import 'package:smart_farm/widgets/icons_path.dart';
import 'package:smart_farm/widgets/info_bottomsheep.dart';
import 'package:smart_farm/widgets/my_bottomsheep.dart';

class DetailFarm extends StatelessWidget {
  final ImageProvider image;
  const DetailFarm({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      automaticallyImplyLeading: false,
      stretch: true,
      elevation: 0.0,
      leading: GestureDetector(
        child: Container(
          margin: const EdgeInsets.only(top: 12.0, left: 12.0),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20.0,
          ),
        ),
        onTap: () {
          Get.back();
        },
      ),
      expandedHeight: getProportionateScreenHeight(300.0),
      flexibleSpace: FlexibleSpaceBar(
        background: Image(
          image: image,
          fit: BoxFit.cover,
        ),
        titlePadding: const EdgeInsets.all(0.0),
        title: Stack(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
              alignment: Alignment.bottomLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Spacer(flex: 28),
                  const Expanded(
                    child: Text(
                      "Ina ferma",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    flex: 3,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        BlurTitle(
                          child: Column(
                            children: const [
                              Expanded(
                                child: Text(
                                  "172",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "Xaridorlar",
                                  style: TextStyle(
                                    fontSize: 8.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(flex: 1),
                        GestureDetector(
                          child: BlurTitle(
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: ImageIcon(
                                AssetImage(IconsPath.warningIcon),
                                color: Colors.white,
                                size: 12.0,
                              ),
                            ),
                          ),
                          onTap: () {
                            Get.bottomSheet(const InfoBottomSheep(
                              infoFarm: {
                                "farm": "Ina ferma",
                                "phonenumber": "+998 97 736-63-25",
                                "address": "Farg'ona viloyati...",
                                "comment":
                                    "2 oy davomida Germaniyadan nasldan naslga hech qanday kasallik yo'q",
                              },
                            ));
                          },
                        ),
                        const Spacer(flex: 26)
                      ],
                    ),
                    flex: 5,
                  ),
                ],
              ),
            ),
            Align(
              alignment: const Alignment(0.0, 1.001),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(28.0),
                  ),
                ),
                height: getProportionateScreenHeight(8.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
Container(
        decoration: BoxDecoration(
          image: DecorationImage(fit: BoxFit.cover, image: image),
        ),
        alignment: Alignment.centerLeft,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                        size: 20.0,
                      ),
                    ),
                    onTap: () {
                      Get.back();
                    },
                  ),
                  const Spacer(
                    flex: 20,
                  ),
                  const Text(
                    "Ina ferma",
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(flex: 1),
                  Row(
                    children: [
                      BlurTitle(
                        child: Column(
                          children: const [
                            Text(
                              "172",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Xaridorlar",
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(flex: 1),
                      BlurTitle(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ImageIcon(
                            AssetImage(IconsPath.warningIcon),
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Spacer(flex: 26)
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: const Alignment(0.0, 1.001),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(28.0),
                  ),
                ),
                height: getProportionateScreenHeight(8.0),
              ),
            )
          ],
        ),
      ),
*/