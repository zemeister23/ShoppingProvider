import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/constants.dart';
import 'package:smart_farm/getX/animal_scroll_image.dart';
import 'package:smart_farm/myFerma/components/blur_title.dart';
import 'package:smart_farm/size_config.dart';
import 'package:smart_farm/widgets/buy_bottom_sheep.dart';
import 'package:smart_farm/widgets/current_news.dart';
import 'package:smart_farm/widgets/my_back_button.dart';

class AboutAnimal extends StatelessWidget {
  var data;
  String? phone;
  AboutAnimal({Key? key, this.data, this.phone}) : super(key: key);

  final AnimalScrollImage _scrollImage = Get.put(AnimalScrollImage());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              height: getProportionateScreenHeight(260.0),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  PageView.builder(
                    itemCount: 3,
                    controller: PageController(
                      initialPage: _scrollImage.newsCurrentIndex.value,
                    ),
                    onPageChanged: (value) {
                      _scrollImage.onPageChengedNews(value);
                    },
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Image.network(
                        ipAdress + data['image']['formats']['medium']['url'],
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(14.0),
                      vertical: getProportionateScreenHeight(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const MyBackButton(),
                        const Spacer(),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: BlurTitle(
                            child: Text(
                              data['title'].toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child:
                              CurrentNews(onTap: _scrollImage, isColor: false),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(16.0),
                  vertical: getProportionateScreenHeight(10.0),
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          data['updated_at'].toString(),
                          style: const TextStyle(
                            fontSize: 12.0,
                            overflow: TextOverflow.ellipsis,
                            color: kPrimaryBorderColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        flex: 2,
                      ),
                      Expanded(
                        child: Text(
                          data['title'].toString(),
                          style: const TextStyle(
                            fontSize: 24.0,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        flex: 2,
                      ),
                      Expanded(
                        child: Text(
                          data['price'].toString(),
                          style: const TextStyle(
                            fontSize: 20.0,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        flex: 2,
                      ),
                      const Expanded(
                        child: Divider(color: kPrimaryBorderColor),
                        flex: 1,
                      ),
                      const Spacer(flex: 1),
                      const Expanded(
                        child: Text(
                          "Mavjud:",
                          style: TextStyle(
                            fontSize: 18.0,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        flex: 2,
                      ),
                      Expanded(
                        child: Text(
                          data['count'].toString() + ' dona',
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: kPrimaryBorderColor,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        flex: 3,
                      ),
                      const Expanded(
                        child: Text(
                          "Izoh",
                          style: TextStyle(
                            fontSize: 18.0,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        flex: 2,
                      ),
                      Expanded(
                        child: Text(
                          data['description'].toString(),
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: kPrimaryBorderColor,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                        flex: 7,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                Get.bottomSheet(BuyBottomSheep(
                                  isBuy: false,
                                  phone: phone,
                                ));
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        getProportionateScreenHeight(14.0)),
                                child: const Text(
                                  "Boglanish",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                  ),
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
                            ),
                            flex: 16,
                          ),
                          const Spacer(flex: 1),
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                Get.bottomSheet(
                                  BuyBottomSheep(
                                    isBuy: true,
                                    phone: phone,
                                    data: data,
                                  ),
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        getProportionateScreenHeight(7.0)),
                                child: const Text(
                                  "Sotib olish",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: kPrimaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            flex: 16,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
