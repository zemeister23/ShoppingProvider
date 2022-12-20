import 'dart:async';
// import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/constants/error/alert_error.dart';
import 'package:mobile/core/init/cache/hive_storege/hive_adapter_service.dart';
import 'package:mobile/models/cards_operations_model.dart';
import 'package:mobile/views/10_home/main_page/main_screen.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/core/base/view/base_view.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/images/image_const.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/models/acounts_model.dart';
import 'package:mobile/models/cards_balances_model.dart';
import 'package:mobile/models/client_cards_model.dart';
import 'package:mobile/models/client_name_model.dart';
import 'package:mobile/models/deposits_model.dart';
import 'package:mobile/models/exchange_rates_model.dart';
import 'package:mobile/models/history_model.dart' as histoy;
import 'package:mobile/models/loans_model.dart';
import 'package:mobile/models/p2p_template_model.dart';
import 'package:mobile/provider/9_home_provider.dart';
import 'package:mobile/provider/lock_timer_provider.dart';
import 'package:mobile/views/10_home/service/service_screen.dart';
import 'package:mobile/views/12_story/story_screen.dart';
import 'package:mobile/views/13_transactions/transactions_screen.dart';
import 'package:mobile/core/extensions/context_extension.dart';

import 'package:provider/provider.dart';
import '../../../service/firebase/performance/performance_service.dart';

class BottomNavBarScreen extends StatefulWidget {
  BottomNavBarScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  late List listIndex;
  int index = 0;
  int backIndex = 2;

  @override
  void initState() {
    GetStorageService.instance.box
        .write(GetStorageService.instance.isRazvilkaPage, "false");

    context.homePr.currentIndex = 0;
    listIndex = [0];
    context.homePr.currentIndex == 0
        ? context.homePr.cardList.isNotEmpty
            ? context.homePr.postClientBalances(context)
            : null
        : null;
    context.homePr.currentIndex == 0 ? data() : null;
    context.homePr.init(context);
    super.initState();
  }

  Future<histoy.HistoryModel>? historyData;
  Future<ClientNameModel>? clientNameData;
  late Future<ClientCardsModel>? clientCardsData;
  Future<P2PTemplatesModel>? p2pTemplatesData;
  late Future<AccountsModel>? accountsData;
  Future<Depositsmodel>? depositsData;
  Future<LoansModel>? loansData;
  Future<ExchangeRatesModel>? exchangeRatesData;

  bool isStartStoryPage = false;
  @override
  Widget build(BuildContext context) {
    final List list = [
      MainScreen(
        accountsData: accountsData,
        clientCardsData: clientCardsData,
        clientNameData: clientNameData,
        depositsData: depositsData,
        exchangeRatesData: exchangeRatesData,
        loansData: loansData,
        p2pTemplatesData: p2pTemplatesData,
      ),
      TransactionScreen(),
      HistoryScreen(
        historyData: refreshHistory(),
      ),
      ServiceScreen(
        isBackButtonEnabled: false,
      ),
    ];
    return BaseView(
      viewModal: BottomNavBarScreen,
      onPageBuilder: (context, widget) {
        return SwipeInGoBack(
            child: Scaffold(
              body: RefreshIndicator(
                onRefresh: () async {
                  if (context.homePr.currentIndex == 0) {
                    return refreshBalance().then((value) {
                      setState(() {});
                    });
                  } else if (context.homePr.currentIndex == 2) {
                    return refreshHistory().then((value) {
                      setState(() {});
                    });
                  } else {
                    return data();
                  }
                },
                child: list[context.homePrStreem.currentIndex],
              ),
              bottomNavigationBar: Container(
                color: ColorConst.instance.kBottomNavBarColor,
                height: 94.h,
                width: double.infinity,
                child: BottomNavigationBar(
                  currentIndex: context.homePrStreem.currentIndex,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: ColorConst.instance.kBottomNavBarColor,
                  elevation: 0,
                  selectedItemColor: ColorConst.instance.kGreenColor,
                  selectedLabelStyle:
                      FontstyleText.instance.bottomNavBarAbleText,
                  unselectedItemColor: ColorConst.instance.kSecondaryTextColor,
                  unselectedLabelStyle:
                      FontstyleText.instance.bottomNavBarDisableText,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      label: "main".locale,
                      icon: SvgPicture.asset(
                          ImageConst.instance.toSvg("home_disable")),
                      activeIcon: SvgPicture.asset(
                          ImageConst.instance.toSvg("home_able")),
                    ),
                    BottomNavigationBarItem(
                      label: "transfers".locale,
                      icon: SvgPicture.asset(
                          ImageConst.instance.toSvg("exchange_disable")),
                      activeIcon: SvgPicture.asset(
                          ImageConst.instance.toSvg("exchange_able")),
                    ),
                    BottomNavigationBarItem(
                      label: "history".locale,
                      icon: SvgPicture.asset(
                          ImageConst.instance.toSvg("clock_disable")),
                      activeIcon: SvgPicture.asset(
                          ImageConst.instance.toSvg("clock_able")),
                    ),
                    BottomNavigationBarItem(
                      label: "services".locale,
                      icon: SvgPicture.asset(
                          ImageConst.instance.toSvg("services_disable")),
                      activeIcon: SvgPicture.asset(
                          ImageConst.instance.toSvg("services_able")),
                    ),
                  ],
                  onTap: (v) async {
                    if (v == 1) {
                      // isStartStoryPage ? null :
                      // refreshHistory();
                      context.transactionsPr.transferHomePageData = false;
                    }
                    context.homePr.changePage(v);
                  },
                ),
              ),
            ),
            onWillPop: () async {
              await context.homePr.changePage(0);
              return await false;
            });
      },
    );
  }

  Future<List<HistoryOperation>> refreshHistory() async {
    isStartStoryPage = true;
    return await context.historyPr.cardsOperations(context);
  }

  Future<void> data() async {
    //
    accountsData = context.homePr.getAccounts(context);

    clientCardsData = context.homePr.getClientCards(context, false);

    clientNameData = context.homePr.getClientName(context);

    p2pTemplatesData = context.homePr.getP2pTemplates(context);

    depositsData = context.homePr.getDeposits(context);

    loansData = context.homePr.getLoans(context);

    exchangeRatesData = context.homePr.getExchangeRates(context);
  }

  Future<CardsBalancesModel> refreshBalance() async {
    return await context.homePr.postClientBalances(context);
  }

  Future<P2PTemplatesModel> p2pTempletesData() async {
    return await context.homePr.getP2pTemplates(context);
  }
}
