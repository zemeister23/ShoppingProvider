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
import 'package:mobile/models/loans_model.dart';
import 'package:mobile/views/10_home/_widgets/_divider_widget.dart';
import 'package:mobile/views/10_home/_widgets/_expansion_tile.dart';
import 'package:mobile/views/10_home/_widgets/_list_tile.dart';
import 'package:mobile/widgets/shimmers.dart';

class CredidWidget extends StatelessWidget {
  final Future<LoansModel> loansData;
  const CredidWidget({super.key, required this.loansData});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LoansModel>(
        future: loansData,
        builder: (context, AsyncSnapshot snap) {
          if (snap.hasData) {
            LoansModel data = (snap.data as LoansModel);

            return data.data!.isEmpty
                ? SizedBox()
                : loansContent(context, data);
          } else if (snap.hasError) {
            return SizedBox();
          } else {
            return hiveDataContent(context);
          }
        });
  }

  hiveDataContent(BuildContext context) {
   try {
      return FutureBuilder(
        future: HiveService.instance
            .readBox(encKey: Endpoints.loans, boxName: HiveBoxName.LOANS),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return loansContent(context, snapshot.data);
          } else {
            return Shimmers.instance.credits(context);
          }
        });
   } catch (e) {
    
     return Shimmers.instance.credits(context);
   }
  }

  loansContent(BuildContext context, LoansModel data) {
   
    
    return ExpansionTileW(
        title: "credits".locale,
        height: context.h * (data.data!.length / 10),
        padding: SizeConst.instance.w * 0.03,
        dataLength: data.data!.length,
        isCardsAndAccounts: true,
        isExpanded: context.homePrStreem.isExpandedkridit,
        onTab: () {
          data.data!.length > 3
              ? context.homePr.changeIsExpandedKridit()
              : null;
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
                  color: ColorConst.instance.kBlueColor,
                  borderRadius: BorderRadius.circular(7),
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
              trailing: SizedBox(
                height: 30,
                width: 130,
               
                child: AutoSizeText(
                  context.homePr
                          .changeAllText(data.data![index].amount.toString()) +
                      " " +
                      data.data![index].currency.toString(),
                  maxLines: 1,
                  //    maxFontSize: FontSizeConst.instance.medium,
                  //   minFontSize: FontSizeConst.instance.small,
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                  style: context.theme.caption,
                ),
              ),
              isTrailingCurrency: false,
              subTrailing: context.homePr
                      .changeAllText(data.data![index].graphAmount.toString()) +
                  " " +
                  data.data![index].currency.toString(),
              subTitle: Text(
                context.homePr.reBuild(data.data![index].closeData.toString()),
                style: FontstyleText.instance.subsText,
              ),
            );
          },
        ));
  
  
  
  }
}
