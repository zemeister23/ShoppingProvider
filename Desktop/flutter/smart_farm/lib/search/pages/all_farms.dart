import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/myFerma/my_ferma_page.dart';
import 'package:smart_farm/search/components/big_title.dart';
import 'package:smart_farm/search/components/my_search_widget.dart';
import 'package:smart_farm/search/components/top_farms.dart';
import 'package:smart_farm/service/backend_service.dart';
import 'package:smart_farm/size_config.dart';

class AllFarms extends StatelessWidget {
  const AllFarms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: BackendService().getAllFarms(),
          builder: (context, AsyncSnapshot snap) {
            if (!snap.hasData) {
              return Center(
                  child: Platform.isAndroid
                      ? const CircularProgressIndicator()
                      : const CupertinoActivityIndicator());
            } else if (snap.hasError) {
              return const Center(
                  child: Text("Internet Bilan Bog'liq Muammo Bor !"));
            } else {
              var data = snap.data;
              return SafeArea(
                bottom: false,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(14.0),
                    vertical: getProportionateScreenHeight(12.0),
                  ),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      const MySeachWiget(
                        onPage: true,
                        readOnly: true,
                        onFilter: false,
                      ),
                      SizedBox(height: getProportionateScreenHeight(18.0)),
                      const BigTitle(title: "Fermalar", isAllOpen: false),
                      SizedBox(
                        height: Get.height,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  top: getProportionateScreenHeight(14.0)),
                              child: GestureDetector(
                                child: TopFarms(
                                    name: data[index]['name'],
                                    description: data[index]['description'],
                                    countUser: data[index]
                                            ['users_permissions_users']
                                        .length
                                        .toString(),
                                    age: data[index]['age'].toString(),
                                    imageUrl: data[index]['image']['formats']
                                        ['medium']['url']),
                                onTap: () {
                                  Get.to(
                                      MyFermaPage(
                                        data: data[index],
                                        countUser: data[index]
                                                ['users_permissions_users']
                                            .length
                                            .toString(),
                                        title: data[index]['name'],
                                        imgUrl: data[index]['image']['formats']
                                            ['medium']['url'],
                                      ), // !!!!!!!!
                                      transition: Transition.cupertino);
                                },
                              ),
                            );
                          },
                          itemCount: data.length,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}
