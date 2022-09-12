import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobile/core/base/view/base_view.dart';
import 'package:mobile/core/components/loading/loading_page.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/images/image_const.dart';
import 'package:mobile/core/constants/images/card_bank_logo.dart';
import 'package:mobile/core/constants/sizeconst/size_const.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/models/client_cards_model.dart';
import 'package:mobile/models/p2p_info_model.dart';
import 'package:mobile/models/p2p_init_model.dart';
import 'package:mobile/models/p2p_last_model.dart';
import 'package:mobile/models/translations_model.dart';
import 'package:mobile/provider/10_transactions_provider.dart';
import 'package:mobile/views/10_home/_widgets/_list_tile.dart';
import 'package:mobile/views/10_home/container_decoration.dart';
import 'package:mobile/views/13_transactions/_widgets/choose_card_bottom_sheet.dart';
import 'package:mobile/widgets/appbar/default_appbar.dart';
import 'package:mobile/widgets/dialogs/error_dialog.dart';
import 'package:mobile/widgets/gradient_button_widget.dart';
import 'package:provider/provider.dart';

import '../../provider/check_pass_code_provider.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TranslationsScreenState();
}

class _TranslationsScreenState extends State<TransactionScreen> {
  late final Future<ClientCardsModel> getClientCards;
  late final Future<TransactionModel> getTransaction;
  int indexSenderCard = 0;
  @override
  void initState() {
    context.transactionsPr.initState();
    Provider.of<CheckPassCodeProvider>(context, listen: false)
        .changeIsPopToTrue;
    getClientCards = context.homePr.getClientCards(context);
    getTransaction = context.transactionsPr.getTranlations(context);
    super.initState();
  }

  late TransactionsProivder trProvider;
  late CheckPassCodeProvider passProvider;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    trProvider = context.transactionsPr;
    passProvider = Provider.of<CheckPassCodeProvider>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();
    trProvider.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        viewModal: TransactionScreen,
        onPageBuilder: (context, state) {
          return WillPopScope(
              child: Scaffold(
                appBar: DefaultAppbar.getAppBar(
                  "transfer".locale,
                  () {
                    Navigator.pop(context);
                  },
                  context,
                  true,
                ),
                body: FutureBuilder(
                  future: Future.wait([
                    getClientCards,
                    getTransaction,
                  ]),
                  builder: ((context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return LoadingPage(true);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else {
                      ClientCardsModel data =
                          (snapshot.data[0] as ClientCardsModel);
                      TransactionModel data2 =
                          (snapshot.data[1] as TransactionModel);
                      //  bool transferHomePageData =   context.transactionPrStream.transferHomePageData;
                      if (data.data!.cards!.isEmpty && data2.data!.isEmpty) {
                        return Center(
                          child: ErrorDialog(
                            title: "",
                            subtitle: "",
                            buttonTextBottom: "Back To Home Page",
                          ),
                        );
                      }
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConst.instance.horizPadding,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Spacer(flex: 1),
                            Container(
                              width: double.infinity,
                              decoration: ContainerDecorationComp
                                  .containerWithoutShadow(context),
                              child: Column(
                                children: <Widget>[
                                  senderCard(context, data,data2),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      SvgPicture.asset(
                                        ImageConst.instance
                                            .toSvg("double_arrow_down"),
                                      ),
                                      SizedBox(
                                        width: context.w * 0.7,
                                        child: Divider(
                                          height: 0,
                                          thickness: 1,
                                          color: ColorConst
                                              .instance.kElementsColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  spesifyCard(
                                    context,
                                    data2,
                                    data,
                                  )
                                ],
                              ),
                            ),
                            const Spacer(flex: 5),
                            Padding(
                              padding: EdgeInsets.only(
                                left: context.w * 0.03,
                                bottom: context.h * 0.015,
                              ),
                              child: Text(
                                context.transactionPrStream.erorText,
                                style: TextStyle(
                                  color: ColorConst.instance.kErrorColor,
                                  fontSize: FontSizeConst.instance.small,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            //  : const SizedBox(),
                            InkWell(
                              onTap: () {
                                if (context.transactionsPr.transferEmty != 0 ||
                                    context
                                        .transactionsPr.transferHomePageData) {
                                  BottomSheets.enteringTransferAmount(
                                    context,
                                    data,
                                    data2,
                                  );
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                height: context.h * 0.065,
                                padding:
                                    EdgeInsets.only(left: context.w * 0.03),
                                alignment: Alignment.centerLeft,
                                decoration:
                                    ContainerDecorationComp.containerShadow(
                                        context),
                                child: Text(
                                  context.transactionPrStream.commissionSum ==
                                          null
                                      ? "amount"
                                          .locale
                                          .replaceAll("NUMBER", "0")
                                      : context.transactionPrStream.summa,
                                  style: TextStyle(
                                    color: context
                                            .transactionPrStream.summaState
                                        ? ColorConst.instance.kMainTextColor
                                        : ColorConst.instance.kElementsColor,
                                    fontSize: FontSizeConst.instance.large,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: context.w * 0.03,
                                  vertical: context.h * 0.005),
                              child: Text(
                                context.transactionPrStream.commissionSum ==
                                        null
                                    ? "transactions_info".locale
                                    : "commission".locale +
                                        " " +
                                        context
                                            .transactionPrStream.commissionSum
                                            .toString() +
                                        " UZS",
                                style: FontstyleText
                                    .instance.bottomNavBarDisableText,
                              ),
                            ),
                            const Spacer(flex: 5),
                            GradientButton(
                              colorOpacity:
                                  (context.transactionPrStream.transferEmty !=
                                                  0 ||
                                              context.transactionPrStream
                                                  .transferHomePageData) &&
                                          (context.transactionPrStream.amount
                                                  .value !=
                                              null) &&
                                          context.transactionPrStream
                                                  .commissionSum !=
                                              null &&
                                          context
                                              .transactionsPr.erorText.isEmpty
                                      ? true
                                      : false,
                              width: double.infinity,
                              height: context.h * 0.07,
                              text: context.transactionPrStream.commissionSum ==
                                          null ||
                                      context.transactionPrStream.erorText
                                          .isNotEmpty
                                  ? "continue".locale
                                  : context.homePr.changeAllText(context
                                          .transactionPrStream.totalSum
                                          .toString()) +
                                      " UZS " +
                                      "transfer2".locale,
                              onPressed: (context.transactionPrStream
                                                  .transferEmty !=
                                              0 ||
                                          context.transactionPrStream
                                              .transferHomePageData) &&
                                      (context.transactionPrStream.amount
                                              .value !=
                                          null) &&
                                      context.transactionPrStream
                                              .commissionSum !=
                                          null
                                  ? () async {
                                      if (context
                                                  .transactionsPr
                                                  .responseP2pValidate
                                                  .data!
                                                  .isConfirm ==
                                              false &&
                                          context.transactionsPr.transactId
                                              .isNotEmpty &&
                                          context.transactionsPr.erorText
                                              .isEmpty) {
                                        context.loaderOverlay.show();
                                        context.transactionsPr
                                            .postPaymentConfirm(context, "");
                                      } else {
                                        if (context
                                            .transactionsPr.erorText.isEmpty) {
                                          context.loaderOverlay.show();
                                          context.transactionsPr
                                              .postP2pInit(context);
                                        }
                                      }
                                    }
                                  : null,
                            ),
                            const Spacer(flex: 1),
                          ],
                        ),
                      );
                    }
                  }),
                ),
              ),
              onWillPop: () async {
                await context.homePr.changePage(0);

                return true;
              });
        });
  }

  senderCard(BuildContext context, ClientCardsModel data, TransactionModel data2) {
    if(context.transactionPrStream.transferHomePageData){
 var senderData = context.transactionPrStream.homeData.data![context.transactionPrStream.homeDataIndex];
 
    for (var i = 0; i < data.data!.cards!.length; i++) {
      if(senderData.sender!.id == data.data!.cards![i].cardId){
        return ListTile(
      dense: true,
      onTap: () {
        BottomSheets.chooseCard(context, data);
      },
      horizontalTitleGap: context.w * 0.03,
      minLeadingWidth: context.w * 0.03,
      contentPadding: EdgeInsets.symmetric(
        horizontal: context.w * 0.03,
      ),
      leading: Container(
        width: context.w * 0.13,
        height: context.h * 0.05,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                whichLogoBankHomePage(data
                    .data!.cards![i].mfo
                    .toString()),
              ),
              fit: BoxFit.cover),
          //  color: ColorConst.instance.kRedColor,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            data.data!.cards![i].cardType
                        .toString() ==
                    "private"
                ? "main_card".locale
                : "pension".locale,
            style: context.theme.caption,
          ),
          SizedBox(width: context.w * 0.015),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AutoSizeText(
                  context.homePr.changeAllText(
                    data.data!.cards![i]
                        .balance
                        .toString(),
                  ),
                  textAlign: TextAlign.end,
                  style: context.theme.caption,
                ),
                AutoSizeText(
                  " UZS",
                  textAlign: TextAlign.end,
                  style: context.theme.caption!.copyWith(
                    fontSize: FontSizeConst.instance.small + 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      subtitle: Row(
        children: <Widget>[
          SvgPicture.asset(data.data!
                      .cards![i].psCode ==
                  "UZCARD"
              ? ImageConst.instance.toSvg("uzcard")
              : ImageConst.instance.toSvg("humo")),
          Text(
            " " +
                context.homePr.smallCardNumber(data.data!
                    .cards![i].maskNum
                    .toString()),
            style: FontstyleText.instance.mainPageMultiWithUzcard,
          ),
        ],
      ),
      trailing: data.data!.cards!.length > 1
          ? Icon(
              Icons.keyboard_arrow_down_rounded,
              color: ColorConst.instance.kElementsColor,
            )
          : SizedBox(),
    );
  
      }
      else{
        return ListTile(
      dense: true,
      onTap: () {
        BottomSheets.chooseCard(context, data);
      },
      horizontalTitleGap: context.w * 0.03,
      minLeadingWidth: context.w * 0.03,
      contentPadding: EdgeInsets.symmetric(
        horizontal: context.w * 0.03,
      ),
      leading: Container(
        width: context.w * 0.13,
        height: context.h * 0.05,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                whichLogoBankHomePage(data
                    .data!.cards![context.transactionPrStream.cardsState].mfo
                    .toString()),
              ),
              fit: BoxFit.cover),
          //  color: ColorConst.instance.kRedColor,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            data.data!.cards![context.transactionPrStream.cardsState].cardType
                        .toString() ==
                    "private"
                ? "main_card".locale
                : "pension".locale,
            style: context.theme.caption,
          ),
          SizedBox(width: context.w * 0.015),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AutoSizeText(
                  context.homePr.changeAllText(
                    data.data!.cards![context.transactionPrStream.cardsState]
                        .balance
                        .toString(),
                  ),
                  textAlign: TextAlign.end,
                  style: context.theme.caption,
                ),
                AutoSizeText(
                  " UZS",
                  textAlign: TextAlign.end,
                  style: context.theme.caption!.copyWith(
                    fontSize: FontSizeConst.instance.small + 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      subtitle: Row(
        children: <Widget>[
          SvgPicture.asset(data.data!
                      .cards![context.transactionPrStream.cardsState].psCode ==
                  "UZCARD"
              ? ImageConst.instance.toSvg("uzcard")
              : ImageConst.instance.toSvg("humo")),
          Text(
            " " +
                context.homePr.smallCardNumber(data.data!
                    .cards![context.transactionPrStream.cardsState].maskNum
                    .toString()),
            style: FontstyleText.instance.mainPageMultiWithUzcard,
          ),
        ],
      ),
      trailing: data.data!.cards!.length > 1
          ? Icon(
              Icons.keyboard_arrow_down_rounded,
              color: ColorConst.instance.kElementsColor,
            )
          : SizedBox(),
    );
  
      }

      
    }
  
  
    }
   
  else{
      return ListTile(
      dense: true,
      onTap: () {
        BottomSheets.chooseCard(context, data);
      },
      horizontalTitleGap: context.w * 0.03,
      minLeadingWidth: context.w * 0.03,
      contentPadding: EdgeInsets.symmetric(
        horizontal: context.w * 0.03,
      ),
      leading: Container(
        width: context.w * 0.13,
        height: context.h * 0.05,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                whichLogoBankHomePage(data
                    .data!.cards![context.transactionPrStream.cardsState].mfo
                    .toString()),
              ),
              fit: BoxFit.cover),
          //  color: ColorConst.instance.kRedColor,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            data.data!.cards![context.transactionPrStream.cardsState].cardType
                        .toString() ==
                    "private"
                ? "main_card".locale
                : "pension".locale,
            style: context.theme.caption,
          ),
          SizedBox(width: context.w * 0.015),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AutoSizeText(
                  context.homePr.changeAllText(
                    data.data!.cards![context.transactionPrStream.cardsState]
                        .balance
                        .toString(),
                  ),
                  textAlign: TextAlign.end,
                  style: context.theme.caption,
                ),
                AutoSizeText(
                  " UZS",
                  textAlign: TextAlign.end,
                  style: context.theme.caption!.copyWith(
                    fontSize: FontSizeConst.instance.small + 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      subtitle: Row(
        children: <Widget>[
          SvgPicture.asset(data.data!
                      .cards![context.transactionPrStream.cardsState].psCode ==
                  "UZCARD"
              ? ImageConst.instance.toSvg("uzcard")
              : ImageConst.instance.toSvg("humo")),
          Text(
            " " +
                context.homePr.smallCardNumber(data.data!
                    .cards![context.transactionPrStream.cardsState].maskNum
                    .toString()),
            style: FontstyleText.instance.mainPageMultiWithUzcard,
          ),
        ],
      ),
      trailing: data.data!.cards!.length > 1
          ? Icon(
              Icons.keyboard_arrow_down_rounded,
              color: ColorConst.instance.kElementsColor,
            )
          : SizedBox(),
    );
  
  
  }

  }

  Widget spesifyCard(BuildContext context, TransactionModel data2,
      ClientCardsModel senderCard) {
    if (context.transactionPrStream.transferHomePageData) {
      var data = context.transactionPrStream.homeData
          .data![context.transactionPrStream.homeDataIndex];
      return ListTileW(
        onTab: () => BottomSheets.specifyCard(context, data2, senderCard),
        leading: Container(
          width: context.w * 0.13,
          height: context.h * 0.05,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  whichLogoBankHomePage(data.receiver!.pan.toString()),
                ),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        title: Text(
          data.receiver!.owner.toString() + "",
          style: context.theme.caption,
        ),
        isTrailingCurrency: false,
        isArrowDownIcon: true,
        subTitle: Row(
          children: <Widget>[
            Text(
              "transfer_to_card".locale + " ",
              style: FontstyleText.instance.mainPageMultiWithUzcard,
            ),
            SvgPicture.asset(data.receiver!.psCode == "UZCARD"
                ? ImageConst.instance.toSvg("uzcard")
                : ImageConst.instance.toSvg("humo")),
            Text(
              context.homePr
                  .smallCardNumber(" " + data.receiver!.pan.toString()),
              style: FontstyleText.instance.mainPageMultiWithUzcard,
            ),
          ],
        ),
      );
    }


    if (context.transactionsPr.transferEmty == 0) {
      // reciver cart not
      return ListTile(
        dense: true,
        onTap: () {
          BottomSheets.specifyCard(context, data2, senderCard);
        },
        horizontalTitleGap: context.w * 0.03,
        minLeadingWidth: context.w * 0.03,
        contentPadding: EdgeInsets.symmetric(
          horizontal: context.w * 0.03,
          vertical: context.h * 0.01,
        ),
        leading: Container(
          width: context.w * 0.13,
          height: context.h * 0.05,
          decoration: BoxDecoration(
            color: ColorConst.instance.kBackgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.add,
            color: ColorConst.instance.kElementsColor,
            size: FontSizeConst.instance.mainPageUZSSize,
          ),
        ),
        title: Text(
          "specify_card".locale,
          style: context.theme.caption,
        ),
        trailing: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: ColorConst.instance.kElementsColor,
        ),
      );
    } else if (context.transactionsPr.transferEmty == 1) {
      return ListTileW(
        onTab: () {
          BottomSheets.specifyCard(context, data2, senderCard);
          context.transactionsPr
              .changeCardCurentIndex(context.transactionsPr.transferCardStare);
        },
        leading: Container(
          width: context.w * 0.13,
          height: context.h * 0.05,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  whichLogoBankHomePage(data2
                      .data![context.transactionPrStream.transferCardStare]
                      .receiver!
                      .bankCode
                      .toString()),
                ),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        title: Text(
          data2.data![context.transactionPrStream.transferCardStare].receiver!
              .owner
              .toString(),
          style: context.theme.caption,
        ),
        isTrailingCurrency: false,
        isArrowDownIcon: true,
        subTitle: Row(
          children: <Widget>[
            Text(
              "transfer_to_card".locale + " ",
              style: FontstyleText.instance.mainPageMultiWithUzcard,
            ),
            SvgPicture.asset(data2
                        .data![context.transactionPrStream.transferCardStare]
                        .receiver!
                        .psCode ==
                    "UZCARD"
                ? ImageConst.instance.toSvg("uzcard")
                : ImageConst.instance.toSvg("humo")),
            Text(
              context.homePr.smallCardNumber(data2
                  .data![context.transactionPrStream.transferCardStare]
                  .receiver!
                  .pan
                  .toString()),
              style: FontstyleText.instance.mainPageMultiWithUzcard,
            ),
          ],
        ),
      );
    } else {
      P2PInfoModel _data = context.transactionsPr.responseP2pInfo;
      return ListTileW(
        onTab: () {
          BottomSheets.specifyCard(context, data2, senderCard);
        },
        leading: Container(
          width: context.w * 0.13,
          height: context.h * 0.05,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                whichLogoBankHomePage(_data.data!.bankCode.toString()),
              ),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        title: Text(
          _data.data!.owner.toString(),
          style: context.theme.caption,
        ),
        isTrailingCurrency: false,
        isArrowDownIcon: true,
        subTitle: Row(
          children: <Widget>[
            Text(
              "transfer_to_card".locale + " ",
              style: FontstyleText.instance.mainPageMultiWithUzcard,
            ),
            data2.data!.isNotEmpty
                ? SvgPicture.asset(
                    _data.data!.processing.toString().trim() == "UZCARD"
                        ? ImageConst.instance.toSvg("uzcard")
                        : ImageConst.instance.toSvg("humo"))
                : SvgPicture.asset(ImageConst.instance.toSvg("uzcard")),
            Text(
              context.homePr.smallCardNumber(" " + _data.data!.pan.toString()),
              style: FontstyleText.instance.mainPageMultiWithUzcard,
            ),
          ],
        ),
      );
    }
  }
}
