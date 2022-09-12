import 'dart:async';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/error/alert_error.dart';
import 'package:mobile/core/constants/images/image_const.dart';
import 'package:mobile/core/constants/images/card_bank_logo.dart';
import 'package:mobile/core/constants/navigation/navigation_constant.dart';
import 'package:mobile/core/constants/sizeconst/size_const.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/models/acounts_model.dart';
import 'package:mobile/models/client_cards_model.dart';
import 'package:mobile/models/client_name_model.dart';
import 'package:mobile/models/deposits_model.dart';
import 'package:mobile/models/exchange_rates_model.dart';
import 'package:mobile/models/loans_model.dart';
import 'package:mobile/models/p2p_templates_model.dart';
import 'package:mobile/provider/9_home_provider.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/views/10_home/_widgets/_divider_widget.dart';
import 'package:mobile/views/10_home/_widgets/_expansion_tile.dart';
import 'package:mobile/views/10_home/_widgets/_list_tile.dart';
import 'package:mobile/views/10_home/_widgets/_small_button.dart';
import 'package:mobile/views/10_home/container_decoration.dart';
import 'package:mobile/views/map/test_scree.dart';
import 'package:mobile/widgets/shimmers.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svgp;
import 'package:provider/provider.dart';
import '../../core/init/cache/get_storege.dart';
import '../../provider/check_pass_code_provider.dart';
import '../../provider/lock_timer_provider.dart';
import '../../service/firebase/performance/performance_service.dart';

class MainScreen extends StatefulWidget {
  final Future<ClientNameModel>? clientNameData;
  final Future<ClientCardsModel>? clientCardsData;
  final Future<P2PTemplatesModel>? p2pTemplatesData;
  final Future<AccountsModel>? accountsData;
  final Future<Depositsmodel>? depositsData;
  final Future<LoansModel>? loansData;
  final Future<ExchangeRatesModel>? exchangeRatesData;

  MainScreen({
    Key? key,
    required this.clientNameData,
    required this.clientCardsData,
    required this.p2pTemplatesData,
    required this.accountsData,
    required this.depositsData,
    required this.loansData,
    required this.exchangeRatesData,
  }) : super(key: key) {
    GetStorageService.instance.box
        .write(GetStorageService.instance.isLockScreenShowed, true);
    GetStorageService.instance.box
        .write(GetStorageService.instance.pageState, "false");
  }
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final int _dataLAd = 2;
  final int _dataLBottomBars = 1;
  final countForHasAppBar = 0;
// ? Bu valyuta datasi
  final Map _currencyData = {
    "icon": <String>[
      ImageConst.instance.toSvg("dollar"),
      ImageConst.instance.toSvg("euro"),
    ],
    "title": <String>[
      ImageConst.instance.toSvg("USD_text"),
      ImageConst.instance.toSvg("EUR_text"),
    ],
  };

// ? Bu lokal datasi

  List listCardId = [];

  late ClientCardsModel clientCardsModel;
  late HomeProvider _homeProvider;
  late CheckPassCodeProvider passProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _homeProvider = Provider.of(context, listen: false);

    passProvider = Provider.of<CheckPassCodeProvider>(context, listen: false);
  }

  int n = 0;
  @override
  void initState() {
    super.initState();
    context.biometricPr.isBioScreen = false;
    context.homePr.isExpanded = true;

    Provider.of<LockProvider>(context, listen: false).initializeTimer();
    Provider.of<CheckPassCodeProvider>(context, listen: false)
        .changeIsPopToTrue;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void addErrorCount() {
    n++;
    if (n >= 5) {
      ErrorMessage.instance.translationsEror(1001, context);
      n = -10;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map _adData = {
      "images": <String>[
        ImageConst.instance.toPng("stories_phone"),
        ImageConst.instance.toPng("stories_card"),
      ],
      "title": <String>[
        "free_transfer".locale.replaceAll("NUMBER", "5 000 000"),
        "order_card_online".locale,
      ],
      "subtitle": <String>[
        "from_card_to_card_in_app".locale,
        "free_serviving".locale,
      ],
      "navigation": <String>[
        "/12_stories",
        "/12_stories",
      ],
    };
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            ImageConst.instance.toPng("background"),
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                SafeArea(
                  child: SizedBox(
                    height: context.homePrStreem.hasAppBar ? 270.h : 155.h,
                    child: appBar(context),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: ColorConst.instance.kMainColor,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(15.r),
                    ),
                  ),
                  child: body(context, _adData),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column appBar(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 25.h),
        FutureBuilder<ClientNameModel>(
          future: widget.clientNameData!
            ..catchError((v) {
              addErrorCount();
              return v;
            }),
          builder: (context, snap) {
            if (snap.hasData) {
              if (snap.data!.data != null) {
                GetStorageService.instance.box.write(
                  GetStorageService.instance.name,
                  snap.data!.data!.firstName! +
                      " " +
                      snap.data!.data!.lastName!,
                );
                return Padding(
                  padding:
                      EdgeInsets.only(left: SizeConst.instance.horizPadding),
                  child: InkWell(
                    onTap: () => NavigationService.instance
                        .pushNamed(routeName: "/16_profile"),
                    child: Container(
                      width: 30.w,
                      height: 30.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color:
                            ColorConst.instance.kProfileColor.withOpacity(0.2),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color:
                              ColorConst.instance.kButtonColor.withOpacity(0.4),
                          width: 1.5.r,
                        ),
                      ),
                      child: Text(
                        snap.data!.data!.firstName![0].toString() +
                            snap.data!.data!.lastName![0].toString(),
                        style: TextStyle(
                          color:
                              ColorConst.instance.kButtonColor.withOpacity(0.8),
                          fontSize: FontSizeConst.instance.extraSmall,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return Shimmers.instance.circleAvatar;
              }
            } else if (snap.hasError) {
              return SizedBox();
            } else {
              return Shimmers.instance.circleAvatar;
            }
          },
        ),
        SizedBox(
          height: SizeConst.instance.minSize,
        ),
        Padding(
          padding: EdgeInsets.only(left: SizeConst.instance.horizPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  FutureBuilder<ClientCardsModel>(
                    future: widget.clientCardsData!
                      ..catchError((v) {
                        addErrorCount();
                        return v;
                      }),
                    builder: (context, snap) {
                      if (snap.hasData) {
                        clientCardsModel = snap.data!;
                        return Text(
                          context.homePr.responseCardsBalances == null
                              ? context.homePr.changeAllText(
                                  clientCardsModel.data!.totalSum.toString())
                              : context.homePr.changeAllText(context
                                  .homePr.responseCardsBalances!.data!.totalSum
                                  .toString()),
                          style: FontstyleText.instance.mainPageCheck,
                        );
                      } else if (snap.hasError) {
                        return SizedBox();
                      } else {
                        return Shimmers.instance.ballance;
                      }
                    },
                  ),
                  Text(
                    "UZS  ",
                    style: FontstyleText.instance.mainPageUZS,
                  ),
                  // Center(
                  //   heightFactor: 1.5,
                  //   child: SvgPicture.asset(
                  //     ImageConst.instance.toSvg("eye"),
                  //   ),
                  // ),
                ],
              ),
              Text(
                "total_balance".locale,
                style: TextStyle(
                  color: ColorConst.instance.kButtonColor.withOpacity(0.74),
                  fontSize: FontSizeConst.instance.bottom,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: SizeConst.instance.minSize,
        ),
        FutureBuilder<P2PTemplatesModel>(
          future: widget.p2pTemplatesData!
            ..catchError((v) {
              addErrorCount();
              return v;
            }),
          builder: (context, snap) {
            if (!snap.hasData) {

              _homeProvider.changeHasAppBar(true);

              return Shimmers.instance.shablon;
            } else if (snap.hasError) {

              _homeProvider.changeHasAppBar(false);
              return SizedBox();
            } else {
              P2PTemplatesModel data = snap.data!;
              if (data.data!.isEmpty || snap.data == null) {
                _homeProvider.changeHasAppBar(false);
                return SizedBox();
              } else {
                _homeProvider.changeHasAppBar(true);
                return SizedBox(
                  height: 92.w,
                  child: ListView.separated(
                    itemCount: data.data!.length,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConst.instance.horizPadding,
                    ),
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(width: 5.w);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      //  context.homePr.reciverPan(snap.data!.data![index].receiverPan.toString());
                      return ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                          child: InkWell(
                            onTap: () {
                              context.transactionsPr.homeData = data;
                              context.transactionsPr.homeDataIndex = index;
                              context.transactionsPr
                                  .changeTransferHomePageData(true);
                              NavigationService.instance.pushNamed(
                                routeName:
                                    NavigationConst.TRANLATIONS_PAGE_VIEW,
                              );
                            },
                            child: Container(
                              width: 92.w,
                              padding: EdgeInsets.all(7.w),
                              decoration: BoxDecoration(
                                color: ColorConst.instance.kButtonColor
                                    .withOpacity(0.05),
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  width: 1.45.r,
                                  color: ColorConst.instance.kButtonColor
                                      .withOpacity(0.4),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SvgPicture.asset(
                                        ImageConst.instance.toSvg("exchange"),
                                      ),
                                      SvgPicture.asset(
                                        ImageConst.instance.toSvg("cancel"),
                                        color: ColorConst.instance.kButtonColor,
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  AutoSizeText(
                                    "${data.data![index].receiver!.owner.toString()}",
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: ColorConst.instance.kButtonColor
                                          .withOpacity(0.7),
                                      fontSize: FontSizeConst.instance.small,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                      "${context.homePr.smallCardNumber(data.data![index].receiver!.pan.toString())}"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            }
          },
        ),
      ],
    );
  }

  Column body(BuildContext context, Map _adData) {
    return Column(
      children: <Widget>[
        cardsAndAccountsContent(context),
        deposits(context),
        SizedBox(
          height: 20.h,
        ),
        addvertisement(context, _adData),
        credits(context),
        exchangeRates(context),
        _dataLBottomBars == 0
            ? SizedBox(height: context.h * 0.03)
            : SizedBox(height: context.h * 0.03)
        // : SizedBox(
        //     height: context.h * 0.13,
        //     child: Padding(
        //       padding: EdgeInsets.symmetric(
        //         horizontal: context.w * 0.03,
        //         vertical: context.h * 0.03,
        //       ),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: <Widget>[
        //           SmallButton(
        //             title: "branches".locale,
        //             svgName: "bank",
        //             onTap: () {
        //               context.mapPr.changeButtonState(0);

        //               NavigationService.instance.pushNamed(
        //                 routeName: NavigationConst.MAP_PAGE_VIEW,
        //               );
        //             },
        //           ),
        //           SmallButton(
        //             title: "ATMs".locale,
        //             svgName: "location",
        //             onTap: () {
        //               context.mapPr.changeButtonState(1);
        //               NavigationService.instance.pushNamed(
        //                 routeName: NavigationConst.MAP_PAGE_VIEW,
        //               );
        //             },
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
      ],
    );
  }

  cardsAndAccountsContent(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([
          widget.clientCardsData!
            ..catchError((v) {
              addErrorCount();
              return v;
            }),
          widget.accountsData!,
        ]),
        builder: (context, AsyncSnapshot snap) {
          if (snap.hasData) {
            var data = (snap.data[0] as ClientCardsModel).data!;
            var data2 = (snap.data[1] as AccountsModel).data!;
            return ExpansionTileW(
              title: "cards_accounts".locale,
              height: context.h * ((data.cards!.length + data2.length) / 10),
              padding: context.w * 0.03,
              dataLength: data.cards!.length + data2.length,
              isCardsAndAccounts: true,
              isExpanded: context.homePrStreem.isExpanded,
              onTab: () {
                if (data.cards!.length > 3) {
                  context.homePr.changeIsExpanded();
                }
              },
              child: Column(
                children: [
                  Container(
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
                              width: context.w * 0.13,
                              height: context.h * 0.05,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                      whichLogoBankHomePage(
                                          data.cards![index].mfo.toString()),
                                    ),
                                    fit: BoxFit.cover),
                                //  color: ColorConst.instance.kErrorColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            title: Text(
                              data.cards![index].cardType.toString().trim() ==
                                      "private"
                                  ? "main_card".locale
                                  : "pension".locale,
                              style: context.theme.caption,
                            ),
                            trailing: AutoSizeText(
                              context.homePr.cardsBalances(
                                  data.cards![index].balance.toString(), index),
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
                                      context.homePr.smallCardNumber(data
                                          .cards![index].maskNum
                                          .toString()),
                                  style: FontstyleText
                                      .instance.mainPageMultiWithUzcard,
                                ),
                              ],
                            ),
                          );
                        },
                      )),
                  DividerW(),
                  Container(
                      height: context.homePrStreem.isExpanded
                          ? (data2.length / 10) * context.h
                          : data.cards!.length >= 3
                              ? 0
                              : data2.length == 0
                                  ? 0
                                  : data.cards!.length == 2 && data2.length >= 1
                                      ? context.h * 0.1
                                      : data.cards!.length == 1 &&
                                              data2.length >= 2
                                          ? context.h * 0.2
                                          : context.h * 0.1,
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
                              width: context.w * 0.13,
                              height: context.h * 0.05,
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
                            codeCurrency: context.homePr.changeAllText(
                                data2[index].codeCurrency.toString()),
                            trailing: AutoSizeText(
                              context.homePr
                                  .changeAllText(data2[index].saldo.toString()),
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
                              style: FontstyleText
                                  .instance.mainPageMultiWithUzcard,
                            ),
                          );
                        },
                      )),
                ],
              ),
            );
          } else if (snap.hasError) {
            return SizedBox();
          } else {
            return Shimmers.instance.cardsAndAccounts(context);
          }
        });
  }

  deposits(BuildContext context) {
    return FutureBuilder<Depositsmodel>(
      future: widget.depositsData!
        ..catchError((v) {
          addErrorCount();
          return v;
        }),
      builder: (context, snap) {
        if (snap.hasData) {
          if (snap.data!.data!.isNotEmpty) {
            Depositsmodel data = snap.data!;
            return ExpansionTileW(
                height: context.h * (data.data!.length / 10),
                padding: context.w * 0.03,
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
                        height: context.h * 0.03,
                        width: context.w * 0.3,
                        child: Text(
                          data.data![index].name.toString(),
                          style: context.theme.caption,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      trailing: AutoSizeText(
                        context.homePr.changeAllText(
                                data.data![index].amount.toString()) +
                            " " +
                            data.data![index].currency,
                        maxLines: 1,
                        //    maxFontSize: FontSizeConst.instance.medium,
                        //   minFontSize: FontSizeConst.instance.small,
                        textAlign: TextAlign.end,
                        style: context.theme.caption,
                      ),
                      isTrailingCurrency: false,
                      subTitle: AutoSizeText(
                        context.homePr.reBuildDeposits(
                            data.data![index].closeData.toString()),
                        maxLines: 1,
                        style: FontstyleText.instance.subsText,
                      ),
                    );
                  },
                ));
          }
          return Text("");
        } else if (snap.hasError) {
          return SizedBox();
        } else {
          return Shimmers.instance.deposits(context);
        }
      },
    );
  }

  SizedBox addvertisement(BuildContext context, Map _adData) {
    return SizedBox(
      height: _dataLAd == 0 ? 0 : 115.h,
      child: ListView.separated(
        itemCount: _dataLAd,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: SizeConst.instance.horizPadding,
        ),
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: SizeConst.instance.minSizeW);
        },
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: Container(
              width: _dataLAd == 1 ? 343.w : 327.w,
              padding: EdgeInsets.only(left: context.w * 0.05),
              decoration: ContainerDecorationComp.advertisementContainer(
                context,
                index,
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    right: context.w * 0.03,
                    bottom: context.h * 0.0,
                    child: SizedBox(
                      width: context.w * (_dataLAd == 1 ? 0.3 : 0.25),
                      height: context.w * (_dataLAd == 1 ? 0.3 : 0.25),
                      child: Image.asset(
                        _adData["images"][index],
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Positioned(
                    right: context.h * 0.015,
                    top: context.h * 0.015,
                    child: SvgPicture.asset(
                      ImageConst.instance.toSvg("cancel"),
                      width: context.h * 0.02,
                      height: context.h * 0.02,
                      color: ColorConst.instance.kSecondaryTextColor,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _adData["title"][index],
                        style: TextStyle(
                          color: ColorConst.instance.kMainTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: context.h * 0.01),
                      Text(
                        _adData["subtitle"][index],
                        style: FontstyleText.instance.bottomNavBarDisableText,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            onTap: () {
              if (index == 0) {
                NavigationService.instance
                    .pushNamed(routeName: _adData["navigation"][index]);
              } else if (index == 1) {
                NavigationService.instance.pushNamed(
                  routeName: NavigationConst.SERVICE_VIEW_AD,
                );
              }
            },
          );
        },
      ),
    );
  }

  credits(BuildContext context) {
    return FutureBuilder<LoansModel>(
        future: widget.loansData!
          ..catchError((v) {
            addErrorCount();
            return v;
          }),
        builder: (context, AsyncSnapshot snap) {
          if (snap.hasData) {
            LoansModel data = (snap.data as LoansModel);

            return data.data!.isEmpty
                ? SizedBox()
                : ExpansionTileW(
                    title: "credits".locale,
                    height: context.h * (data.data!.length / 10),
                    padding: context.w * 0.03,
                    dataLength: data.data!.length,
                    isCardsAndAccounts: true,
                    isExpanded: context.homePrStreem.isExpandedkridit,
                    onTab: () {
                      data.data!.length > 3
                          ? context.homePr.changeIsExpandedKridit()
                          : null;
                    },
                    child: ListView.separated(
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
                            height: context.h * 0.03,
                            width: context.w * 0.3,
                            child: Text(
                              data.data![index].name.toString(),
                              style: context.theme.caption,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          trailing: AutoSizeText(
                            context.homePr.changeAllText(
                                    data.data![index].amount.toString()) +
                                " " +
                                data.data![index].currency.toString(),
                            maxLines: 1,
                            //    maxFontSize: FontSizeConst.instance.medium,
                            //   minFontSize: FontSizeConst.instance.small,
                            textAlign: TextAlign.end,
                            style: context.theme.caption,
                          ),
                          isTrailingCurrency: false,
                          subTrailing: context.homePr.changeAllText(
                                  data.data![index].graphAmount.toString()) +
                              " " +
                              data.data![index].currency.toString(),
                          subTitle: Text(
                            context.homePr.reBuild(
                                data.data![index].closeData.toString()),
                            style: FontstyleText.instance.subsText,
                          ),
                        );
                      },
                    ));
          } else if (snap.hasError) {
            return SizedBox();
          } else {
            return Shimmers.instance.credits(context);
          }
        });
  }

  exchangeRates(BuildContext context) {
    return FutureBuilder<ExchangeRatesModel>(
      future: widget.exchangeRatesData!
        ..catchError((v) {
          addErrorCount();
          return v;
        }),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          ExchangeRatesModel data = snapshot.data;
          return Column(
            children: <Widget>[
              ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: context.w * 0.03),
                title: Text(
                  "currency".locale,
                  style: context.theme.caption,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: context.w * 0.03),
                padding: EdgeInsets.symmetric(vertical: context.h * 0.025),
                decoration: ContainerDecorationComp.containerShadow(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text("currency2".locale,
                            style: context.theme.bodyText2),
                        Text("sell".locale, style: context.theme.bodyText2),
                        Text("buy".locale, style: context.theme.bodyText2),
                      ],
                    ),
                    SizedBox(height: context.h * 0.01),
                    SizedBox(
                      height: 70.h,
                      child: ListView.separated(
                        itemCount: 2, // data.data!.length,
                        padding: const EdgeInsets.all(0),
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: context.h * 0.015);
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          SvgPicture.asset(
                                            _currencyData["icon"][index],
                                          ),
                                          SvgPicture.asset(
                                            _currencyData["title"][index],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      context.homePr.changeAllText(data
                                          .data![index].buyingRate
                                          .toString()),
                                      style: context.theme.caption,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: Column(
                                children: [
                                  Text(
                                    context.homePr.changeAllText(data
                                        .data![index].sellingRate
                                        .toString()),
                                    style: context.theme.caption,
                                  ),
                                ],
                              )),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return SizedBox();
        } else {
          return Shimmers.instance.exchangeRates(context);
        }
      },
    );
  }
}
