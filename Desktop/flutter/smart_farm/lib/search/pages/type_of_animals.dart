import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/constants.dart';
import 'package:smart_farm/getX/select_animals.dart';
import 'package:smart_farm/search/components/animals.dart';
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
  final List<String> _dataFilter = ["Barchasi"];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _dataFilter.add(widget.title);
    _dataFilter.add("Oddiy ${widget.title}");
  }

  final SelectAnimals _animals = Get.put(SelectAnimals());
  @override
  Widget build(BuildContext context) {
    _animals.currentAnimal.value = 0;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
                  labelPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                  controller: _tabController,
                  labelColor: Colors.white,
                  unselectedLabelColor: kPrimaryBorderColor,
                  indicator: const BoxDecoration(),
                  onTap: (e) {
                    _animals.chooseAnimal(e);
                  },
                  tabs: List.generate(
                    3,
                    (index) {
                      return Tab(
                        child: Obx(
                          () => Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: _animals.currentAnimal.value == index
                                    ? kPrimaryColor
                                    : Colors.transparent,
                                border: _animals.currentAnimal.value != index
                                    ? Border.all(color: kPrimaryLightColor)
                                    : null),
                            child: Text(
                              _dataFilter[index],
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
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
                      animals: _animals,
                      myCallback: () {
                        Get.bottomSheet(
                          MyBottomSheep(
                            myImage: const NetworkImage(
                                "https://lookw.ru/9/970/1566943698-1-22.jpg"),
                            productName: _animals
                                .typeOfAnimals[_animals.currentAnimal.value],
                            productMoney: 9000,
                            isIncrement: true,
                            listTile: "Bu siz topa oladigan eng yangi sut",
                          ),
                        );
                      },
                    );
                  },
                  childCount: 11,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
