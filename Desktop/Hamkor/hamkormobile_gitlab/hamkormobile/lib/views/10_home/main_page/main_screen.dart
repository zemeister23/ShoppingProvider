import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/images/image_const.dart';
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
import 'package:mobile/models/p2p_template_model.dart';
import 'package:mobile/provider/3_sms_provider.dart';
import 'package:mobile/provider/9_home_provider.dart';
import 'package:mobile/provider/check_pass_code_provider.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/views/10_home/_widgets/_small_button.dart';
import 'package:mobile/views/10_home/container_decoration.dart';
import 'package:mobile/views/10_home/main_page/_widgets/client_cards_widget.dart';
import 'package:mobile/views/10_home/main_page/_widgets/credit_widget.dart';
import 'package:mobile/views/10_home/main_page/_widgets/deposits_widget.dart';
import 'package:mobile/views/10_home/main_page/_widgets/home_app_bar_widget.dart';
import 'package:mobile/widgets/shimmers.dart';
import 'package:provider/provider.dart';
import '../../../core/init/cache/get_storege.dart';

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

  late List listCardId;
  late ClientCardsModel clientCardsModel;
  late HomeProvider homeProvider;
  late CheckPassCodeProvider passProvider;
  late SmsProvider smsProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    homeProvider = Provider.of(context, listen: false);
    passProvider = Provider.of<CheckPassCodeProvider>(context, listen: false);
    smsProvider = Provider.of<SmsProvider>(context, listen: false);
  }

  int n = 0;
  bool isShowedError = true;
  @override
  void initState() {
    super.initState();

    listCardId = [];
    context.homePr.isAccounsData = true;
    context.homePr.isCards = false;
    context.biometricPr.isBioScreen = false;
    context.homePr.isExpanded = true;

    // Provider.of<LockProvider>(context, listen: false).initializeTimer();
    Provider.of<CheckPassCodeProvider>(context, listen: false)
        .changeIsPopToTrue;
  }

  @override
  void dispose() {
    super.dispose();
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
            ImageConst.instance.toJpg("background"),
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: HomeAppBarWidget(
                clientNameData: widget.clientNameData!,
                clientcardsData: widget.clientCardsData!,
                p2pTemplatesData: widget.p2pTemplatesData!,
                homeProvider: homeProvider),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 12.h),
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

  Widget body(BuildContext context, Map _adData) {
    return Column(
      children: <Widget>[
        ClientCardsAndAccounsWidget(
            clientCardsData: widget.clientCardsData!,
            accountsData: widget.accountsData!),
        DepostisWidget(
          depositsData: widget.depositsData!,
        ),
        SizedBox(
          height: 20.h,
        ),
        addvertisement(context, _adData),
        CredidWidget(loansData: widget.loansData!),
        exchangeRates(context),
        _dataLBottomBars == 0
            ? SizedBox(height: context.h * 0.03)
            // : SizedBox(height: context.h * 0.03)
            : SizedBox(
                height: SizeConst.instance.h * 0.13,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConst.instance.w * 0.03,
                    vertical: context.h * 0.03,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SmallButton(
                        title: "branches".locale,
                        svgName: "bank",
                        onTap: () {
                          context.mapPr.changeButtonState(0);

                          NavigationService.instance.pushNamed(
                            routeName: NavigationConst.MAP_PAGE_VIEW,
                          );
                        },
                      ),
                      SmallButton(
                        title: "ATMs".locale,
                        svgName: "location",
                        onTap: () {
                          context.mapPr.changeButtonState(1);
                          NavigationService.instance.pushNamed(
                            routeName: NavigationConst.MAP_PAGE_VIEW,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
      ],
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
              padding: EdgeInsets.only(left: SizeConst.instance.w * 0.05),
              decoration: ContainerDecorationComp.advertisementContainer(
                context,
                index,
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    right: SizeConst.instance.w * 0.03,
                    bottom: context.h * 0.0,
                    child: SizedBox(
                      width:
                          SizeConst.instance.w * (_dataLAd == 1 ? 0.3 : 0.25),
                      height:
                          SizeConst.instance.w * (_dataLAd == 1 ? 0.3 : 0.25),
                      child: Image.asset(
                        _adData["images"][index],
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Positioned(
                    right: SizeConst.instance.h * 0.015,
                    top: SizeConst.instance.h * 0.015,
                    child: SvgPicture.asset(
                      ImageConst.instance.toSvg("cancel"),
                      width: SizeConst.instance.h * 0.02,
                      height: SizeConst.instance.h * 0.02,
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

  exchangeRates(BuildContext context) {
    String buyingRate(ExchangeRatesModel data1, String type) {
      if (data1.data![0].currencyChar.toString() == type) {
        return data1.data![0].buyingRate.toString();
      } else if (data1.data![1].currencyChar.toString() == type) {
        return data1.data![1].buyingRate.toString();
      } else {
        return ""; //data1.data![index].buyingRate.toString();
      }
    }

    String selingRate(ExchangeRatesModel data1, String type) {
      if (data1.data![0].currencyChar.toString() == type) {
        return data1.data![0].sellingRate.toString();
      } else if (data1.data![1].currencyChar.toString() == type) {
        return data1.data![1].sellingRate.toString();
      } else {
        return ""; // data1.data![index].sellingRate.toString();
      }
    }

    return FutureBuilder<ExchangeRatesModel>(
      future: widget.exchangeRatesData!
        ..catchError((v) {
          // //
          return v;
        }),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          ExchangeRatesModel data = snapshot.data;
          return Column(
            children: <Widget>[
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: SizeConst.instance.w * 0.03),
                title: Text(
                  "currency".locale,
                  style: context.theme.caption,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConst.instance.w * 0.03),
                padding: EdgeInsets.symmetric(
                    vertical: SizeConst.instance.h * 0.025),
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
                          return SizedBox(height: SizeConst.instance.h * 0.015);
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
                                      context.homePr.changeAllText(buyingRate(
                                          data, ["USD", "EUR"][index])),
                                      style: context.theme.caption,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: Column(
                                children: [
                                  Text(
                                    context.homePr.changeAllText(selingRate(
                                        data, ["USD", "EUR"][index])),
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
          //
          return SizedBox();
        } else {
          return Shimmers.instance.exchangeRates(context);
        }
      },
    );
  }
}
