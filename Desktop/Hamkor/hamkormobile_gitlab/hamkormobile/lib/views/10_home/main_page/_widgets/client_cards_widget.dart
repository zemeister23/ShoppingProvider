import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/images/card_bank_logo.dart';
import 'package:mobile/core/constants/images/image_const.dart';
import 'package:mobile/core/constants/sizeconst/size_const.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_name_box.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_service.dart';
import 'package:mobile/core/network/dio/endpoints.dart';
import 'package:mobile/models/acounts_model.dart';
import 'package:mobile/models/client_cards_model.dart';
import 'package:mobile/views/10_home/_widgets/_divider_widget.dart';
import 'package:mobile/views/10_home/_widgets/_expansion_tile.dart';
import 'package:mobile/views/10_home/_widgets/_list_tile.dart';
import 'package:mobile/widgets/shimmers.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svgp;

class ClientCardsAndAccounsWidget extends StatelessWidget {
  final Future<ClientCardsModel> clientCardsData;
  final Future<AccountsModel> accountsData;
  const ClientCardsAndAccounsWidget(
      {super.key, required this.clientCardsData, required this.accountsData});
  @override
  Widget build(BuildContext context) {
    return cardsAndAccountsContent(context);
  }

  cardsAndAccountsContent(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<ClientCardsModel>(
            future: clientCardsData,
            builder: (__, AsyncSnapshot<ClientCardsModel> snap) {
              if (snap.hasData) {
                return clientCardData(snap.data!, context);
              } else if (snap.hasError) {
                return SizedBox();
              } else {
                return hiveDataCards();
              }
            }),
        Padding(
          padding: EdgeInsets.only(left: 40.w),
          child: Divider(
            color: ColorConst.instance.kElementsColor,
            thickness: 1,
            height: 0,
            indent: 44.w,
            endIndent: 28.w,
          ),
        ),
        clientAccounsData(context),
      ],
    );
  }

  FutureBuilder hiveDataCards() {
    
    return FutureBuilder(
        future: HiveService.instance.readBox(
            encKey: Endpoints.clientCards, boxName: HiveBoxName.CLIENT_CARDS),
        builder: (BuildContext context, AsyncSnapshot snap) {
          if (snap.hasData) {
            ClientCardsModel data = snap.data;

            
            return clientCardData(data, context);
          } else {
            
            return context.homePrStreem.responsAcounts == null
                ? Shimmers.instance.cardsAndAccounts(context)
                : SizedBox();
          }
        });
  }

  FutureBuilder hiveDataAccounts() {
    
    return FutureBuilder(
        future: HiveService.instance
            .readBox(encKey: Endpoints.accounts, boxName: HiveBoxName.ACCOUNTS),
        builder: (BuildContext context, AsyncSnapshot snap) {
          if (snap.hasData) {
            AccountsModel data = snap.data;
            
            return accountsDataWidget(context, data);
          } else {
            
            return SizedBox();
          }
        });
  }

  clientCardData(ClientCardsModel clientcardsData, BuildContext context) {
    final data = clientcardsData.data!;
    return ExpansionTileW(
      isCardsContainer: true,
      isNotBorder: context.homePrStreem.responsAcounts != null ? false : true,
      title: "cards_accounts".locale,
      height: SizeConst.instance.h * ((data.cards!.length) / 10),
      padding: SizeConst.instance.w * 0.03,
      dataLength: data.cards!.length + context.homePrStreem.schetaLength,
      isCardsAndAccounts: true,
      isExpanded: context.homePrStreem.isExpanded,
      onTab: () {
        if (data.cards!.length >= 3) {
          context.homePr.changeIsExpanded();
        }
      },
      child: Container(
          height: context.homePrStreem.isExpanded
              ? (data.cards!.length / 10) * context.h
              : data.cards!.length >= 3
                  ? context.h * 0.3
                  : (data.cards!.length / 10) * context.h,
          child: ListView.separated(
            itemCount: data.cards!.length,
            padding: const EdgeInsets.all(0),
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (BuildContext context, int index) {
              return const DividerW();
            },
            itemBuilder: (BuildContext context, int index) {
              return ListTileW(
                leading: Container(
                  width: SizeConst.instance.w * 0.13,
                  height: SizeConst.instance.h * 0.05,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          whichLogoBankHomePage(
                          data.cards![index].mfo.toString()),
                        ),
                        fit: BoxFit.cover),
               //  color: ColorConst.instance.kErrorColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                title: Text(
                  data.cards![index].cardType.toString().trim() == "private"
                      ? "main_card".locale
                      : "pension".locale,
                  style: context.theme.caption,
                ),
                trailing: AutoSizeText(
                  context.homePr.cardsBalances(
                      data.cards![index].balance.toString(),
                      index,
                      data.cards![index].cardId!) == null ? 
                       context.homePr.changeAllText(data.cards![index].balance.toString()) 
                       :  context.homePr.cardsBalances(
                      data.cards![index].balance.toString(),
                      index,
                      data.cards![index].cardId!)!,
                     maxLines: 1,
                  //    maxFontSize: FontSizeConst.instance.medium,
                  //   minFontSize: FontSizeConst.instance.small,
                  textAlign: TextAlign.end,
                  style: context.theme.caption,
                ),
                isTrailingCurrency: true,
                subTitle: Row(
                  children: <Widget>[
                    SvgPicture.asset(
                      data.cards![index].psCode == "UZCARD"
                          ? ImageConst.instance.toSvg("uzcard")
                          : ImageConst.instance.toSvg("humo"),
                    ),
                    Text(
                      " " +
                          context.homePr.smallCardNumber(
                              data.cards![index].maskNum.toString()),
                      style: FontstyleText.instance.mainPageMultiWithUzcard,
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }

  clientAccounsData(BuildContext context) {
    return FutureBuilder<AccountsModel>(
        future: accountsData,
        builder: (__, AsyncSnapshot<AccountsModel> snap) {
          if (!snap.hasData) {
            return hiveDataAccounts();
          }
          if (snap.hasError) {
            //
            return SizedBox();
          } else {
            return accountsDataWidget(context, snap.data!);
          }
        });
  }

  accountsDataWidget(BuildContext context, AccountsModel data) {
    final data2 = data.data!;
    return Container(
        margin: EdgeInsets.only(
         // top: context.homePrStreem.responseClientCards  != null ? 0 : 20.h,
          left: SizeConst.instance.w * 0.03,
          right: SizeConst.instance.w * 0.03,
        ),
        decoration: BoxDecoration(
          color: ColorConst.instance.kInputColor,
          borderRadius:
              BorderRadius.vertical(bottom: Radius.circular(context.h * 0.013)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              blurRadius: 0,
              color: ColorConst.instance.kShadowColor.withOpacity(0.0),
              offset: const Offset(0, 0),
              spreadRadius: 0,
            ),
          ],
        ),
        height: context.homePrStreem.isExpanded
            ? (data2.length / 10) * SizeConst.instance.h
            : context.homePrStreem.cardsLength >= 3
                ? 0
                : data2.length == 0
                    ? 0
                    : context.homePrStreem.cardsLength == 2 && data2.length >= 1
                        ? SizeConst.instance.h * 0.1
                        : context.homePrStreem.cardsLength == 1 &&
                                data2.length >= 2
                            ? SizeConst.instance.h * 0.2
                            : SizeConst.instance.h * 0.1,
        child: ListView.separated(
          itemCount: data2.length,
          padding: const EdgeInsets.all(0),
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (BuildContext context, int index) {
            return const DividerW();
          },
          itemBuilder: (BuildContext context, int index) {
            return ListTileW(
              leading: Container(
                width: SizeConst.instance.w * 0.13,
                height: SizeConst.instance.h * 0.05,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: svgp.Svg(
                      ImageConst.instance.scheta,
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              title: Text(
                "own_account".locale.toString(),
                style: context.theme.caption,
              ),
              codeCurrency: context.homePr
                  .changeAllText(data2[index].codeCurrency.toString()),
              trailing: AutoSizeText(
                context.homePr.changeAllText(data2[index].saldo.toString()),
                maxLines: 1,
                //    maxFontSize: FontSizeConst.instance.medium,
                //   minFontSize: FontSizeConst.instance.small,
                textAlign: TextAlign.end,
                style: context.theme.caption,
              ),
              isTrailingCurrency: true,
              // subTrailing: "01/23",
              subTitle: Text(
                data2[index].account.toString(),
                style: FontstyleText.instance.mainPageMultiWithUzcard,
              ),
            );
          },
        ));
  }
}
