// import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_name_box.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_service.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/cards_operations_model.dart';
import 'package:mobile/core/components/loading/loading_page.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/views/10_home/container_decoration.dart';
import 'package:mobile/views/12_story/_widget/_list_tile.dart';
import 'package:mobile/widgets/appbar/default_appbar.dart';

class HistoryScreen extends StatefulWidget {
  late final historyData;
  HistoryScreen({Key? key, this.historyData}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}
class _HistoryScreenState extends State<HistoryScreen> {
  late final data;
  late List<String> list;
  @override
  void initState() {
    list = [];
    data = widget.historyData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppbar.getAppBar(
        "history".locale,
        () {},
        context,
        false,
      ),
      body: FutureBuilder<List<HistoryOperation>>(
          future: data,
          builder: (context, AsyncSnapshot<List<HistoryOperation>> snap) {
            if (snap.hasData) {
              return historyContent(snap.data!);
            } else {
              return hiveData();
            }
          }),
    );
  }

  hiveData() {
    return FutureBuilder(
        future: HiveService.instance.readBox(
            encKey: Endpoints.cardsOperations,
            boxName: HiveBoxName.CARDS_OPERATIONS),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            

            final data = snapshot.data;
            
            return historyContent(data);
          } else {
            
            return LoadingPage(true);
          }
        });
  }

  Padding historyContent(snap) {
    
    final data = snap;
  
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.w * 0.04),
      child: ListView.builder(
        itemCount:context.historyPrStreem.setData.length,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: context.h * 0.02),
        itemBuilder: (BuildContext context, int index) {
          int sum = 0;
for (var i = 0; i < data.length; i++) {
            if (context.historyPrStreem.setData.toList()[index].toString() ==
                context.historyPr
                    .changeTimeText(data[i].operationTime.toString())) {
              sum += 1;
            }
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: context.h * 0.025),
                child: Text(
                  context.historyPrStreem.setData.toList()[index].toString(),
                  style: context.theme.caption,
                ),
              ),
              Container(
                height: context.h * (sum * 0.1),
                decoration:
                    ContainerDecorationComp.containerWithoutShadow(context),
                child: ListView.separated(
                  itemCount: data.length,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (BuildContext context, int _) {
                    return Divider(
                      color: ColorConst.instance.kElementsColor,
                      thickness: 1,
                      height: 0,
                    );
                  },
                  itemBuilder: (BuildContext context, int _) {
                    return context.historyPrStreem.setData.toList()[index] ==
                            context.historyPr.changeTimeText(
                                data[_].operationTime.toString())
                        ? ListTileForStoryW(
                            psCode: data[_].psCode!,
                            codeCurrency: data[_].currencyCode.toString(),
                            isIncome:
                                data[_].operationType! == 2 ? true : false,
                            title: data[_].merchantName.toString() == "null"
                                ? ""
                                : data[_].merchantName.toString(),
                            subTitle: context.historyPr
                                .smallCardNumber(data[_].maskPan.toString()),
                            trailing: context.homePr
                                .changeAllText(data[_].amount.toString()),
                          )
                        : SizedBox();
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
