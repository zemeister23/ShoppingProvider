import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/base/state/base_state.dart';
import 'package:mobile/core/base/view/base_view.dart';
import 'package:mobile/core/components/loading/loading_page.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/widgets/appbar/default_appbar.dart';
import 'package:provider/provider.dart';
import '../../provider/3_sms_provider.dart';
import '../../provider/check_pass_code_provider.dart';
import '../../widgets/3_smscode/send-again.dart';
import '../../widgets/3_smscode/sms_code_form.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';

class SmsTransactionsScreen extends StatefulWidget {
  const SmsTransactionsScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SmsTransactionsScreenState createState() => _SmsTransactionsScreenState();
}

class _SmsTransactionsScreenState extends BaseState<SmsTransactionsScreen>
    with WidgetsBindingObserver {
  TextEditingController textEditingController = TextEditingController();
  bool hasError = false;
  String currentText = "";
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late Timer timer;
  late String telNumber;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.smsPr.init();
    context.smsPr.initState(context, false);
    context.smsPr.isSendAgainLoading = false;
    context.smsPr.sendMassageActiv = true;
    context.phoneRegisterPr.clearPhoneNumber();
    Provider.of<CheckPassCodeProvider>(context, listen: false)
        .changeIsPopToTrue;
    telNumber = GetStorageService.instance.box
        .read(GetStorageService.instance.uiTelNomer);
  }

  late SmsProvider _smsProvider;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _smsProvider = context.smsPr;
  }

  @override
  void dispose() {
    super.dispose();
    _smsProvider.disposee();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      context.smsPr.resumeApp();

      setState(() {});
    }
    if (state == AppLifecycleState.paused) {
      context.smsPr.pausedApp();
      setState(() {});
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    SmsProvider myProvider = context.watch<SmsProvider>();
    return Scaffold(
      body: context.transactionsPr.loading
          ? LoadingPage(true)
          : GestureDetector(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.h * 0.02),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Spacer(flex: 3),
                    Text("p2p_sms".locale, style: context.theme.headline1),
                    const Spacer(flex: 7),
                    Text(
                      "+998 " +
                          telNumber +
                          " " +
                          "enter_the_code".locale.replaceAll("NUMBER", ""),
                      style: context.theme.subtitle2,
                    ),
                    const Spacer(flex: 5),
                    SmsCodeForm(
                      formKey: formKey,
                      textEditingController: textEditingController,
                      smsRegisterPage: false,
                      smsTransactionsPage: true,
                      addCardPage: false,
                    ),
                    textCapasity(myProvider),
                    myProvider.capacity > 0
                        ? Text(
                            myProvider.erorText,
                            style: TextStyle(
                                color: ColorConst.instance.kErrorColor,
                                fontSize: FontSizeConst.instance.small2),
                          )
                        : SizedBox(),
                    const Spacer(
                      flex: 100,
                    ),
                    SendAgainTextButton(true, false),
                  ],
                ),
              ),
            ),
    );
  }

  Widget sendMassage(SmsProvider myProvider) {
    if (context.smsPr.sendMassageActiv && myProvider.minut == 0) {
      context.smsPr.sendMassageActiv =
          myProvider.seconds == 0 && myProvider.minut == 0 ? false : true;
      return SendAgainTextButton(true, false);
    } else if (myProvider.minut == 0 && myProvider.seconds == 0) {
      return SendAgainTextButton(true, false);
    } else {
      return SizedBox();
    }
  }

  textCapasity(SmsProvider myProvider) {
    //  myProvider.capacity >= 3
    if (myProvider.capacity > 0) {
      return myProvider.seconds != 0
          ? Consumer<SmsProvider>(
              builder: (context, themeProvider, child) => Text(
                    "resending_code_after"
                        .locale
                        .replaceAll("SEKUND", " ${myProvider.seconds}"),
                    textAlign: TextAlign.center,
                    style: context.theme.bodyText2,
                  ))
          : Text(
              "sms_expired".locale,
              textAlign: TextAlign.left,
              style: FontstyleText.instance.smsErorTextStyle,
            );
    } else {
      if (context.smsPrStream.minut != 0) {
        return Consumer<SmsProvider>(builder: (context, themeProvider, child) {
          return Text(
            "lockout_time_minutes"
                .locale
                .replaceAll("MINUTES", "${myProvider.minut}"),
            textAlign: TextAlign.center,
            style: FontstyleText.instance.smsErorTextStyle,
          );
        });
      } else {
        return Text(
          "blocking_time_expired".locale,
          textAlign: TextAlign.center,
          style: FontstyleText.instance.smsErorTextStyle,
        );
      }
    }
  }
}
