import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/constants.dart';
import 'package:smart_farm/getX/select_animals.dart';
import 'package:smart_farm/service/backend_service.dart';
import 'package:smart_farm/size_config.dart';
import 'package:smart_farm/widgets/animals_data.dart';
import 'package:smart_farm/widgets/my_bottomsheep.dart';

class TypeOfAnimals extends StatefulWidget {
  final String title;
  const TypeOfAnimals({Key? key, required this.title}) : super(key: key);

  @override
  State<TypeOfAnimals> createState() => _TypeOfAnimalsState();
}

class _TypeOfAnimalsState extends State<TypeOfAnimals>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int? balance;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
    BackendService()
        .getMyAnimals()
        .then((value) => balance = value[0]['balance']);
  }

  final SelectAnimals _animals = Get.put(SelectAnimals());
  @override
  Widget build(BuildContext context) {
    _animals.currentAnimal.value = 0;
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: BackendService().getCategorizedAnimals(widget.title),
          builder: (context, AsyncSnapshot snap) {
            if (!snap.hasData) {
              return Center(
                child: Platform.isAndroid
                    ? const CircularProgressIndicator()
                    : const CupertinoActivityIndicator(),
              );
            } else if (snap.hasError) {
              return const Center(
                  child:
                      Text("Internetni Tekshirib Qaytadan Urinib Ko'ring !"));
            } else {
              var data = snap.data[0]['products'];
              return SafeArea(
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(14.0),
                      ),
                      sliver: SliverAppBar(
                        elevation: 0.0,
                        floating: true,
                        backgroundColor: Colors.white,
                        leading: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: 20.0,
                          ),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        centerTitle: false,
                        title: Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        bottom: TabBar(
                          labelPadding:
                              const EdgeInsets.symmetric(horizontal: 2.0),
                          controller: _tabController,
                          labelColor: Colors.white,
                          unselectedLabelColor: kPrimaryBorderColor,
                          indicator: const BoxDecoration(),
                          onTap: (e) {
                            _animals.chooseAnimal(e);
                          },
                          tabs: [
                            Tab(
                              child: Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: kPrimaryColor,
                                    border:
                                        Border.all(color: kPrimaryLightColor)),
                                child: const Text(
                                  "Barchasi",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenHeight(8.0),
                        horizontal: getProportionateScreenWidth(8.0),
                      ),
                      sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: getProportionateScreenHeight(242.0),
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return AnimalsData(
                              data: data[index],
                              myCallback: () {
                                Get.bottomSheet(
                                  MyBottomSheep(
                                    myImage: NetworkImage(ipAdress +
                                        data[index]['image']['formats']
                                            ['medium']['url']),
                                    productName: data[index]['title'],
                                    productMoney: data[index]['price'],
                                    isIncrement: true,
                                    listTile: data[index]['description'] +
                                        "dsdsdsddsdsdsddsdsdsddsdsdsddsdsdsddsdsdsddsdsdsddsdsdsddsdsdsddsdsdsddsdsdsd",
                                    balance: balance.toString(),
                                  ),
                                );
                              },
                            );
                          },
                          childCount: data.length,
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          }),
    );
  }
}
