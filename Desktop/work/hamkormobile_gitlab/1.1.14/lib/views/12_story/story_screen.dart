import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/components/loading/loading_page.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/models/history_model.dart' as ht;
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppbar.getAppBar(
        "history".locale,
        () {},
        context,
        false,
      ),
      body: FutureBuilder<ht.HistoryModel>(
          future: widget.historyData,
          builder: (context, AsyncSnapshot<ht.HistoryModel> snap) {
            if (!snap.hasData) {
              return LoadingPage(true);
            } else if (snap.data!.data!.operations!.isEmpty) {
              return Center(
                child: Text("Empty Data"),
              );
            } else if (snap.hasError) {
              return Center(
                child: Text("Backend Error"),
              );
            } else {
              final data = snap.data!.data!.operations!;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: context.w * 0.04),
                child: ListView.builder(
                  itemCount: data.length,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.only(bottom: context.h * 0.02),
                  itemBuilder: (BuildContext context, int index) {
                    int sum = 0;
                    for (var i = 0; i < data.length; i++) {
                      if (context.historyPr
                              .changeTimeText(data[index].time.toString()) ==
                          context.historyPr
                              .changeTimeText(data[i].time.toString())) {
                        sum += 1;
                      }
                    }
                    bool ind = index == 0
                        ? context.historyPr
                                .changeTimeText(data[index].time.toString()) ==
                            context.historyPr.changeTimeText(
                                data[index - (index == 0 ? 0 : 1)]
                                    .time
                                    .toString())
                        : context.historyPr
                                .changeTimeText(data[index].time.toString()) !=
                            context.historyPr.changeTimeText(
                                data[index - (index == 0 ? 1 : 1)]
                                    .time
                                    .toString());
                    return ind
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: context.h * 0.025),
                                child: Text(
                                  context.historyPr.changeTimeText(
                                      data[index].time.toString()),
                                  style: context.theme.caption,
                                ),
                              ),
                              Container(
                                height: context.h * (sum * 0.1),
                                decoration: ContainerDecorationComp
                                    .containerWithoutShadow(context),
                                child: ListView.separated(
                                  itemCount: data.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  separatorBuilder:
                                      (BuildContext context, int _) {
                                    return Divider(
                                      color: ColorConst.instance.kElementsColor,
                                      thickness: 1,
                                      height: 0,
                                    );
                                  },
                                  itemBuilder: (BuildContext context, int _) {
                                    return context.historyPr.changeTimeText(
                                                data[index].time.toString()) ==
                                            context.historyPr.changeTimeText(
                                                data[_].time.toString())
                                        ? ListTileForStoryW(
                                            psCode: data[_].psCode!,
                                            codeCurrency:
                                                data[_].currCode.toString(),
                                            isIncome: data[_].isCredit!,
                                            title: data[_]
                                                        .torgName
                                                        .toString() ==
                                                    "null"
                                                ? ""
                                                : data[_].torgName.toString(),
                                            subTitle: context.historyPr
                                                .smallCardNumber(
                                                    data[_].pan.toString()),
                                            trailing: context.homePr
                                                .changeAllText(
                                                    data[_].sum.toString()),
                                          )
                                        : SizedBox();
                                  },
                                ),
                              ),
                            ],
                          )
                        : SizedBox();
                  },
                ),
              );
            }
          }),
    );
  }
}
