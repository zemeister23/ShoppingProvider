import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/sizeconst/size_const.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_name_box.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_service.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/deposits_model.dart';
import 'package:mobile/views/10_home/_widgets/_divider_widget.dart';
import 'package:mobile/views/10_home/_widgets/_expansion_tile.dart';
import 'package:mobile/views/10_home/_widgets/_list_tile.dart';
import 'package:mobile/widgets/shimmers.dart';

class DepostisWidget extends StatelessWidget {
  final Future<Depositsmodel> depositsData;
  const DepostisWidget({super.key, required this.depositsData});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Depositsmodel>(
      future: depositsData,
      builder: (context, snap) {
        if (snap.hasData) {
          if (snap.data!.data!.isNotEmpty) {
            Depositsmodel data = snap.data!;
            return depositsContent(context, data);
          }
          return Text("");
        } else if (snap.hasError) {
          //
          return SizedBox();
        } else {
          return hiveDepositsContent();
        }
      },
    );
  }

  hiveDepositsContent() {
    return FutureBuilder(
        future: HiveService.instance
            .readBox(encKey: Endpoints.deposits, boxName: HiveBoxName.DEPOSITS),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return depositsContent(context, snapshot.data);
          } else {
            return Shimmers.instance.deposits(context);
          }
        });
  }

  depositsContent(BuildContext context, Depositsmodel data) {
//  return SizedBox();
    return ExpansionTileW(
        height: SizeConst.instance.h * (data.data!.length / 10),
        padding: SizeConst.instance.w * 0.03,
        title: "deposits".locale,
        dataLength: data.data!.length,
        isCardsAndAccounts: false,
        isExpanded: context.homePrStreem.isExpandedDeposits,
        onTab: () {
          if (4 > 3) {
            context.homePr.changeIsExpandedDeposits();
          }
        },
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: data.data!.length,
          padding: const EdgeInsets.all(0),
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (BuildContext context, int index) {
            return const DividerW();
          },
          itemBuilder: (BuildContext context, int index) {
            return ListTileW(
              leading: Container(
                width: 52.w,
                height: 38.h,
                decoration: BoxDecoration(
                  color: ColorConst.instance.kAlertColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    data.data![index].rate.toString() + "%",
                    style: FontstyleText.instance.mainPageLeading,
                  ),
                ),
              ),
              title: SizedBox(
                height: SizeConst.instance.h * 0.03,
                width: SizeConst.instance.w * 0.3,
                child: Text(
                  data.data![index].name.toString(),
                  style: context.theme.caption,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              trailing: Container(
                height: 30,
                width: 120.w,
             //   color: Colors.red,
                child: AutoSizeText(
                context.homePr
                         .changeAllText(data.data![index].amount.toString()) +
                     " " +
                      data.data![index].currency.toString(),
                  maxLines: 1,
                    //  maxFontSize: FontSizeConst.instance.medium,
                    // minFontSize: FontSizeConst.instance.small,
                   overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                  style: context.theme.caption,
                ),
              ),
              isTrailingCurrency: false,
             
             
              subTitle: AutoSizeText(
                context.homePr
                    .reBuildDeposits(data.data![index].closeData.toString()),
                maxLines: 1,
                style: FontstyleText.instance.subsText,
              ),
           
           
            );
          },
        )); 
        }
}
