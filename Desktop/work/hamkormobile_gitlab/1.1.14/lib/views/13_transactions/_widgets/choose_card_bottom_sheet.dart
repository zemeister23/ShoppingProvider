import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_input_formatter/mask_input_formatter.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/images/image_const.dart';
import 'package:mobile/core/constants/images/card_bank_logo.dart';
import 'package:mobile/core/constants/inputformater/input_formater.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/models/client_cards_model.dart';
import 'package:mobile/models/translations_model.dart';
import 'package:mobile/provider/10_transactions_provider.dart';
import 'package:mobile/provider/lock_timer_provider.dart';
import 'package:mobile/views/10_home/_widgets/_divider_widget.dart';
import 'package:mobile/views/10_home/_widgets/_list_tile.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svgp;
import 'package:provider/provider.dart';

class BottomSheets {
  static bool isKeyboardShown = false;

  static chooseCard(BuildContext context, ClientCardsModel data) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(context.h * 0.025),
        ),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          top: false,
          bottom: true,
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Positioned(
                top: -context.h * 0.06,
                right: context.w * 0.05,
                child: SvgPicture.asset(
                  ImageConst.instance.toSvg("cancel"),
                  color: ColorConst.instance.kButtonColor,
                  width: context.h * 0.04,
                  height: context.h * 0.04,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: context.h * 0.02),
                  Center(
                    child: Image.asset(
                      ImageConst.instance.toPng("divider"),
                    ),
                  ),
                  SizedBox(height: context.h * 0.025),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.w * 0.04,
                    ),
                    child: Text(
                      "select_debite_card".locale,
                      style: context.theme.headline4,
                    ),
                  ),
                  SizedBox(height: context.h * 0.025),
                  SizedBox(
                    height: data.data!.cards!.length >= 4
                        ? context.h * 0.4
                        : context.h * (data.data!.cards!.length / 10),
                    child: ListView.separated(
                      itemCount: data.data!.cards!.length,
                      physics: data.data!.cards!.length <= 4
                          ? const NeverScrollableScrollPhysics()
                          : const BouncingScrollPhysics(),
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          color: ColorConst.instance.kElementsColor,
                          thickness: 1,
                          height: 0,
                          indent: context.w * 0.04,
                          endIndent: context.w * 0.04,
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return ListTileW(
                          onTab: () {
                            if (context.transactionsPr.cardsState != index) {
                              context.transactionsPr.controllerAmount.clear();
                              context.transactionsPr.summa == "";
                              context.transactionsPr.commissionSum = null;
                            }
                            context.transactionsPr.changeCardState(index);
                            Navigator.pop(context);
                          },
                          leading: Container(
                            width: context.w * 0.13,
                            height: context.h * 0.05,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    whichLogoBankHomePage(data
                                        .data!.cards![index].mfo
                                        .toString()),
                                  ),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          title: Text(
                            data.data!.cards![index].cardType.toString() ==
                                    "private"
                                ? "main_card".locale
                                : "pension".locale,
                            style: context.theme.caption,
                          ),
                          trailing: AutoSizeText(
                            context.homePr.changeAllText(
                                data.data!.cards![index].balance.toString()),
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
                                data.data!.cards![index].psCode == "UZCARD"
                                    ? ImageConst.instance.toSvg("uzcard")
                                    : ImageConst.instance.toSvg("humo"),
                              ),
                              Text(
                                context.homePr.smallCardNumber(data
                                    .data!.cards![index].maskNum
                                    .toString()),
                                style: FontstyleText
                                    .instance.mainPageMultiWithUzcard,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static specifyCard(
      BuildContext context, TransactionModel data2, ClientCardsModel data) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(context.h * 0.025),
        ),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          top: false,
          bottom: true,
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Positioned(
                top: -context.h * 0.06,
                right: context.w * 0.05,
                child: SvgPicture.asset(
                  ImageConst.instance.toSvg("cancel"),
                  color: ColorConst.instance.kButtonColor,
                  width: context.h * 0.04,
                  height: context.h * 0.04,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: context.w * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: context.h * 0.02),
                          Center(
                            child: Image.asset(
                              ImageConst.instance.toPng("divider"),
                            ),
                          ),
                          SizedBox(height: context.h * 0.025),
                          Text(
                            "specify_the_card_to_transfer".locale,
                            style: context.theme.headline4,
                          ),
                          SizedBox(height: context.h * 0.025),
                          SizedBox(
                            height: context.h * 0.095,
                            child: TextFormField(
                              inputFormatters: [
                                MaskInputFormatter(mask: '#### #### #### ####'),
                              ],
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                color: ColorConst.instance.kMainTextColor,
                                fontSize: FontSizeConst.instance.inputnumber,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: ColorConst.instance.kBackgroundColor,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: context.h * 0.01,
                                  horizontal: context.w * 0.03,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(
                                    context.h * 0.01,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(
                                    context.h * 0.01,
                                  ),
                                ),
                              ),
                              onChanged: (v) async {
                                Provider.of<LockProvider>(context,
                                        listen: false)
                                    .initializeTimer();

                                if (v.length == 19) {
                                  //  Navigator.pop(context);
                                  await context.transactionsPr
                                      .getP2pInfo(v, context);
                                }
                              },
                              onTap: () {
                                isKeyboardShown = true;
                              },
                              onEditingComplete: () {
                                isKeyboardShown = false;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        height: isKeyboardShown
                            ? data2.data!.length == 0
                                ? 0
                                : context.h * 0.2
                            : data2.data!.length >= 4
                                ? context.h * 0.4
                                : context.h * (data2.data!.length / 10),
                        child: ListView.separated(
                            physics: data2.data!.length <= 4
                                ? const NeverScrollableScrollPhysics()
                                : const BouncingScrollPhysics(),
                            itemCount: data2.data!.length,
                            separatorBuilder: (context, index) {
                              return Divider(
                                color: ColorConst.instance.kElementsColor,
                                thickness: 1,
                                height: 0,
                                indent: context.w * 0.04,
                                endIndent: context.w * 0.04,
                              );
                            },
                            itemBuilder: (context, index) {
                              var senderCard = data.data!.cards![
                                  context.transactionPrStream.cardsState];
                              var reciverCard = data2.data![index].receiver!;
                              if (senderCard.psCode == reciverCard.psCode &&
                                  senderCard.owner == reciverCard.owner &&
                                  senderCard.cardId == reciverCard.id) {
                                return SizedBox();
                              } else if (senderCard.cardId == reciverCard.id &&
                                  senderCard.psCode == reciverCard.psCode) {
                                return SizedBox();
                              } else {
                                return ListTileW(
                                  onTab: () {
                                    context.transactionsPr.controllerAmount
                                        .clear();
                                    if (index !=
                                        context
                                            .transactionsPr.cartCurrentIndex) {
                                      context.transactionsPr.summa == "";
                                      context.transactionsPr.commissionSum =
                                          null;
                                    }
                                    context.transactionsPr
                                        .changeTransferHomePageData(false);
                                    context.transactionsPr
                                        .changeTransferCard(index);
                                    Navigator.pop(context);
                                  },
                                  leading: Container(
                                    width: context.w * 0.13,
                                    height: context.h * 0.05,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                            whichLogoBankHomePage(data2
                                                .data![index].receiver!.bankCode
                                                .toString()),
                                          ),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  title: Text(
                                    data2.data![index].receiver!.owner
                                        .toString(),
                                    style: context.theme.caption,
                                  ),
                                  isTrailingCurrency: false,
                                  subTitle: Row(
                                    children: <Widget>[
                                      Text(
                                        "transfer_to_card".locale + " ",
                                        style: FontstyleText
                                            .instance.mainPageMultiWithUzcard,
                                      ),
                                      SvgPicture.asset(
                                        data2.data![index].receiver!.psCode ==
                                                "UZCARD"
                                            ? ImageConst.instance
                                                .toSvg("uzcard")
                                            : ImageConst.instance.toSvg("humo"),
                                      ),
                                      Text(
                                        context.homePr.smallCardNumber(data2
                                            .data![index].receiver!.pan
                                            .toString()),
                                        style: FontstyleText
                                            .instance.mainPageMultiWithUzcard,
                                      ),
                                    ],
                                  ),
                                );
                              }
                            })),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static enteringTransferAmount(
      BuildContext context, ClientCardsModel data, TransactionModel data2) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(context.h * 0.025),
        ),
      ),
      builder: (BuildContext context) {
        dynamic t = context.transactionsPr.controllerAmount.text.split(" ");
        String transfer = "";
        t.forEach((element) {
          transfer += element;
        });
        t = transfer.split("UZS")[0].trim();
        return Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Positioned(
              top: -context.h * 0.06,
              right: context.w * 0.05,
              child: SvgPicture.asset(
                ImageConst.instance.toSvg("cancel"),
                color: ColorConst.instance.kButtonColor,
                width: context.h * 0.04,
                height: context.h * 0.04,
              ),
            ),
            SafeArea(
              top: false,
              bottom: true,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  context.w * 0.04,
                  0,
                  context.w * 0.04,
                  MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  //  color: Colors.red,
                  height: 99.h,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          //   SizedBox(width: 10.w),
                          SizedBox(
                              width: context.transactionsPr.controllerAmount
                                          .text.length ==
                                      0
                                  ? 48.w
                                  : 48.w +
                                      context.transactionsPr.controllerAmount
                                              .text.length *
                                          15.0.w,
                              child: TextFormField(
                                controller: context
                                    .transactionPrStream.controllerAmount,
                                autofocus: true,
                                maxLength: 15,
                                onChanged: (String tarnsferPrivice) {
                                  context.transactionsPr.changeAmount(
                                      tarnsferPrivice, data, context);
                                },
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  color: context.transactionsPr.inputColor,
                                  fontSize:
                                      FontSizeConst.instance.mainPageUZSSize,
                                  fontWeight: FontWeight.w600,
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  CurrencyFormat(),
                                  MoneyInputFormatter(
                                    //   trailingSymbol: " UZS",
                                    mantissaLength: 0,
                                    maxTextLength: 0,
                                    thousandSeparator: ThousandSeparator
                                        .SpaceAndPeriodMantissa,
                                  )
                                ],
                                decoration: InputDecoration(
                                  counterText: "",
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  suffixText: " UZS",
                                  suffixStyle: TextStyle(
                                    color:
                                        context.transactionPrStream.inputColor,
                                    fontSize: FontSizeConst.instance.extraLarge,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )),
                          const Spacer(),
                          Container(
                            width: 40.w,
                            height: 40.w,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xFF82D66E),
                                  Color(0xFF499A36),
                                ],
                              ),
                            ),
                            child: IconButton(
                              icon: SvgPicture.asset(
                                  ImageConst.instance.arrow_forward),
                              onPressed: (context.transactionsPr
                                              .controllerAmount.text.length >
                                          2 &&
                                      int.parse(t) >= 500 &&
                                      int.parse(t) <= 135000000)
                                  ? () {
                                      context.transactionsPr
                                          .transferIncompatible(
                                              context, false, true);
                                      if (context.transactionsPr.isValid) {
                                        context.transactionsPr
                                            .postPaymentValidate(
                                                data, data2, context);
                                        Provider.of<LockProvider>(context,
                                                listen: false)
                                            .initializeTimer();
                                      } else {
                                        if (int.parse(t) <= 500) {
                                          context.transactionsPr
                                              .transferIncompatible(
                                                  context, true, true);
                                        } else {
                                          context.transactionsPr
                                              .transferIncompatible(
                                                  context, true, false);
                                        }
                                      }
                                    }
                                  : () {
                                      if (int.parse(t) <= 500) {
                                        context.transactionsPr
                                            .transferIncompatible(
                                                context, true, true);
                                      } else {
                                        context.transactionsPr
                                            .transferIncompatible(
                                                context, true, false);
                                      }
                                    },
                              color: ColorConst.instance.kButtonColor,
                            ),
                          ),
                        ],
                      ),
                      context.transactionsPr.moneyNotCompatible
                          ? Text(
                              context.transactionPrStream.isMinimumTransfer
                                  ? "minimum_money_transfer".locale
                                  : "not_funt_transfer".locale,
                              style: TextStyle(
                                  color: ColorConst.instance.kErrorColor),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
    // showModalBottomSheet(context: context, builder: (v) {},);
  }
}
