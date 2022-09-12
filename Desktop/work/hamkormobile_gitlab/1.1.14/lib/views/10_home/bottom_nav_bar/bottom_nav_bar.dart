import 'dart:async';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
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
import 'package:mobile/models/p2p_templates_model.dart';
import 'package:mobile/provider/9_home_provider.dart';
import 'package:mobile/provider/lock_timer_provider.dart';
import 'package:mobile/views/10_home/service/service_screen.dart';
import 'package:mobile/views/12_story/story_screen.dart';
import 'package:mobile/views/13_transactions/transactions_screen.dart';
import 'package:mobile/core/extensions/context_extension.dart';

import 'package:provider/provider.dart';
import '../../../service/firebase/performance/performance_service.dart';
import '../main_screen.dart';

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
    context.homePr.currentIndex = 0;
    context.homePr.erorLength = 0;
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

  Future<ClientNameModel>? clientNameData;
  Future<ClientCardsModel>? clientCardsData;
  Future<P2PTemplatesModel>? p2pTemplatesData;
  Future<AccountsModel>? accountsData;
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
      )
    ];

    return BaseView(
      viewModal: BottomNavBarScreen,
      onPageBuilder: (context, widget) {
        return WillPopScope(
            child: Scaffold(
              body: RefreshIndicator(
                onRefresh: () async {
                  if (context.homePr.currentIndex == 0) {
                    return refreshData().then((value) {
                      setState(() {
                      });
                    });
                  } else if (context.homePr.currentIndex == 2) {
                    return refreshHistory().then((value) {
                      setState(() {
                      });
                    });
                  } else {
                    return data();
                  }
                },
                child: list[context.homePrStreem.currentIndex],
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: context.homePrStreem.currentIndex,
                type: BottomNavigationBarType.fixed,
                backgroundColor: ColorConst.instance.kBottomNavBarColor,
                elevation: 0,
                selectedItemColor: ColorConst.instance.kGreenColor,
                selectedLabelStyle: FontstyleText.instance.bottomNavBarAbleText,
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
                  if (v == 2) {
                    isStartStoryPage ? null : await refreshHistory();
                  }
                  context.homePr.changePage(v);
                },
              ),
            ),
            onWillPop: () async {
              context.homePr.changePage(0);
              return false;
            });
      },
    );
  }

  Future<histoy.HistoryModel> refreshHistory() async {
    isStartStoryPage = true;
    return await context.historyPr.postHistory(context);
  }

  Future<void> data() async {
    clientNameData = context.homePr.getClientName(context);
    clientCardsData = context.homePr.getClientCards(context);
    p2pTemplatesData = context.homePr.getP2pTemplates(context);
    accountsData = context.homePr.getAccounts(context);
    depositsData = context.homePr.getDeposits(context);
    loansData = context.homePr.getLoans(context);
    exchangeRatesData = context.homePr.getExchangeRates(context);
  }

  Future<CardsBalancesModel> refreshData() async {
    return await context.homePr.postClientBalances(context);
  }

  Future<P2PTemplatesModel> p2pTempletesData() async {
    return await context.homePr.getP2pTemplates(context);
  }
}
