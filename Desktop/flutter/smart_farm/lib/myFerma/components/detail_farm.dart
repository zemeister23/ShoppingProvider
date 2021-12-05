import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/myFerma/components/blur_title.dart';
import 'package:smart_farm/size_config.dart';
import 'package:smart_farm/widgets/icons_path.dart';
import 'package:smart_farm/widgets/info_bottomsheep.dart';

class DetailFarm extends StatelessWidget {
  final ImageProvider image;
  final String? title;
  final String? countUser;
  var data;
  DetailFarm(
      {Key? key, required this.image, this.title, this.countUser, this.data})
      : super(key: key);

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
                  Expanded(
                    child: Text(
                      title!,
                      style: const TextStyle(
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
                            children: [
                              Expanded(
                                child: Text(
                                  countUser.toString(),
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const Expanded(
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
                            Get.bottomSheet(InfoBottomSheep(
                              infoFarm: {
                                "farm": data['name'].toString(),
                                "phonenumber": data['phone'].toString(),
                                "address": data['adress'].toString(),
                                "comment": data['description'].toString(),
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
